ativo_total <- 7222660
intangivel <- 1874550

# Premissas academicas
percentual_global <- 0.01
percentual_execucao <- 0.75
percentual_especifica <- 0.02

materialidade <- data.frame(
  parametro = c(
    "Materialidade global",
    "Materialidade para execucao",
    "Materialidade especifica - intangiveis"
  ),
  base_R_mil = c(ativo_total, ativo_total, intangivel),
  percentual = c(1, 0.75, 2),
  valor_R_mil = c(
    ativo_total * percentual_global,
    ativo_total * percentual_global * percentual_execucao,
    intangivel * percentual_especifica
  )
)

print(materialidade)

write.csv(
  materialidade,
  "05_resultados/calculo_materialidade.csv",
  row.names = FALSE
)
