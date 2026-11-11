
# PT23 - NBC TA 220: Gestao da Qualidade da Auditoria

pt220 <- data.frame(
  Codigo = c("PT23-01", "PT23-02", "PT23-03", "PT23-04", "PT23-05"),
  Titulo = rep("Gestao da Qualidade da Auditoria", 5),
  Norma = rep("NBC TA 220", 5),
  
  Objetivo_PT = c(
    "Documentar consideracoes sobre a qualidade do trabalho de auditoria.",
    "Registrar consideracoes sobre etica e independencia.",
    "Avaliar conceitualmente a adequacao de competencias, tempo e recursos.",
    "Documentar a importancia do direcionamento e da supervisao.",
    "Registrar os limites da avaliacao de qualidade neste projeto academico."
  ),
  
  Tema = c(
    "Responsabilidade pela qualidade",
    "Requisitos eticos e independencia",
    "Recursos e competencias",
    "Direcionamento e supervisao",
    "Revisao e limitacoes"
  ),
  
  Risco_ou_aspecto_avaliado = c(
    "Risco de procedimentos inadequados ou insuficientemente documentados.",
    "Risco de descumprimento de requisitos eticos ou de independencia.",
    "Risco de procedimentos inadequados por falta de competencia, tempo ou recursos.",
    "Risco de falhas na execucao, supervisao ou documentacao.",
    "Impossibilidade de atestar a qualidade de uma auditoria real neste projeto."
  ),
  
  Procedimento = c(
    "Documentar a necessidade de considerar a qualidade durante o planejamento e a execucao.",
    "Identificar os requisitos eticos e de independencia que precisariam ser avaliados em um trabalho real.",
    "Registrar a necessidade de equipe competente e recursos adequados.",
    "Registrar a necessidade de direcionamento, supervisao e documentacao das atividades.",
    "Delimitar expressamente o alcance da avaliacao academica."
  ),
  
  Natureza = rep("Analise conceitual", 5),
  
  Evidencia_ou_fonte = c(
    "Planejamento e papeis de trabalho academicos do projeto.",
    "Requisitos profissionais aplicaveis a serem verificados em trabalho real.",
    "Planejamento dos procedimentos propostos neste dossie.",
    "Estrutura documental e procedimentos propostos no dossie.",
    "Escopo e arquivos efetivamente produzidos neste projeto."
  ),
  
  Referencias_cruzadas = c(
    "PT18 - NBC TA 200; planejamento da auditoria",
    "PT18 - NBC TA 200; PT19 - NBC TA 210",
    "PT18 - NBC TA 200; PT19 - NBC TA 210",
    "PT18 - NBC TA 200; demais papeis de trabalho",
    "README e relatorio tecnico do dossie"
  ),
  
  Resultado = c(
    "A qualidade deve ser considerada ao longo do planejamento e da execucao.",
    "A avaliacao de etica e independencia e necessaria, mas nao equivale a uma verificacao independente completa.",
    "A adequacao de recursos deve ser avaliada conforme os procedimentos e riscos.",
    "Direcionamento, supervisao e documentacao sao aspectos relevantes para a qualidade.",
    "O projeto academico nao permite concluir sobre a conformidade de uma auditoria real com todos os requisitos de qualidade."
  ),
  
  Status_procedimento = c(
    "Consideracoes conceituais documentadas",
    "Requisitos a considerar em trabalho real",
    "Procedimento conceitual documentado",
    "Procedimento conceitual documentado",
    "Limitacao de escopo documentada"
  ),
  
  Limitacao = rep(
    "Nao houve contratacao de auditoria, equipe formal, inspecao de arquivo de auditoria real ou revisao independente deste dossie.",
    5
  ),
  
  Preparador = rep("241003375", 5),
  Data_elaboracao = rep("2026-10-24", 5),
  Revisor = rep("Pendente de revisao", 5),
  Data_revisao = rep("Pendente", 5),
  
  stringsAsFactors = FALSE
)

write.csv(
  pt220,
  "02_papeis_trabalho/PT23_gestao_qualidade.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("PT23 - NBC TA 220 atualizado.\n")
cat("Arquivo: 02_papeis_trabalho/PT23_gestao_qualidade.csv\n")
cat("Quantidade de linhas:", nrow(pt220), "\n")
cat("Quantidade de colunas:", ncol(pt220), "\n")

print(pt220[, c(
  "Codigo", "Tema", "Status_procedimento", "Revisor"
)])
