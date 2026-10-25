
# Projeto: Auditoria 1 - Frasle Mobility S.A.
# Etapa: planejamento da base sintetica do intangivel
# Natureza: dados simulados para fins educacionais

empresa <- "Frasle Mobility S.A."
exercicio <- 2025
conta_auditada <- "Intangivel consolidado"
saldo_2025_mil_reais <- 1874550
saldo_2024_mil_reais <- 586859
quantidade_minima_registros <- 500000

planejamento <- data.frame(
  campo = c(
    "Empresa",
    "Exercicio",
    "Conta selecionada",
    "Saldo de encerramento de 2025 (R$ mil)",
    "Saldo comparativo de 2024 (R$ mil)",
    "Quantidade minima de registros",
    "Origem dos registros",
    "Limitacao"
  ),
  descricao = c(
    empresa,
    as.character(exercicio),
    conta_auditada,
    as.character(saldo_2025_mil_reais),
    as.character(saldo_2024_mil_reais),
    as.character(quantidade_minima_registros),
    "Dados integralmente sinteticos, gerados por codigo",
    "Nao representam o razao contabil nem transacoes reais da companhia"
  ),
  stringsAsFactors = FALSE
)

dir.create("03_base_sintetica", showWarnings = FALSE)
dir.create("05_resultados", showWarnings = FALSE)

write.csv(
  planejamento,
  "03_base_sintetica/planejamento_base_intangivel.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

print(planejamento)
print(file.exists(
  "03_base_sintetica/planejamento_base_intangivel.csv"
))

