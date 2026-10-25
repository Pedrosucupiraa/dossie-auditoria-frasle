
# Projeto: Auditoria 1 - Frasle Mobility S.A.
# Base 100% sintetica para fins educacionais
# Os registros NAO representam lancamentos reais da empresa.

set.seed(241003375)

n <- 500000
saldo_referencia <- 1874550 # R$ mil, divulgado em 2025

tipos <- c(
  "Software e licencas",
  "Relacionamento com clientes",
  "Marcas",
  "Goodwill",
  "Intangivel em andamento"
)

tipo <- sample(
  tipos,
  size = n,
  replace = TRUE,
  prob = c(0.08, 0.30, 0.25, 0.32, 0.05)
)

data_reconhecimento <- sample(
  seq(as.Date("2010-01-01"), as.Date("2025-12-31"), by = "day"),
  size = n,
  replace = TRUE
)

valor_original <- runif(n, min = 0.01, max = 20)

vida_util <- ifelse(
  tipo == "Goodwill",
  NA,
  sample(c(3, 5, 6, 10, 15, 20), n, replace = TRUE)
)

taxa_amortizacao <- ifelse(
  is.na(vida_util), 0, 1 / vida_util
)

anos_decorridos <- pmax(
  0,
  as.numeric(as.Date("2025-12-31") - data_reconhecimento) / 365.25
)

amortizacao <- pmin(
  valor_original,
  valor_original * taxa_amortizacao * anos_decorridos
)

# O goodwill nao e amortizado nesta simulacao.
# Os valores ainda serao ajustados para reconciliacao matematica.
valor_liquido <- pmax(0, valor_original - amortizacao)

# Ajustar a escala para a soma liquida coincidir com o saldo divulgado.
fator_escala <- saldo_referencia / sum(valor_liquido)

valor_original <- valor_original * fator_escala
amortizacao <- amortizacao * fator_escala
valor_liquido <- valor_liquido * fator_escala

# Guardar a amortizacao esperada antes de inserir os erros.
amortizacao_esperada <- amortizacao


# Registrar erros intencionais em 250 registros.
erro_inserido <- rep(FALSE, n)
tipo_erro <- rep(NA_character_, n)

ids_erro <- sample(seq_len(n), 250)
erro_inserido[ids_erro] <- TRUE

grupo_erro <- sample(
  c("Vida util inadequada", "Amortizacao inconsistente",
    "Indicador de impairment ausente"),
  250,
  replace = TRUE
)

tipo_erro[ids_erro] <- grupo_erro

vida_util[ids_erro[grupo_erro == "Vida util inadequada"]] <- 2

ids_amort <- ids_erro[grupo_erro == "Amortizacao inconsistente"]
amortizacao[ids_amort] <- amortizacao[ids_amort] * 0.5
valor_liquido[ids_amort] <- valor_original[ids_amort] - amortizacao[ids_amort]

base <- data.frame(
  id_registro = seq_len(n),
  tipo_intangivel = tipo,
  unidade_geradora_caixa = sample(
    paste0("UGC_", sprintf("%02d", 1:20)),
    n, replace = TRUE
  ),
  data_reconhecimento = data_reconhecimento,
  valor_original_mil = round(valor_original, 6),
  vida_util_anos = vida_util,
  amortizacao_acumulada_mil = round(amortizacao, 6),
  amortizacao_esperada_mil = round(amortizacao_esperada, 6),
  valor_contabil_mil = round(valor_liquido, 6),
  indicador_impairment = sample(
    c("Sim", "Nao", "Nao avaliado"),
    n, replace = TRUE, prob = c(0.15, 0.65, 0.20)
  ),
  erro_inserido = erro_inserido,
  tipo_erro = tipo_erro,
  origem_dado = "SINTETICO - NAO E DADO REAL DA FRASLE",
  stringsAsFactors = FALSE
)

# Marcar indicador ausente nos erros correspondentes.
ids_impairment <- ids_erro[
  grupo_erro == "Indicador de impairment ausente"
]
base$indicador_impairment[ids_impairment] <- NA

dir.create("03_base_sintetica", showWarnings = FALSE)
dir.create("05_resultados", showWarnings = FALSE)

write.csv(
  base,
  "03_base_sintetica/base_sintetica_intangivel.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

log_erros <- base[base$erro_inserido, ]

write.csv(
  log_erros,
  "03_base_sintetica/log_erros_inseridos.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Quantidade de registros:", nrow(base), "\n")
cat("Total liquido antes dos erros (R$ mil):",
    round(saldo_referencia, 2), "\n")
cat("Quantidade de erros inseridos:", sum(base$erro_inserido), "\n")
cat("Base salva? ",
    file.exists("03_base_sintetica/base_sintetica_intangivel.csv"), "\n")
cat("Log salvo? ",
    file.exists("03_base_sintetica/log_erros_inseridos.csv"), "\n")


# ETAPA FINAL - Calibrar a base ao saldo de referencia
# A calibracao e sintetica e nao substitui a validacao dos registros.

saldo_referencia <- 1874550

soma_atual <- sum(base$valor_contabil_mil, na.rm = TRUE)

fator_ajuste <- saldo_referencia / soma_atual

base$valor_original_mil <- base$valor_original_mil * fator_ajuste
base$amortizacao_acumulada_mil <- base$amortizacao_acumulada_mil * fator_ajuste
base$amortizacao_esperada_mil <-
  base$amortizacao_esperada_mil * fator_ajuste
base$valor_contabil_mil <- base$valor_contabil_mil * fator_ajuste

# Arredondar os valores para manter a precisao definida na base
base$valor_original_mil <- round(base$valor_original_mil, 6)
base$amortizacao_acumulada_mil <- round(base$amortizacao_acumulada_mil, 6)
base$valor_contabil_mil <- round(base$valor_contabil_mil, 6)
base$amortizacao_esperada_mil <-
  round(base$amortizacao_esperada_mil, 6)

# Recalcular o saldo de uma linha para compensar a diferenca de arredondamento
diferenca_final <- saldo_referencia - sum(base$valor_contabil_mil, na.rm = TRUE)

base$valor_contabil_mil[1] <- base$valor_contabil_mil[1] + diferenca_final

# Salvar novamente a base ajustada
write.csv(
  base,
  "03_base_sintetica/base_sintetica_intangivel.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Saldo apos ajuste:", sum(base$valor_contabil_mil, na.rm = TRUE), "\n")
cat("Diferenca final:", saldo_referencia - sum(base$valor_contabil_mil, na.rm = TRUE), "\n")