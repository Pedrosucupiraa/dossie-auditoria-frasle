
# PT21 - Representacoes formais
# Norma: NBC TA 580
# Trabalho academico baseado em informacoes publicas

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt580 <- data.frame(
  Codigo = c(
    "PT21-01", "PT21-02", "PT21-03",
    "PT21-04", "PT21-05"
  ),
  
  Titulo = rep(
    "Representacoes Formais",
    5
  ),
  
  Norma = rep("NBC TA 580", 5),
  
  Objetivo_PT = rep(
    paste(
      "Documentar os requisitos conceituais da NBC TA 580,",
      "a finalidade das representacoes formais e as limitacoes",
      "decorrentes da ausencia de contato com a administracao."
    ),
    5
  ),
  
  Tema = c(
    "Finalidade das representacoes formais",
    "Responsabilidades da administracao",
    "Solicitacao das representacoes",
    "Consistencia com outras evidencias",
    "Limitacoes do trabalho"
  ),
  
  Risco_ou_aspecto_avaliado = c(
    "Risco de nao compreender a finalidade e o alcance das representacoes formais",
    "Risco de nao documentar adequadamente as responsabilidades da administracao",
    "Risco de interpretar como obtidas representacoes que nao foram solicitadas nem recebidas",
    "Risco de tratar declaracoes da administracao como substitutas de outras evidencias",
    "Risco de apresentar conclusoes sem evidencias diretas suficientes"
  ),
  
  Procedimento = c(
    "Documentar conceitualmente a finalidade das representacoes formais no contexto da auditoria",
    "Registrar as responsabilidades da administracao relativas as demonstracoes financeiras e as informacoes fornecidas ao auditor",
    "Verificar nos arquivos abrangidos pelo projeto se existem representacoes formais solicitadas ou recebidas",
    "Documentar que as representacoes formais devem ser avaliadas em conjunto com as demais evidencias de auditoria",
    "Registrar os procedimentos nao realizados devido a ausencia de contratacao e de contato com a administracao"
  ),
  
  Natureza = c(
    "Analise conceitual",
    "Analise conceitual; sem declaracoes diretas",
    "Verificacao documental limitada aos arquivos do projeto",
    "Diretriz conceitual de auditoria",
    "Limitacao documentada"
  ),
  
  Evidencia_ou_fonte = c(
    "NBC TA 580; fonte normativa a registrar em 01_fontes",
    "Demonstracoes financeiras e notas publicadas; nao constituem declaracao direta da administracao",
    "Arquivos consultados no projeto; nenhuma representacao formal identificada neste escopo",
    "NBC TA 580; escopo e limitacoes dos procedimentos documentados",
    "Documentacao academica, informacoes publicas e identificacao da base sintetica"
  ),
  
  Referencias_cruzadas = c(
    "PT EC; PT18",
    "PT19; PT18",
    "PT19; PT18",
    "PT06; PT16; PT17",
    "PT EC; PT19"
  ),
  
  Resultado = c(
    "Finalidade das representacoes formais documentada conceitualmente",
    "Nao foram obtidas declaracoes diretas da administracao neste trabalho",
    "Representacoes formais nao solicitadas nem recebidas no escopo academico",
    "As representacoes formais nao substituem outras evidencias de auditoria apropriadas e suficientes",
    "Nao foi possivel avaliar representacoes formais da entidade; nao se conclui sobre sua existencia fora do escopo consultado"
  ),
  
  Status_procedimento = c(
    "Analise conceitual documentada",
    "Analise conceitual; declaracoes nao obtidas",
    "Verificacao documental limitada ao projeto",
    "Diretriz conceitual documentada",
    "Limitacao de escopo documentada"
  ),
  
  Limitacao = rep(
    paste(
      "Trabalho academico baseado em informacoes publicas",
      "e procedimentos delimitados; nao houve contratacao",
      "nem contato com a administracao. Nao equivale a",
      "auditoria independente."
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
  pt580,
  "02_papeis_trabalho/PT21_representacoes_formais.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("PT21 - NBC TA 580 atualizado.\n")
cat("Arquivo: 02_papeis_trabalho/PT21_representacoes_formais.csv\n")
cat("Quantidade de linhas:", nrow(pt580), "\n")
cat("Quantidade de colunas:", ncol(pt580), "\n")

print(
  pt580[, c(
    "Codigo",
    "Tema",
    "Status_procedimento",
    "Revisor"
  )]
)

