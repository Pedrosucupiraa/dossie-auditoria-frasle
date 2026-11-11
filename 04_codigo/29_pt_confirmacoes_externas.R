
# PT16 - Confirmacoes externas
# NBC TA 505
# Trabalho academico baseado em informacoes publicas

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt_confirmacoes <- data.frame(
  Codigo = c(
    "PT16-01", "PT16-02", "PT16-03",
    "PT16-04", "PT16-05", "PT16-06"
  ),
  Norma = rep("NBC TA 505", 6),
  Area = c(
    "Disponibilidades",
    "Contas a receber",
    "Contas a pagar",
    "Assessoria juridica",
    "Respostas e divergencias",
    "Conclusao"
  ),
  Procedimento = c(
    "Planejar confirmacao de saldos bancarios",
    "Planejar confirmacao de saldos selecionados de clientes",
    "Planejar confirmacao de saldos selecionados de fornecedores",
    "Avaliar a possibilidade de confirmacao externa de processos e contingencias",
    "Definir tratamento de ausencia de resposta e divergencias",
    "Documentar procedimentos realizados e limitacoes"
  ),
  Natureza = rep("Planejado - nao executado", 6),
  Evidencia = c(
    "DFP 2025 publicada; sem acesso a registros bancarios ou contatos institucionais",
    "Sem acesso ao cadastro analitico de clientes e aos registros auxiliares",
    "Sem acesso ao cadastro analitico de fornecedores e aos registros auxiliares",
    "Sem acesso aos processos completos nem aos contatos dos assessores juridicos",
    "Nenhuma solicitacao real enviada ou resposta recebida neste trabalho",
    "Escopo academico baseado em informacoes publicas"
  ),
  Resultado = c(
    "Saldo divulgado nao substitui confirmacao direta com instituicoes financeiras",
    "Saldos individuais e sua existencia nao foram confirmados",
    "Completude dos passivos nao foi verificada por confirmacao externa",
    "Nenhuma confirmacao juridica foi solicitada",
    "Nao houve respostas externas a avaliar",
    "Procedimentos de confirmacao externa nao executados"
  ),
  Limitacao = rep(
    "Trabalho academico; nao equivale a auditoria independente",
    6
  ),
  stringsAsFactors = FALSE
)

write.csv(
  pt_confirmacoes,
  "02_papeis_trabalho/PT16_confirmacoes_externas.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Papel de trabalho PT16 criado.\n")
cat("Arquivo: 02_papeis_trabalho/PT16_confirmacoes_externas.csv\n")
print(pt_confirmacoes)
