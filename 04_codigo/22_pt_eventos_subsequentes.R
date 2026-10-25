
# PT09 - Eventos subsequentes
# NBC TA 560
# Trabalho academico baseado em informacoes publicas

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt_eventos <- data.frame(
  Codigo = c(
    "PT09-01", "PT09-02", "PT09-03",
    "PT09-04", "PT09-05", "PT09-06"
  ),
  Norma = rep("NBC TA 560", 6),
  Procedimento = c(
    "Definir o periodo relevante para eventos subsequentes",
    "Identificar a data de autorizacao das demonstracoes financeiras",
    "Examinar informacoes publicas posteriores a data-base",
    "Considerar eventos que possam exigir ajuste ou divulgacao",
    "Planejar consultas e procedimentos adicionais",
    "Documentar conclusao preliminar e limitacoes"
  ),
  Natureza = c(
    "Planejamento",
    "Verificacao documental - pendente de confirmacao",
    "Analise documental a realizar",
    "Analise preliminar",
    "Planejado - nao executado",
    "Conclusao documental"
  ),
  Evidencia = c(
    "Data-base das demonstracoes: 31/12/2025",
    "DFP 2025 e documentos societarios publicos",
    "Documentos publicos posteriores a data-base, se localizados",
    "Notas explicativas e comunicacoes publicas pertinentes",
    "Sem consulta a administracao, atas internas ou registros posteriores internos",
    "Evidencias publicas efetivamente examinadas"
  ),
  Resultado = c(
    "Considerar eventos entre a data-base e a data relevante do relatorio",
    "Registrar a data somente apos confirmar documentalmente",
    "Registrar os documentos examinados e seus periodos",
    "Avaliar se as informacoes indicam necessidade de ajuste ou divulgacao",
    "Consultas internas e busca completa de eventos nao executadas",
    "Nao concluir que todos os eventos subsequentes foram identificados"
  ),
  Limitacao = rep(
    "Trabalho academico; nao equivale a auditoria independente",
    6
  ),
  stringsAsFactors = FALSE
)

write.csv(
  pt_eventos,
  "02_papeis_trabalho/PT09_eventos_subsequentes.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Papel de trabalho PT09 criado.\n")
cat("Arquivo: 02_papeis_trabalho/PT09_eventos_subsequentes.csv\n")
print(pt_eventos)
