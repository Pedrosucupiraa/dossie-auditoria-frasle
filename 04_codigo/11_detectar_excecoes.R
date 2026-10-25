
# PROGRAMA 11 - Deteccao independente de excecoes
# Base 100% sintetica para fins educacionais.
# Os resultados nao representam auditoria de registros reais.

base <- read.csv(
  "03_base_sintetica/base_sintetica_intangivel.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

# TESTE 1 - Vida util inferior a tres anos
# Goodwill e tratado separadamente, pois nao e amortizado.
excecao_vida_util <- (
  !is.na(base$vida_util_anos) &
    base$vida_util_anos < 3 &
    base$tipo_intangivel != "Goodwill"
)

# TESTE 2 - Indicador de impairment ausente ou nao avaliado
excecao_impairment <- (
  is.na(base$indicador_impairment) |
    base$indicador_impairment == "" |
    base$indicador_impairment == "Nao avaliado"
)

# TESTE 3 - Amortizacao diferente da referencia sintetica
tolerancia <- 0.000002

excecao_amortizacao <- (
  !is.na(base$amortizacao_acumulada_mil) &
    !is.na(base$amortizacao_esperada_mil) &
    abs(
      base$amortizacao_acumulada_mil -
        base$amortizacao_esperada_mil
    ) > tolerancia
)

# CONSOLIDAR OS RESULTADOS
resultado <- data.frame(
  id_registro = base$id_registro,
  tipo_intangivel = base$tipo_intangivel,
  vida_util_anos = base$vida_util_anos,
  indicador_impairment = base$indicador_impairment,
  excecao_vida_util = excecao_vida_util,
  excecao_impairment = excecao_impairment,
  excecao_amortizacao = excecao_amortizacao,
  erro_inserido = base$erro_inserido,
  stringsAsFactors = FALSE
)

# SALVAR TODOS OS REGISTROS SINALIZADOS
sinalizado <- (
  excecao_vida_util |
    excecao_impairment |
    excecao_amortizacao
)

write.csv(
  resultado[sinalizado, ],
  "05_resultados/registros_sinalizados.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# RESUMO DOS TESTES
resumo <- data.frame(
  teste = c(
    "Vida util inferior a tres anos",
    "Indicador de impairment ausente ou nao avaliado",
    "Amortizacao diferente da referencia sintetica"
  ),
  registros_sinalizados = c(
    sum(excecao_vida_util, na.rm = TRUE),
    sum(excecao_impairment, na.rm = TRUE),
    sum(excecao_amortizacao, na.rm = TRUE)
  )
)

write.csv(
  resumo,
  "05_resultados/resumo_deteccao_independente.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

print(resumo)

cat(
  "\nTotal de registros com ao menos uma sinalizacao:",
  sum(sinalizado, na.rm = TRUE),
  "\n"
)

# COMPARACAO COM O LOG DE ERROS INSERIDOS
log_erros <- read.csv(
  "03_base_sintetica/log_erros_inseridos.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

ids_vida_util <- log_erros$id_registro[
  log_erros$tipo_erro == "Vida util inadequada"
]

ids_impairment <- log_erros$id_registro[
  log_erros$tipo_erro == "Indicador de impairment ausente"
]

ids_amortizacao <- log_erros$id_registro[
  log_erros$tipo_erro == "Amortizacao inconsistente"
]

comparacao <- data.frame(
  categoria = c(
    "Vida util inadequada",
    "Indicador de impairment ausente",
    "Amortizacao inconsistente"
  ),
  erros_inseridos = c(
    length(ids_vida_util),
    length(ids_impairment),
    length(ids_amortizacao)
  ),
  erros_sinalizados_pelo_teste = c(
    sum(
      resultado$id_registro %in% ids_vida_util &
        resultado$excecao_vida_util
    ),
    sum(
      resultado$id_registro %in% ids_impairment &
        resultado$excecao_impairment
    ),
    sum(
      resultado$id_registro %in% ids_amortizacao &
        resultado$excecao_amortizacao
    )
  )
)

comparacao$taxa_deteccao_pct <- round(
  100 * comparacao$erros_sinalizados_pelo_teste /
    comparacao$erros_inseridos,
  2
)

print(comparacao)

write.csv(
  comparacao,
  "05_resultados/comparacao_erros_teste.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("\nPrograma 11 concluido.\n")


# INVESTIGACAO DOS ERROS NAO DETECTADOS

# Vida util
erros_vida <- log_erros[
  log_erros$tipo_erro == "Vida util inadequada",
]

vida_nao_detectada <- erros_vida[
  !(erros_vida$id_registro %in%
      resultado$id_registro[
        resultado$excecao_vida_util
      ]),
]

cat("\nErros de vida util nao detectados:",
    nrow(vida_nao_detectada), "\n")

print(table(
  vida_nao_detectada$tipo_intangivel,
  useNA = "ifany"
))

# Amortizacao
erros_amort <- log_erros[
  log_erros$tipo_erro == "Amortizacao inconsistente",
]

amort_nao_detectada <- erros_amort[
  !(erros_amort$id_registro %in%
      resultado$id_registro[
        resultado$excecao_amortizacao
      ]),
]

cat("\nErros de amortizacao nao detectados:",
    nrow(amort_nao_detectada), "\n")

cat("Registros com amortizacao esperada igual a zero:",
    sum(amort_nao_detectada$amortizacao_esperada_mil == 0,
        na.rm = TRUE), "\n")

cat("Registros com amortizacao registrada igual a zero:",
    sum(amort_nao_detectada$amortizacao_acumulada_mil == 0,
        na.rm = TRUE), "\n")

