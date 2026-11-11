# 04_codigo/19_investigar_erros_nao_detectados.R
# Investiga os erros inseridos que cada teste, ISOLADAMENTE, não detectou.
# Base exclusivamente sintética, para fins acadêmicos.
#
# Correção: a versão anterior comparava com registros_sinalizados.csv, que reúne os
# registros sinalizados por QUALQUER dos três testes (inclui ~100 mil "Nao avaliado"),
# e por isso o resultado saía vazio. Aqui cada erro é confrontado com o SEU teste:
#   * vida útil: vida_util_anos < 3 e tipo_intangivel != "Goodwill" (mesma regra do script 11)
#   * amortização: |acumulada - esperada| > tolerância (a base grava 6 casas decimais)
# Rode depois do script 11.

erros <- read.csv("03_base_sintetica/log_erros_inseridos.csv", fileEncoding = "UTF-8")

TOL <- 2e-6   # tolerância de arredondamento (6 casas decimais)

teste_vida_util <- !is.na(erros$vida_util_anos) & erros$vida_util_anos < 3 &
  erros$tipo_intangivel != "Goodwill"
teste_amort <- abs(erros$amortizacao_acumulada_mil - erros$amortizacao_esperada_mil) > TOL

vu   <- erros[erros$tipo_erro == "Vida util inadequada", ]
vu_nd <- vu[!teste_vida_util[erros$tipo_erro == "Vida util inadequada"], ]
am   <- erros[erros$tipo_erro == "Amortizacao inconsistente", ]
am_nd <- am[!teste_amort[erros$tipo_erro == "Amortizacao inconsistente"], ]

cat("Vida útil: inseridos", nrow(vu), "| detectados pelo teste", nrow(vu) - nrow(vu_nd),
    "| NÃO detectados", nrow(vu_nd), "\n")
cat("Amortização: inseridos", nrow(am), "| detectados pelo teste", nrow(am) - nrow(am_nd),
    "| NÃO detectados", nrow(am_nd), "\n")

cat("\nVida útil não detectada, por tipo de intangível:\n")
print(table(vu_nd$tipo_intangivel, useNA = "ifany"))
cat("\nAmortização não detectada, por tipo de intangível:\n")
print(table(am_nd$tipo_intangivel, useNA = "ifany"))

cat("\nValor original dos não detectados (R$ mil): vida útil =",
    round(sum(vu_nd$valor_original_mil), 2), "| amortização =",
    round(sum(am_nd$valor_original_mil), 2), "\n")

cat("\nLeitura: os erros não detectados são de Goodwill, excluído do teste de vida útil",
    "\npor regra (goodwill tem vida útil indefinida, testado por impairment).",
    "\nO limite é do desenho do teste, não falha de execução.\n")

dir.create("05_resultados", showWarnings = FALSE)
write.csv(vu_nd, "05_resultados/erros_vida_util_nao_detectados.csv",
          row.names = FALSE, fileEncoding = "UTF-8")
write.csv(am_nd, "05_resultados/erros_amortizacao_nao_detectados.csv",
          row.names = FALSE, fileEncoding = "UTF-8")
cat("\nGravados: erros_vida_util_nao_detectados.csv (", nrow(vu_nd), ") e ",
    "erros_amortizacao_nao_detectados.csv (", nrow(am_nd), ")\n", sep = "")
