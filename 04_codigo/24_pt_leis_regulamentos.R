
# PT11 - Leis e regulamentos
# NBC TA 250
# Trabalho academico baseado em informacoes publicas

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt_leis <- data.frame(
  Codigo = c(
    "PT11-01", "PT11-02", "PT11-03",
    "PT11-04", "PT11-05", "PT11-06"
  ),
  Norma = rep("NBC TA 250", 6),
  Procedimento = c(
    "Definir o objetivo da consideracao de leis e regulamentos",
    "Examinar divulgacoes publicas sobre contingencias e processos",
    "Considerar referencias a contingencias tributarias, trabalhistas e civeis",
    "Avaliar se as divulgacoes identificadas exigem analise adicional",
    "Planejar consultas juridicas e verificacoes documentais complementares",
    "Documentar conclusao preliminar e limitacoes"
  ),
  Natureza = c(
    "Planejamento",
    "Analise documental a realizar",
    "Analise documental a realizar",
    "Avaliacao preliminar",
    "Planejado - nao executado",
    "Conclusao documental"
  ),
  Evidencia = c(
    "Escopo academico do trabalho",
    "DFP 2025, notas explicativas e relatorio do auditor",
    "Notas explicativas a examinar",
    "Divulgacoes publicas identificadas durante a analise",
    "Sem acesso a pareceres juridicos internos ou confirmacoes externas",
    "Documentos publicos efetivamente consultados"
  ),
  Resultado = c(
    "Considerar o impacto de leis e regulamentos sobre as demonstracoes",
    "Registrar contingencias e divulgacoes identificadas nos documentos",
    "Classificar os temas conforme as informacoes publicadas",
    "Investigar divergencias ou divulgacoes relevantes se identificadas",
    "Consultas juridicas e confirmacoes independentes nao executadas",
    "A analise publica nao permite concluir sobre o cumprimento integral de todas as normas"
  ),
  Limitacao = rep(
    "Trabalho academico; nao equivale a auditoria independente",
    6
  ),
  stringsAsFactors = FALSE
)

write.csv(
  pt_leis,
  "02_papeis_trabalho/PT11_leis_regulamentos.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Papel de trabalho PT11 criado.\n")
cat("Arquivo: 02_papeis_trabalho/PT11_leis_regulamentos.csv\n")
print(pt_leis)
