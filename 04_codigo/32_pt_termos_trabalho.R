

# PT19 - Termos do trabalho de auditoria
# Norma: NBC TA 210
# Analise conceitual aplicada ao trabalho academico

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt210 <- data.frame(
  Codigo = c(
    "PT19-01", "PT19-02", "PT19-03",
    "PT19-04", "PT19-05"
  ),
  
  Titulo = rep(
    "Concordancia com os Termos do Trabalho de Auditoria",
    5
  ),
  
  Norma = rep("NBC TA 210", 5),
  
  Objetivo_PT = rep(
    paste(
      "Documentar os requisitos conceituais da NBC TA 210",
      "e delimitar sua aplicacao ao dossie academico da",
      "Frasle Mobility S.A., sem caracterizar contratacao real."
    ),
    5
  ),
  
  Tema = c(
    "Condicoes previas para auditoria",
    "Responsabilidades da administracao",
    "Responsabilidades do auditor",
    "Concordancia formal dos termos",
    "Aplicabilidade ao trabalho academico"
  ),
  
  Risco_ou_aspecto_avaliado = c(
    "Risco de iniciar um trabalho sem avaliar as condicoes previas aplicaveis",
    "Risco de nao esclarecer a responsabilidade da administracao pelas demonstracoes e controles",
    "Risco de nao delimitar o alcance, os objetivos e as responsabilidades do auditor",
    "Risco de executar um trabalho sem termos formalmente acordados",
    "Risco de confundir estudo academico com auditoria independente contratada"
  ),
  
  Procedimento = c(
    "Identificar conceitualmente os requisitos previos, incluindo a estrutura de relatorio financeiro aplicavel e o reconhecimento das responsabilidades pela administracao",
    "Documentar as responsabilidades que deveriam ser reconhecidas pela administracao, incluindo elaboracao das demonstracoes e controles internos pertinentes",
    "Descrever a necessidade de definir objetivos, alcance, responsabilidades, estrutura de relatorio e forma esperada de comunicacao",
    "Verificar os arquivos deste projeto quanto a carta de contratacao ou documento equivalente, sem inferir sobre documentos externos nao consultados",
    "Distinguir os procedimentos academicos realizados, planejados e simulados de um trabalho de auditoria contratado"
  ),
  
  Natureza = c(
    "Analise conceitual; requisitos nao confirmados com a empresa",
    "Analise conceitual; sem acordo com a administracao",
    "Analise conceitual e delimitacao de escopo",
    "Verificacao documental limitada aos arquivos do projeto",
    "Delimitacao do escopo academico"
  ),
  
  Evidencia_ou_fonte = c(
    "NBC TA 210; fontes normativas a registrar em 01_fontes",
    "NBC TA 210; escopo e limitacoes documentados no dossie",
    "NBC TA 210; estrutura e planejamento dos papeis de trabalho",
    "Arquivos consultados no projeto; nenhum documento de contratacao identificado neste escopo",
    "DFP publica, arquivos do projeto e identificacao dos dados sinteticos"
  ),
  
  Referencias_cruzadas = c(
    "PT EC; PT18",
    "PT18; PT23",
    "PT18; PT24",
    "PT18; PT EC",
    "PT18; PT22"
  ),
  
  Resultado = c(
    "Requisitos conceituais registrados; nao houve verificacao das condicoes previas com a administracao",
    "As responsabilidades reais da administracao nao foram acordadas neste trabalho academico",
    "Nao houve contratacao de auditor independente nem definicao formal de termos com a companhia",
    "Nao foi identificada carta de contratacao nos arquivos abrangidos pela verificacao; isso nao permite concluir sobre documentos externos ao projeto",
    "A NBC TA 210 foi abordada conceitualmente, sem simular contratacao ou afirmar aceitacao de trabalho real"
  ),
  
  Status_procedimento = c(
    "Analise conceitual documentada",
    "Requisito conceitual; nao acordado",
    "Requisito conceitual; nao acordado",
    "Verificacao limitada aos arquivos do projeto",
    "Limitacao de escopo documentada"
  ),
  
  Limitacao = rep(
    paste(
      "Trabalho academico baseado em informacoes publicas e",
      "procedimentos delimitados; nao equivale a auditoria",
      "independente nem comprova cumprimento dos requisitos",
      "de contratacao pela companhia."
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
  pt210,
  "02_papeis_trabalho/PT19_termos_trabalho.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("PT19 - NBC TA 210 atualizado.\n")
cat("Arquivo: 02_papeis_trabalho/PT19_termos_trabalho.csv\n")
cat("Quantidade de linhas:", nrow(pt210), "\n")
cat("Quantidade de colunas:", ncol(pt210), "\n")

print(
  pt210[, c(
    "Codigo",
    "Tema",
    "Status_procedimento",
    "Revisor"
  )]
)
