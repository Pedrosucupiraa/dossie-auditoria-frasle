
# ============================================================
# PROJETO: P2 - Auditoria 1
# OBJETIVO: Revisar a movimentacao do intangivel consolidado
# FONTE: Demonstracoes financeiras de 2025, Nota 18
# VALORES EM: R$ mil
# ============================================================

movimentacao <- data.frame(
  item = c(
    "Saldo inicial de 2025",
    "Adicao por combinacao de negocios - custo",
    "Aquisicoes",
    "Baixas do custo",
    "Variacao cambial do custo",
    "Efeito de hiperinflação do custo",
    "Mais-valia na combinacao de negocios",
    "Agio na combinacao de negocios",
    "Despesa de amortizacao do exercicio",
    "Adicao por combinacao de negocios - amortizacao",
    "Baixas na amortizacao",
    "Variacao cambial da amortizacao",
    "Efeito de hiperinflação da amortizacao",
    "Perdas por reducao ao valor recuperavel",
    "Saldo final de 2025"
  ),
  
  valor_R_mil = c(
    586859,
    203682,
    13034,
    -5169,
    11591,
    25568,
    543063,
    594496,
    -90209,
    -5641,
    110,
    5236,
    -8461,
    391,
    1874550
  ),
  
  natureza = c(
    "Saldo residual divulgado em 31/12/2024",
    "Nota 18 - custo do intangivel",
    "Nota 18 - custo do intangivel",
    "Nota 18 - custo do intangivel",
    "Nota 18 - custo do intangivel",
    "Nota 18 - custo do intangivel",
    "Nota 18 - mais-valia",
    "Nota 18 - agio",
    "Nota 18 - amortizacao",
    "Nota 18 - amortizacao",
    "Nota 18 - amortizacao",
    "Nota 18 - amortizacao",
    "Nota 18 - amortizacao",
    "Nota 18 - perda/recuperacao divulgada",
    "Saldo residual divulgado em 31/12/2025"
  ),
  
  stringsAsFactors = FALSE
)

# Calcular a reconciliacao usando todos os movimentos
saldo_inicial <- 586859
saldo_final_divulgado <- 1874550

movimentos <- movimentacao$valor_R_mil[
  !movimentacao$item %in% c(
    "Saldo inicial de 2025",
    "Saldo final de 2025"
  )
]

saldo_calculado <- saldo_inicial + sum(movimentos)
diferenca <- saldo_final_divulgado - saldo_calculado

reconciliacao <- data.frame(
  saldo_inicial_R_mil = saldo_inicial,
  total_movimentacoes_R_mil = sum(movimentos),
  saldo_calculado_R_mil = saldo_calculado,
  saldo_divulgado_R_mil = saldo_final_divulgado,
  diferenca_R_mil = diferenca,
  reconciliado = (diferenca == 0)
)

# Salvar os arquivos
if (!dir.exists("02_papeis_trabalho")) {
  dir.create("02_papeis_trabalho", recursive = TRUE)
}

if (!dir.exists("05_resultados")) {
  dir.create("05_resultados", recursive = TRUE)
}

write.csv(
  movimentacao,
  "02_papeis_trabalho/PT04_movimentacao_intangivel_revisado.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

write.csv(
  reconciliacao,
  "05_resultados/reconciliacao_intangivel_revisada.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Movimentacao revisada e salva.\n")
cat("Saldo calculado (R$ mil):", saldo_calculado, "\n")
cat("Saldo divulgado (R$ mil):", saldo_final_divulgado, "\n")
cat("Diferenca (R$ mil):", diferenca, "\n")
cat("Reconciliado:", diferenca == 0, "\n")

print(reconciliacao)

