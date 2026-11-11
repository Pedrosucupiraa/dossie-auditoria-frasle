
# ============================================================
# PROJETO: P2 - Auditoria 1
# OBJETIVO: Documentar a conclusao da reconciliacao
# ============================================================

conclusao_PT05 <- data.frame(
  codigo = "PT05",
  area = "Ativos intangiveis",
  procedimento = "Reconciliacao aritmetica do saldo residual",
  fonte = "Demonstracoes financeiras de 2025 - Nota 18",
  saldo_inicial_R_mil = 586859,
  movimentacoes_liquidas_R_mil = 1287691,
  saldo_calculado_R_mil = 1874550,
  saldo_divulgado_R_mil = 1874550,
  diferenca_R_mil = 0,
  resultado = "Reconciliacao aritmetica sem diferenca",
  tipo_evidencia = "Informacao financeira publica transcrita para o papel de trabalho",
  limitacao = paste(
    "A reconciliacao aritmetica nao comprova, isoladamente,",
    "existencia, direitos, mensuracao ou recuperabilidade dos ativos.",
    "Movimentacoes individuais devem ser conferidas com a nota original."
  ),
  preparador = "241003375",
  data_elaboracao = as.character(Sys.Date()),
  revisor = "Pendente - nao declarar revisao independente"
)

write.csv(
  conclusao_PT05,
  "02_papeis_trabalho/PT05_conclusao_reconciliacao_revisada.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Conclusao revisada salva.\n")
cat("Arquivo: 02_papeis_trabalho/PT05_conclusao_reconciliacao_revisada.csv\n")
