
# PT07 - Avaliacao preliminar de riscos de fraude
# Trabalho academico baseado em informacoes publicas

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt_fraude <- data.frame(
  Codigo = c("PT07-01", "PT07-02", "PT07-03",
             "PT07-04", "PT07-05", "PT07-06"),
  
  Norma = rep("NBC TA 240", 6),
  
  Procedimento = c(
    "Definir o objetivo da avaliacao de riscos de fraude",
    "Considerar risco de reconhecimento indevido de receitas",
    "Considerar risco de manipulacao de estimativas contabeis",
    "Relacionar intangiveis e impairment a riscos de estimativa",
    "Planejar procedimentos adicionais de auditoria",
    "Documentar limitacoes e conclusao preliminar"
  ),
  
  Natureza = c(
    "Planejamento",
    "Risco a considerar",
    "Risco a considerar",
    "Analise documental preliminar",
    "Planejado - nao executado",
    "Conclusao documental"
  ),
  
  Evidencia = c(
    "Escopo academico e demonstracoes financeiras publicas",
    "Risco considerado; nao constitui achado de fraude",
    "Risco considerado; nao constitui achado de fraude",
    "Nota explicativa de intangiveis e impairment",
    "Sem acesso a lancamentos, sistemas ou controles internos",
    "Analise limitada as informacoes publicamente divulgadas"
  ),
  
  Resultado = c(
    "Avaliar riscos de distorcao relevante decorrentes de fraude",
    "Nenhuma fraude real foi identificada por este procedimento",
    "Estimativas exigem julgamento; nao foram testadas internamente",
    "Tema relevante para planejamento, sem conclusao sobre incorrecao",
    "Procedimentos adicionais permanecem pendentes",
    "Nao e possivel concluir sobre ocorrencia ou ausencia de fraude"
  ),
  
  Limitacao = rep(
    "Trabalho academico; nao equivale a auditoria independente",
    6
  ),
  
  stringsAsFactors = FALSE
)

write.csv(
  pt_fraude,
  "02_papeis_trabalho/PT07_riscos_fraude.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Papel de trabalho de fraude criado.\n")
cat("Arquivo: 02_papeis_trabalho/PT07_riscos_fraude.csv\n")

print(pt_fraude)


arquivo_matriz <- "06_matrizes/matriz_cobertura_normas.csv"

matriz <- read.csv(
  arquivo_matriz,
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

i <- matriz[[1]] == "NBC TA 240"

matriz[i, 3] <- "Parcial - riscos preliminares documentados"
matriz[i, 4] <- paste(
  "PT07: consideracao de riscos de fraude e estimativas;",
  "procedimentos internos nao executados"
)

write.csv(
  matriz,
  arquivo_matriz,
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("NBC TA 240 atualizada na matriz.\n")
