
# PT12 - Comunicacao com os responsaveis pela governanca
# NBC TA 260
# Trabalho academico baseado em informacoes publicas

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt_governanca <- data.frame(
  Codigo = c(
    "PT12-01", "PT12-02", "PT12-03",
    "PT12-04", "PT12-05", "PT12-06"
  ),
  Norma = rep("NBC TA 260", 6),
  Procedimento = c(
    "Definir os objetivos da comunicacao com a governanca",
    "Identificar informacoes publicas sobre a estrutura de governanca",
    "Considerar assuntos relevantes identificados no planejamento",
    "Relacionar riscos e limitacoes que deveriam ser comunicados em uma auditoria real",
    "Documentar comunicacoes que dependeriam de contato direto",
    "Registrar conclusao e limitacoes"
  ),
  Natureza = c(
    "Planejamento",
    "Analise documental a realizar",
    "Planejamento",
    "Analise preliminar",
    "Planejado - nao executado",
    "Conclusao documental"
  ),
  Evidencia = c(
    "Escopo academico do trabalho",
    "DFP 2025 e informacoes societarias publicas, se consultadas",
    "Papeis de trabalho de planejamento elaborados",
    "Riscos e limitacoes documentados neste dossie",
    "Nenhuma comunicacao direta foi realizada",
    "Documentos publicos efetivamente examinados"
  ),
  Resultado = c(
    "Definir assuntos relevantes para comunicacao aos responsaveis pela governanca",
    "Registrar somente informacoes publicas efetivamente consultadas",
    "Considerar riscos, estimativas e limitacoes relevantes",
    "Organizar assuntos que seriam comunicados em uma auditoria real",
    "Nao afirmar que houve reuniao, entrevista ou comunicacao com a governanca",
    "O trabalho academico nao substitui as comunicacoes exigidas em uma auditoria independente"
  ),
  Limitacao = rep(
    "Trabalho academico; nao equivale a auditoria independente",
    6
  ),
  stringsAsFactors = FALSE
)

write.csv(
  pt_governanca,
  "02_papeis_trabalho/PT12_comunicacao_governanca.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Papel de trabalho PT12 criado.\n")
cat("Arquivo: 02_papeis_trabalho/PT12_comunicacao_governanca.csv\n")
print(pt_governanca)
