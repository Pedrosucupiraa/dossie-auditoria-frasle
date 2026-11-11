# 04_codigo/46_padronizar_natureza.R
# Padroniza a coluna Natureza dos papéis de trabalho em quatro rótulos fixos:
#   1. Evidência pública                       (dado das demonstrações publicadas ou cálculo sobre elas)
#   2. Planejado - não executado               (depende de acesso que não existiu ou está pendente)
#   3. Simulação                               (base sintética ou premissas hipotéticas)
#   4. Conceitual ou preliminar (sem teste)    (conceito, delimitação de escopo, triagem de risco)
#
# O texto original de cada linha NÃO se perde:
#   * 06_matrizes/detalhes_procedimentos_pts.csv  (Campo = "Natureza_original")
#   * 06_matrizes/log_padronizacao_natureza.csv   (arquivo, Codigo, original, novo)
#
# Rode DEPOIS do 45 (e do 18, 41 e 14) e ANTES do 39. Pode rodar mais de uma vez.

ROT <- c("Evidência pública", "Planejado - não executado", "Simulação",
         "Conceitual ou preliminar (sem teste)")
pasta <- "02_papeis_trabalho"

sem_acento <- function(x)
  chartr("áàâãäéèêëíìîïóòôõöúùûüç", "aaaaaeeeeiiiiooooouuuuc", tolower(x))

classifica <- function(x) {
  t <- sem_acento(x)
  if (grepl("simula", t)) return(ROT[3])
  if (grepl("planejad|planejamento|a realizar|nao executad|pendente|a confirmar", t)) return(ROT[2])
  if (grepl("conceitual|diretriz|delimitacao|limitacao|preliminar|triagem|risco|arquivos do projeto", t))
    return(ROT[4])
  ROT[1]
}

ler <- function(f) tryCatch(
  read.csv(f, stringsAsFactors = FALSE, fileEncoding = "UTF-8", check.names = FALSE),
  error = function(e) read.csv(f, stringsAsFactors = FALSE, fileEncoding = "latin1", check.names = FALSE))

arq_det <- "06_matrizes/detalhes_procedimentos_pts.csv"
arq_log <- "06_matrizes/log_padronizacao_natureza.csv"
detalhes <- if (file.exists(arq_det)) ler(arq_det) else
  data.frame(Codigo = character(), Campo = character(), Valor = character(), stringsAsFactors = FALSE)
log_ant <- if (file.exists(arq_log)) ler(arq_log) else
  data.frame(arquivo = character(), Codigo = character(), original = character(),
             novo = character(), stringsAsFactors = FALSE)

novas <- NULL
for (f in list.files(pasta, pattern = "^PT.*\\.csv$")) {
  df <- ler(file.path(pasta, f))
  if (!"Natureza" %in% names(df)) { cat("Sem coluna Natureza (ignorado):", f, "\n"); next }
  orig <- as.character(df$Natureza)
  novo <- vapply(orig, classifica, character(1), USE.NAMES = FALSE)
  mudou <- orig != novo
  if (!any(mudou)) next
  novas <- rbind(novas, data.frame(arquivo = f, Codigo = df$Codigo[mudou],
                                   original = orig[mudou], novo = novo[mudou],
                                   stringsAsFactors = FALSE))
  df$Natureza <- novo
  write.csv(df, file.path(pasta, f), row.names = FALSE, fileEncoding = "UTF-8")
}

if (!is.null(novas)) {
  detalhes <- detalhes[!(detalhes$Campo == "Natureza_original" & detalhes$Codigo %in% novas$Codigo), ]
  detalhes <- rbind(detalhes, data.frame(Codigo = novas$Codigo, Campo = "Natureza_original",
                                         Valor = novas$original, stringsAsFactors = FALSE))
  write.csv(detalhes, arq_det, row.names = FALSE, fileEncoding = "UTF-8")
  write.csv(rbind(log_ant, novas), arq_log, row.names = FALSE, fileEncoding = "UTF-8")
  cat("Linhas padronizadas:", nrow(novas), "em", length(unique(novas$arquivo)), "arquivos\n")
} else {
  cat("Nada a padronizar: a coluna Natureza já está nos quatro rótulos.\n")
}

# verificação
todos <- unlist(lapply(list.files(pasta, pattern = "^PT.*\\.csv$", full.names = TRUE),
                       function(f) as.character(ler(f)$Natureza)))
cat("\nNatureza nos PTs (", length(todos), "linhas ):\n", sep = "")
print(table(todos))
fora <- setdiff(unique(todos), ROT)
cat("Valores fora dos quatro rótulos:", if (length(fora) == 0) "nenhum" else paste(fora, collapse = "; "), "\n")
