
# PROGRAMA 10 - Analise inicial de excecoes
# Base sintetica para fins educacionais.
# Nao representa teste sobre registros reais da empresa.

base <- read.csv(
  "03_base_sintetica/base_sintetica_intangivel.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

# 1. Quantidade de registros por tipo de ativo intangivel
por_tipo <- as.data.frame(
  table(base$tipo_intangivel),
  stringsAsFactors = FALSE
)

names(por_tipo) <- c("tipo_intangivel", "quantidade")

# 2. Registros marcados com erro inserido
erros <- base[base$erro_inserido == TRUE, ]

# 3. Resumo dos erros inseridos por categoria
resumo_erros <- as.data.frame(
  table(erros$tipo_erro),
  stringsAsFactors = FALSE
)

names(resumo_erros) <- c("tipo_erro", "quantidade")

# 4. Registros sem indicador de impairment
sem_indicador <- sum(
  is.na(base$indicador_impairment) |
    base$indicador_impairment == "",
  na.rm = TRUE
)

# 5. Registros com vida util de dois anos
vida_util_dois <- sum(base$vida_util_anos == 2, na.rm = TRUE)

# 6. Resumo geral
resumo_geral <- data.frame(
  total_registros = nrow(base),
  total_erros_inseridos = sum(base$erro_inserido == TRUE),
  registros_sem_indicador_impairment = sem_indicador,
  registros_com_vida_util_dois_anos = vida_util_dois
)


# 6A. Conferir os erros de amortizacao inseridos
log_erros <- read.csv(
  "03_base_sintetica/log_erros_inseridos.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

erros_amortizacao <- log_erros[
  log_erros$tipo_erro == "Amortizacao inconsistente",
]

# Conferir se os IDs desses erros existem na base atual
ids_amortizacao <- erros_amortizacao$id_registro

registros_amortizacao <- base[
  base$id_registro %in% ids_amortizacao,
]

# Resumo da verificacao
resumo_amortizacao <- data.frame(
  erros_no_log = length(ids_amortizacao),
  registros_encontrados_na_base = nrow(registros_amortizacao),
  registros_com_erro_marcado = sum(
    registros_amortizacao$erro_inserido == TRUE,
    na.rm = TRUE
  )
)

print(resumo_amortizacao)


# 7. Salvar resultados
write.csv(
  por_tipo,
  "05_resultados/analise_por_tipo_intangivel.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

write.csv(
  resumo_erros,
  "05_resultados/resumo_erros_inseridos.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

write.csv(
  resumo_geral,
  "05_resultados/resumo_geral_excecoes.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

print(resumo_geral)
print(resumo_erros)

cat("\nArquivos de resultados criados.\n")
