
# PT15 - Consideracoes especificas para itens selecionados
# NBC TA 501
# Trabalho academico baseado em informacoes publicas

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt_itens <- data.frame(
  Codigo = c(
    "PT15-01", "PT15-02", "PT15-03",
    "PT15-04", "PT15-05", "PT15-06"
  ),
  Norma = rep("NBC TA 501", 6),
  Area = c(
    "Estoques",
    "Estoques",
    "Litigios e reclamacoes",
    "Litigios e reclamacoes",
    "Outras informacoes relevantes",
    "Conclusao"
  ),
  Procedimento = c(
    "Identificar a relevancia dos estoques nas demonstracoes consolidadas",
    "Planejar procedimentos de observacao fisica e testes de contagem",
    "Identificar informacoes publicas sobre processos judiciais e contingencias",
    "Planejar avaliacao de completude e mensuracao das contingencias",
    "Verificar a necessidade de procedimentos especificos para outros itens",
    "Documentar resultados e limitacoes da analise"
  ),
  Natureza = c(
    "Analise documental",
    "Planejado - nao executado",
    "Analise documental a realizar",
    "Planejado - nao executado",
    "Avaliacao preliminar",
    "Conclusao preliminar"
  ),
  Evidencia = c(
    "DFP 2025 e notas explicativas",
    "Sem acesso fisico aos estoques nem aos registros internos",
    "Notas explicativas publicadas sobre provisoes e contingencias",
    "Sem acesso aos processos completos e aos documentos juridicos internos",
    "Demonstracoes financeiras e notas explicativas publicadas",
    "Documentos publicos examinados no escopo do trabalho"
  ),
  Resultado = c(
    "Estoques consolidados divulgados em R$ 1.443.447 mil; relevancia para o planejamento",
    "Existencia e condicao fisica dos estoques nao verificadas",
    "Registrar as divulgacoes identificadas apos consulta efetiva as notas",
    "Testes de completude e mensuracao nao executados",
    "Aplicabilidade depende dos itens identificados nas demonstracoes e notas",
    "A analise documental nao substitui procedimentos de auditoria sobre os itens"
  ),
  Limitacao = rep(
    "Trabalho academico baseado em informacoes publicas; nao equivale a auditoria independente",
    6
  ),
  stringsAsFactors = FALSE
)

write.csv(
  pt_itens,
  "02_papeis_trabalho/PT15_itens_selecionados.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Papel de trabalho PT15 criado.\n")
cat("Arquivo: 02_papeis_trabalho/PT15_itens_selecionados.csv\n")
print(pt_itens)
