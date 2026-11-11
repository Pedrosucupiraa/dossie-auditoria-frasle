# 04_codigo/45_consolidar_pts.R
# Consolida os PTs do intangível (PT02 complementar, PT03, PT04, PT05 e PT06) no esquema
# único de 7 colunas e elimina os arquivos duplicados "revisado".
#
#  * Fica um único arquivo por PT, com a versão revisada como conteúdo válido.
#  * As versões anteriores são copiadas para 02_papeis_trabalho/versoes_anteriores/
#    (nada é apagado sem cópia).
#  * Os dados que não cabem nas 7 colunas vão para os mesmos índices do script 44:
#      06_matrizes/detalhes_procedimentos_pts.csv e 06_matrizes/indice_papeis_trabalho.csv
#
# Rode DEPOIS do script 44. É seguro rodar mais de uma vez.

dir.create("06_matrizes", showWarnings = FALSE)
pasta <- "02_papeis_trabalho"
ant   <- file.path(pasta, "versoes_anteriores")
dir.create(ant, showWarnings = FALSE)

NUCLEO <- c("Codigo", "Norma", "Procedimento", "Natureza", "Evidencia", "Resultado", "Limitacao")
LIM <- "Trabalho acadêmico baseado em informações públicas e base sintética; não equivale a auditoria independente"
fmt <- function(x, d = 0) formatC(x, format = "f", digits = d, big.mark = ".", decimal.mark = ",")

ler <- function(caminho) {
  tryCatch(
    read.csv(caminho, stringsAsFactors = FALSE, fileEncoding = "UTF-8", check.names = FALSE),
    error = function(e)
      read.csv(caminho, stringsAsFactors = FALSE, fileEncoding = "latin1", check.names = FALSE))
}
p        <- function(nome) file.path(pasta, nome)
existe   <- function(nome) file.exists(p(nome))
arquivar <- function(nomes) for (n in nomes) if (existe(n)) file.copy(p(n), file.path(ant, n), overwrite = TRUE)
remover  <- function(nomes) for (n in nomes) if (existe(n)) file.remove(p(n))
grava    <- function(df, nome) write.csv(df, p(nome), row.names = FALSE, fileEncoding = "UTF-8")

# índices (mesmos arquivos do script 44)
arq_det <- "06_matrizes/detalhes_procedimentos_pts.csv"
arq_ind <- "06_matrizes/indice_papeis_trabalho.csv"
detalhes <- if (file.exists(arq_det)) ler(arq_det) else
  data.frame(Codigo = character(), Campo = character(), Valor = character(), stringsAsFactors = FALSE)
indice <- if (file.exists(arq_ind)) ler(arq_ind) else
  data.frame(arquivo = character(), Titulo = character(), Norma = character(),
             Objetivo_PT = character(), Preparador = character(), Data_elaboracao = character(),
             Revisor = character(), Data_revisao = character(), stringsAsFactors = FALSE)
add_det <- function(cod, campo, valor) {
  detalhes <<- detalhes[!(detalhes$Codigo == cod & detalhes$Campo == campo), ]
  detalhes <<- rbind(detalhes, data.frame(Codigo = cod, Campo = campo, Valor = as.character(valor),
                                          stringsAsFactors = FALSE))
}
add_ind <- function(arq, titulo, norma, objetivo, prep, data, rev, drev) {
  indice <<- indice[indice$arquivo != arq, ]
  indice <<- rbind(indice, data.frame(arquivo = arq, Titulo = titulo, Norma = norma,
                                      Objetivo_PT = objetivo, Preparador = prep,
                                      Data_elaboracao = data, Revisor = rev, Data_revisao = drev,
                                      stringsAsFactors = FALSE))
}

# ===================================================== PT02 complementar (NBC TA 540)
if (existe("PT02_procedimentos_complementares_revisado.csv")) {
  d <- ler(p("PT02_procedimentos_complementares_revisado.csv"))
  evid <- ifelse(is.na(d$fonte) | d$fonte == "", d$evidencia_disponivel,
                 paste0(d$evidencia_disponivel, " (fonte: ", d$fonte, ")"))
  novo <- data.frame(Codigo = sprintf("PT02C-%02d", seq_len(nrow(d))), Norma = "NBC TA 540",
                     Procedimento = d$procedimento, Natureza = d$classificacao,
                     Evidencia = evid, Resultado = d$resultado_atual, Limitacao = d$limitacao,
                     stringsAsFactors = FALSE)
  arquivar(c("PT02_procedimentos_complementares.csv", "PT02_procedimentos_complementares_revisado.csv"))
  remover("PT02_procedimentos_complementares_revisado.csv")
  grava(novo, "PT02_procedimentos_complementares.csv")
  cat("PT02 complementar consolidado (", nrow(novo), "linhas ). Códigos PT02C-xx para não colidir com o PT02.\n")
} else cat("PT02 complementar: nada a consolidar.\n")

# ============================================================ PT03 (Nota 18)
if (existe("PT03_nota18_intangivel.csv")) {
  d <- ler(p("PT03_nota18_intangivel.csv"))
  if (!identical(names(d), NUCLEO)) {
    novo <- data.frame(Codigo = d$codigo, Norma = "NBC TA 315 / NBC TA 500",
                       Procedimento = paste0("Examinar a divulgação da Nota 18 sobre: ", d$assunto),
                       Natureza = "Evidência pública", Evidencia = d$fonte,
                       Resultado = d$informacao_divulgada,
                       Limitacao = paste0("Transcrição a conferir com o PDF original; ", LIM),
                       stringsAsFactors = FALSE)
    arquivar("PT03_nota18_intangivel.csv")
    for (i in seq_len(nrow(d))) add_det(d$codigo[i], "risco_preliminar", d$risco_preliminar[i])
    grava(novo, "PT03_nota18_intangivel.csv")
    cat("PT03 padronizado (", nrow(novo), "linhas ). Risco preliminar guardado nos detalhes.\n")
  } else cat("PT03: já padronizado.\n")
}

# ============================================================ PT04 (movimentação)
if (existe("PT04_movimentacao_intangivel_revisado.csv")) {
  d <- ler(p("PT04_movimentacao_intangivel_revisado.csv"))
  n <- nrow(d)
  mov <- d[, c("item", "valor_R_mil", "natureza")]
  linhas <- data.frame(Codigo = sprintf("PT04-%02d", seq_len(n)), Norma = "NBC TA 500",
                       Procedimento = paste0("Transcrever da Nota 18: ", mov$item),
                       Natureza = "Evidência pública", Evidencia = mov$natureza,
                       Resultado = paste0("R$ ", fmt(mov$valor_R_mil), " mil"),
                       Limitacao = paste0("Transcrição a conferir com a Nota 18 original; ", LIM),
                       stringsAsFactors = FALSE)
  calc <- mov$valor_R_mil[1] + sum(mov$valor_R_mil[2:(n - 1)])
  fim  <- mov$valor_R_mil[n]
  soma <- data.frame(Codigo = sprintf("PT04-%02d", n + 1), Norma = "NBC TA 500",
                     Procedimento = "Somar as movimentações ao saldo inicial e comparar com o saldo final divulgado",
                     Natureza = "Evidência pública", Evidencia = "Itens transcritos acima",
                     Resultado = paste0("Saldo inicial mais movimentações = R$ ", fmt(calc), " mil; saldo final divulgado R$ ",
                                        fmt(fim), " mil; diferença de R$ ", fmt(calc - fim), " mil"),
                     Limitacao = LIM, stringsAsFactors = FALSE)
  concl <- data.frame(Codigo = sprintf("PT04-%02d", n + 2), Norma = "NBC TA 500",
                      Procedimento = "Registrar conclusão preliminar e limitações",
                      Natureza = "Conclusão documental", Evidencia = "Itens anteriores deste PT",
                      Resultado = "A soma aritmética fecha com o saldo divulgado; a igualdade não comprova a exatidão de cada movimentação transcrita, nem existência, mensuração ou recuperabilidade",
                      Limitacao = LIM, stringsAsFactors = FALSE)
  arquivar(c("PT04_movimentacao_intangivel.csv", "PT04_movimentacao_intangivel_revisado.csv"))
  remover("PT04_movimentacao_intangivel_revisado.csv")
  grava(rbind(linhas, soma, concl), "PT04_movimentacao_intangivel.csv")
  cat("PT04 consolidado (", n + 2, "linhas ).\n")
} else cat("PT04: nada a consolidar.\n")

# ============================================================ PT05 (reconciliação)
if (existe("PT05_conclusao_reconciliacao_revisada.csv")) {
  r <- ler(p("PT05_conclusao_reconciliacao_revisada.csv"))
  o <- if (existe("PT05_conclusao_reconciliacao.csv")) ler(p("PT05_conclusao_reconciliacao.csv")) else NULL
  pega_o <- function(item) {
    if (is.null(o) || !all(c("item", "descricao") %in% names(o))) return("(texto original arquivado)")
    v <- o$descricao[o$item == item]
    if (length(v) == 0) "(texto original arquivado)" else v[1]
  }
  novo <- data.frame(
    Codigo = sprintf("PT05-%02d", 1:4), Norma = "NBC TA 500",
    Procedimento = c(r$procedimento[1],
                     "Interpretar a variação do saldo entre 2024 e 2025",
                     "Conferir cada movimentação com a tabela completa e planejar testes sobre aquisições, ágio e amortização",
                     "Registrar conclusão preliminar e limitações"),
    Natureza = c("Evidência pública", "Análise documental", "Planejado - não executado", "Conclusão documental"),
    Evidencia = c(r$fonte[1], "Nota 18 e PT04", "Nota 18 original e registros internos (não disponibilizados)",
                  "Itens anteriores deste PT"),
    Resultado = c(paste0("Saldo inicial R$ ", fmt(r$saldo_inicial_R_mil[1]), " mil + movimentações R$ ",
                         fmt(r$movimentacoes_liquidas_R_mil[1]), " mil = R$ ", fmt(r$saldo_calculado_R_mil[1]),
                         " mil; saldo divulgado R$ ", fmt(r$saldo_divulgado_R_mil[1]), " mil; diferença de R$ ",
                         fmt(r$diferenca_R_mil[1]), " mil"),
                  pega_o("Interpretacao"),
                  "Testes sobre aquisições, ágio e amortização não executados",
                  pega_o("Limitacao")),
    Limitacao = c(r$limitacao[1], LIM, LIM, LIM), stringsAsFactors = FALSE)
  arquivar(c("PT05_conclusao_reconciliacao.csv", "PT05_conclusao_reconciliacao_revisada.csv"))
  remover("PT05_conclusao_reconciliacao_revisada.csv")
  grava(novo, "PT05_conclusao_reconciliacao.csv")
  cat("PT05 consolidado (", nrow(novo), "linhas ).\n")
} else cat("PT05: nada a consolidar.\n")

# ============================================================ PT06 (visão geral do intangível)
if (existe("PT06_auditoria_intangivel.csv")) {
  d <- ler(p("PT06_auditoria_intangivel.csv"))
  if (identical(names(d), c("campo", "descricao"))) {
    v <- setNames(d$descricao, d$campo)
    g <- function(k) if (k %in% names(v)) v[[k]] else ""
    novo <- data.frame(
      Codigo = sprintf("PT06-%02d", 1:4), Norma = g("Normas relacionadas"),
      Procedimento = c("Identificar riscos e asserções relevantes do intangível",
                       "Validar a base sintética (quantidade de registros, IDs únicos, log de erros e reconciliação ao saldo)",
                       "Executar testes de exceção sobre a base sintética",
                       "Registrar conclusão e próximos procedimentos"),
      Natureza = c("Análise documental", "Simulação (base sintética)", "Simulação (base sintética)",
                   "Conclusão documental"),
      Evidencia = c(g("Origem do saldo"), g("Fonte da populacao"),
                    "05_resultados/resumo_geral_excecoes.csv; comparacao_erros_teste.csv",
                    "Itens anteriores deste PT"),
      Resultado = c(paste0("Asserções: ", g("Assercoes relevantes"), " Riscos: ", g("Riscos identificados")),
                    g("Resultados"), g("Excecoes identificadas"),
                    paste0(g("Conclusao"), " Próximos procedimentos: ", g("Proximos procedimentos"))),
      Limitacao = c(LIM, g("Limitacoes"), LIM, g("Limitacoes")), stringsAsFactors = FALSE)
    arquivar("PT06_auditoria_intangivel.csv")
    for (k in c("Conta auditada", "Saldo de referencia", "Objetivo", "Populacao analisada",
                "Procedimentos executados", "Evidencias e referencias cruzadas"))
      add_det("PT06", k, g(k))
    add_ind("PT06_auditoria_intangivel.csv", g("Titulo"), g("Normas relacionadas"), g("Objetivo"),
            sub("^Matricula ", "", g("Preparador")), g("Data de elaboracao"), g("Revisor"), NA)
    grava(novo, "PT06_auditoria_intangivel.csv")
    cat("PT06 padronizado (", nrow(novo), "linhas ). Metadados guardados nos índices.\n")
  } else cat("PT06: já padronizado.\n")
}

write.csv(detalhes, arq_det, row.names = FALSE, fileEncoding = "UTF-8")
write.csv(indice, arq_ind, row.names = FALSE, fileEncoding = "UTF-8")

# ------------------------------------------------- verificação do esquema final
todos <- list.files(pasta, pattern = "^PT.*\\.csv$")
fora  <- character()
for (a in todos) if (!identical(names(ler(file.path(pasta, a))), NUCLEO)) fora <- c(fora, a)
cat("\nArquivos PT fora do esquema de 7 colunas:\n")
if (length(fora) == 0) cat("  nenhum\n") else cat(paste0("  - ", fora, "\n"), sep = "")
cat("Versões anteriores preservadas em", ant, "\n")
