
# Validacao da base sintetica de intangivel
# Valores monetarios em R$ mil

base <- read.csv(
  "03_base_sintetica/base_sintetica_intangivel.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

log_erros <- read.csv(
  "03_base_sintetica/log_erros_inseridos.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

saldo_referencia <- 1874550

quantidade <- nrow(base)
ids_unicos <- length(unique(base$id_registro))
quantidade_erros <- sum(base$erro_inserido == TRUE)
quantidade_log <- nrow(log_erros)
soma_valor_liquido <- sum(base$valor_contabil_mil, na.rm = TRUE)

cat("Quantidade de registros:", quantidade, "\n")
cat("IDs unicos:", ids_unicos, "\n")
cat("Erros marcados na base:", quantidade_erros, "\n")
cat("Linhas no log de erros:", quantidade_log, "\n")
cat("Soma do valor contabil (R$ mil):",
    round(soma_valor_liquido, 2), "\n")
cat("Saldo de referencia (R$ mil):",
    saldo_referencia, "\n")
cat("Diferenca para o saldo de referencia (R$ mil):",
    round(soma_valor_liquido - saldo_referencia, 2), "\n")

cat("\nBase com 500 mil registros? ", quantidade == 500000, "\n")
cat("Todos os IDs sao unicos? ", quantidade == ids_unicos, "\n")
cat("Base e log contem os mesmos erros? ",
    quantidade_erros == quantidade_log, "\n")
cat("Saldo reconciliado? ",
    abs(soma_valor_liquido - saldo_referencia) < 0.01, "\n")
# 
