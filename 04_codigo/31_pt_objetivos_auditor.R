
# PT18 - Objetivos gerais do auditor
# Norma: NBC TA 200
# Trabalho academico baseado em informacoes publicas e testes sinteticos

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt200 <- data.frame(
  Codigo = c(
    "PT18-01", "PT18-02", "PT18-03",
    "PT18-04", "PT18-05"
  ),
  
  Titulo = rep(
    "Objetivos gerais do auditor independente",
    5
  ),
  
  Norma = rep("NBC TA 200", 5),
  
  Objetivo_PT = rep(
    paste(
      "Documentar a aplicacao conceitual dos objetivos gerais",
      "do auditor ao planejamento academico do dossie da",
      "Frasle Mobility S.A., sem emitir opiniao de auditoria."
    ),
    5
  ),
  
  Tema = c(
    "Objetivos gerais do auditor independente",
    "Ceticismo profissional",
    "Julgamento profissional",
    "Obtencao de seguranca razoavel",
    "Limitacoes do trabalho academico"
  ),
  
  Risco_ou_aspecto_avaliado = c(
    "Risco de o trabalho nao delimitar adequadamente seus objetivos e alcance",
    "Risco de aceitar informacoes sem avaliacao critica suficiente",
    "Risco de avaliar inadequadamente riscos, estimativas e resultados",
    "Risco de confundir seguranca razoavel com garantia absoluta",
    "Risco de apresentar analises academicas como auditoria independente concluida"
  ),
  
  Procedimento = c(
    "Relacionar os objetivos gerais da NBC TA 200 ao escopo e ao planejamento do dossie",
    "Considerar a necessidade de questionar criticamente as evidencias e investigar inconsistencias",
    "Documentar o uso de julgamento na avaliacao de riscos, estimativas e resultados",
    "Registrar que a seguranca razoavel depende de evidencia apropriada e suficiente e nao e absoluta",
    "Identificar quais atividades foram realizadas, planejadas ou simuladas e explicitar as limitacoes"
  ),
  
  Natureza = c(
    "Analise conceitual e planejamento",
    "Diretriz conceitual; nao comprova teste independente",
    "Planejamento e interpretacao dos resultados",
    "Analise conceitual",
    "Delimitacao do escopo academico"
  ),
  
  Evidencia_ou_fonte = c(
    "NBC TA 200; escopo documentado do dossie",
    "NBC TA 200; referencias aos procedimentos documentados nos demais PTs",
    "NBC TA 200; papeis de trabalho de riscos e estimativas",
    "NBC TA 200; descricao dos procedimentos e das limitacoes",
    "DFP publica da companhia; identificacao da base como sintetica; registro do escopo"
  ),
  
  Referencias_cruzadas = c(
    "PT EC; PT19; PT23",
    "PT07; PT13; PT17",
    "PT06; PT17; PT18",
    "PT06; PT16; PT17",
    "PT EC; PT19; PT24"
  ),
  
  Resultado = c(
    "Objetivos gerais documentados para orientar o trabalho academico",
    "O ceticismo e um principio orientador; nao constitui, por si so, evidencia de procedimento executado",
    "O julgamento foi considerado no planejamento e na interpretacao das analises documentadas",
    "O trabalho academico nao fornece seguranca razoavel de auditoria independente sobre as demonstracoes financeiras",
    "Nao houve contratacao para auditoria independente, acesso integral aos registros internos ou emissao de opiniao de auditoria"
  ),
  
  Status_procedimento = c(
    "Analise conceitual documentada",
    "Principio considerado no planejamento",
    "Considerado no planejamento e na analise",
    "Limitacao de escopo documentada",
    "Limitacao de escopo documentada"
  ),
  
  Limitacao = rep(
    paste(
      "Trabalho academico baseado em informacoes publicas e",
      "procedimentos delimitados; nao equivale a auditoria",
      "independente nem permite concluir sobre todas as",
      "afirmacoes das demonstracoes financeiras."
    ),
    5
  ),
  
  Preparador = rep("241003375", 5),
  
  Data_elaboracao = rep("2026-10-24", 5),
  
  Revisor = rep("Pendente de revisao", 5),
  
  Data_revisao = rep("Pendente", 5),
  
  stringsAsFactors = FALSE
)

write.csv(
  pt200,
  "02_papeis_trabalho/PT18_objetivos_auditor.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("PT18 - NBC TA 200 atualizado.\n")
cat("Arquivo: 02_papeis_trabalho/PT18_objetivos_auditor.csv\n")
cat("Quantidade de linhas:", nrow(pt200), "\n")
cat("Quantidade de colunas:", ncol(pt200), "\n")

print(
  pt200[, c(
    "Codigo",
    "Tema",
    "Status_procedimento",
    "Revisor"
  )]
)
