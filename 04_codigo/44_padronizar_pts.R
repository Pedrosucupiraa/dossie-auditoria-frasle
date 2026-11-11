# 04_codigo/44_padronizar_pts.R
# Padroniza os papéis de trabalho em CSV no esquema único de 7 colunas:
#   Codigo, Norma, Procedimento, Natureza, Evidencia, Resultado, Limitacao
#
# As colunas que saem NÃO são perdidas:
#   * por procedimento (Tema, Risco, Referências cruzadas, Status, Área)
#       -> 06_matrizes/detalhes_procedimentos_pts.csv  (formato longo: Codigo, Campo, Valor)
#   * por papel (Título, Objetivo, Preparador, Data, Revisor, Data da revisão)
#       -> 06_matrizes/indice_papeis_trabalho.csv
#
# Rode DEPOIS dos scripts 26, 32, 33 e 38 (que regravam PT13, PT19, PT20 e PT24).
# É seguro rodar mais de uma vez: arquivos já padronizados são ignorados.

dir.create("06_matrizes", showWarnings = FALSE)

NUCLEO <- c("Codigo", "Norma", "Procedimento", "Natureza", "Evidencia", "Resultado", "Limitacao")
pasta  <- "02_papeis_trabalho"

arquivos <- c("PT14_saldos_iniciais.csv", "PT15_itens_selecionados.csv",
              "PT16_confirmacoes_externas.csv", "PT18_objetivos_auditor.csv",
              "PT19_termos_trabalho.csv", "PT20_organizacoes_servicos.csv",
              "PT21_representacoes_formais.csv", "PT22_estrutura_conceitual.csv",
              "PT23_gestao_qualidade.csv", "PT24_auditoria_grupo.csv")

ler <- function(caminho) {
  tryCatch(
    read.csv(caminho, stringsAsFactors = FALSE, fileEncoding = "UTF-8", check.names = FALSE),
    error = function(e)
      read.csv(caminho, stringsAsFactors = FALSE, fileEncoding = "latin1", check.names = FALSE))
}

pega <- function(df, nome) if (nome %in% names(df)) as.character(df[[nome]][1]) else NA_character_

para_longo <- function(codigos, df, campos) {
  campos <- intersect(campos, names(df))
  if (length(campos) == 0) return(NULL)
  do.call(rbind, lapply(campos, function(cp)
    data.frame(Codigo = codigos, Campo = cp, Valor = as.character(df[[cp]]),
               stringsAsFactors = FALSE)))
}

# ---------------------------------------------------------- índices existentes
arq_det <- "06_matrizes/detalhes_procedimentos_pts.csv"
arq_ind <- "06_matrizes/indice_papeis_trabalho.csv"
detalhes <- if (file.exists(arq_det)) ler(arq_det) else
  data.frame(Codigo = character(), Campo = character(), Valor = character(), stringsAsFactors = FALSE)
indice <- if (file.exists(arq_ind)) ler(arq_ind) else
  data.frame(arquivo = character(), Titulo = character(), Norma = character(),
             Objetivo_PT = character(), Preparador = character(), Data_elaboracao = character(),
             Revisor = character(), Data_revisao = character(), stringsAsFactors = FALSE)

# ------------------------------------------------------------------ conversão
for (arq in arquivos) {
  caminho <- file.path(pasta, arq)
  if (!file.exists(caminho)) { cat("Não encontrado (ignorado):", arq, "\n"); next }
  df <- ler(caminho)
  
  if (identical(names(df), NUCLEO)) { cat("Já padronizado:", arq, "\n"); next }
  
  if ("Referencia" %in% names(df) && "Itens_utilizados" %in% names(df)) {
    # Layout do PT22 (Estrutura Conceitual)
    cod  <- df$Referencia
    nucleo <- data.frame(
      Codigo = cod, Norma = df$Norma,
      Procedimento = paste0(df$Tema, ": ", df$Procedimento_evidencia),
      Natureza = "Conceitual (estrutura conceitual)",
      Evidencia = df$Itens_utilizados,
      Resultado = paste(df$Analise, df$Resultado),
      Limitacao = df$Limitacoes, stringsAsFactors = FALSE)
    extras <- para_longo(cod, df, c("Tema"))
    meta <- data.frame(arquivo = arq, Titulo = pega(df, "Titulo"), Norma = pega(df, "Norma"),
                       Objetivo_PT = NA_character_, Preparador = pega(df, "Preparador"),
                       Data_elaboracao = pega(df, "Data_preparacao"),
                       Revisor = pega(df, "Revisor"), Data_revisao = pega(df, "Data_revisao"),
                       stringsAsFactors = FALSE)
  } else {
    # Layouts de 17 colunas (Evidencia_ou_fonte) e de 8 colunas (Area + Evidencia)
    evid <- if ("Evidencia_ou_fonte" %in% names(df)) df$Evidencia_ou_fonte else df$Evidencia
    cod  <- df$Codigo
    nucleo <- data.frame(
      Codigo = cod, Norma = df$Norma, Procedimento = df$Procedimento,
      Natureza = df$Natureza, Evidencia = evid, Resultado = df$Resultado,
      Limitacao = df$Limitacao, stringsAsFactors = FALSE)
    extras <- para_longo(cod, df, c("Tema", "Risco_ou_aspecto_avaliado", "Referencias_cruzadas",
                                    "Status_procedimento", "Area"))
    meta <- data.frame(arquivo = arq, Titulo = pega(df, "Titulo"), Norma = pega(df, "Norma"),
                       Objetivo_PT = pega(df, "Objetivo_PT"), Preparador = pega(df, "Preparador"),
                       Data_elaboracao = pega(df, "Data_elaboracao"),
                       Revisor = pega(df, "Revisor"), Data_revisao = pega(df, "Data_revisao"),
                       stringsAsFactors = FALSE)
  }
  
  # guarda os dados que saem do CSV antes de sobrescrevê-lo
  detalhes <- detalhes[!(detalhes$Codigo %in% cod), ]
  if (!is.null(extras)) detalhes <- rbind(detalhes, extras)
  indice <- indice[indice$arquivo != arq, ]
  indice <- rbind(indice, meta)
  
  write.csv(nucleo, caminho, row.names = FALSE, fileEncoding = "UTF-8")
  cat("Padronizado:", arq, "(", nrow(nucleo), "linhas )\n")
}

write.csv(detalhes, arq_det, row.names = FALSE, fileEncoding = "UTF-8")
write.csv(indice, arq_ind, row.names = FALSE, fileEncoding = "UTF-8")
cat("Detalhes preservados em", arq_det, "(", nrow(detalhes), "linhas )\n")
cat("Índice dos PTs em", arq_ind, "(", nrow(indice), "papéis )\n")

# ------------------------------------------------- verificação do esquema final
todos <- list.files(pasta, pattern = "^PT.*\\.csv$")
fora  <- character()
for (a in todos) {
  if (!identical(names(ler(file.path(pasta, a))), NUCLEO)) fora <- c(fora, a)
}
cat("\nArquivos PT fora do esquema de 7 colunas:\n")
if (length(fora) == 0) cat("  nenhum\n") else cat(paste0("  - ", fora, "\n"), sep = "")
cat("(PT03 a PT06 e as versões 'revisado' têm natureza própria e são tratados na consolidação.)\n")
