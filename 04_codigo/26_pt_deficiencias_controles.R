
# PT13 - Deficiencias de controles internos
# NBC TA 265
# Trabalho academico baseado em informacoes publicas

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt_controles <- data.frame(
  Codigo = c(
    "PT13-01", "PT13-02", "PT13-03",
    "PT13-04", "PT13-05", "PT13-06"
  ),
  Norma = rep("NBC TA 265", 6),
  Procedimento = c(
    "Definir o objetivo da avaliacao de controles internos",
    "Identificar informacoes publicas sobre riscos e controles divulgados",
    "Relacionar riscos contabeis relevantes aos ciclos e estimativas analisados",
    "Planejar testes de desenho e implementacao de controles",
    "Documentar limitacoes decorrentes da ausencia de acesso interno",
    "Registrar conclusao preliminar"
  ),
  Natureza = c(
    "Planejamento",
    "Analise documental a realizar",
    "Analise preliminar",
    "Planejado - nao executado",
    "Limitacao de escopo",
    "Conclusao documental"
  ),
  Evidencia = c(
    "Escopo academico do trabalho",
    "DFP 2025 e informacoes publicas, se consultadas",
    "Papeis de trabalho de riscos e estimativas",
    "Sem acesso a sistemas, fluxos, politicas e controles internos",
    "Nenhum teste de controles internos foi executado",
    "Documentacao publica efetivamente examinada"
  ),
  Resultado = c(
    "Organizar a consideracao dos controles relevantes para a auditoria",
    "Registrar apenas controles expressamente descritos nas fontes consultadas",
    "Considerar riscos sem presumir falha de controle",
    "Testes de desenho e implementacao permanecem pendentes",
    "Nao foram identificadas deficiencias reais por testes de controles",
    "Nao e possivel concluir sobre a eficacia dos controles internos"
  ),
  Limitacao = rep(
    "Trabalho academico; nao equivale a auditoria independente",
    6
  ),
  stringsAsFactors = FALSE
)

write.csv(
  pt_controles,
  "02_papeis_trabalho/PT13_deficiencias_controles.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Papel de trabalho PT13 criado.\n")
cat("Arquivo: 02_papeis_trabalho/PT13_deficiencias_controles.csv\n")
print(pt_controles)
