
# PT10 - Partes relacionadas
# NBC TA 550
# Trabalho academico baseado em informacoes publicas

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt_partes <- data.frame(
  Codigo = c(
    "PT10-01", "PT10-02", "PT10-03",
    "PT10-04", "PT10-05", "PT10-06"
  ),
  Norma = rep("NBC TA 550", 6),
  Procedimento = c(
    "Definir o objetivo da analise de partes relacionadas",
    "Examinar as divulgacoes de partes relacionadas nas notas explicativas",
    "Considerar riscos de transacoes relevantes fora do curso normal dos negocios",
    "Avaliar se as divulgacoes publicas permitem compreender a natureza das transacoes",
    "Planejar procedimentos adicionais sobre identificacao e completude",
    "Documentar conclusao preliminar e limitacoes"
  ),
  Natureza = c(
    "Planejamento",
    "Analise documental a realizar",
    "Consideracao de risco",
    "Analise documental limitada",
    "Planejado - nao executado",
    "Conclusao documental"
  ),
  Evidencia = c(
    "Escopo academico do trabalho",
    "DFP 2025 e notas explicativas",
    "Informacoes publicas sobre transacoes e saldos",
    "Notas explicativas efetivamente examinadas",
    "Sem acesso a cadastro completo, contratos e registros internos",
    "Documentos publicos examinados"
  ),
  Resultado = c(
    "Considerar os riscos de distorcao relevante relacionados a partes relacionadas",
    "Registrar as partes e transacoes identificadas nas divulgacoes consultadas",
    "Avaliar a necessidade de investigacao adicional sem presumir irregularidade",
    "Avaliacao limitada ao conteudo divulgado publicamente",
    "Nao foi verificada a completude da identificacao de partes relacionadas",
    "Nao concluir que todas as partes relacionadas ou transacoes foram identificadas"
  ),
  Limitacao = rep(
    "Trabalho academico; nao equivale a auditoria independente",
    6
  ),
  stringsAsFactors = FALSE
)

write.csv(
  pt_partes,
  "02_papeis_trabalho/PT10_partes_relacionadas.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Papel de trabalho PT10 criado.\n")
cat("Arquivo: 02_papeis_trabalho/PT10_partes_relacionadas.csv\n")
print(pt_partes)
