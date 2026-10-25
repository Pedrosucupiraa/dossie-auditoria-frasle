
# PT EC - Estrutura Conceitual

pasta <- "02_papeis_trabalho"
arquivo <- file.path(pasta, "PT22_estrutura_conceitual.csv")

matricula_preparador <- "241003375"
data_preparacao <- "2026-10-24"

pt <- data.frame(
  Codigo = "PT EC",
  Titulo = "Estrutura Conceitual para Trabalhos de Asseguracao",
  Norma = "Estrutura Conceitual",
  Itens_utilizados = "Conceitos de trabalhos de asseguracao, criterios, evidencia, asseguracao razoavel e limitada",
  Referencia = sprintf("PT-EC-%02d", 1:9),
  
  Tema = c(
    "Caracterizacao do trabalho",
    "Usuarios previstos",
    "Objeto do trabalho",
    "Criterios aplicaveis",
    "Responsabilidades",
    "Evidencia e fontes",
    "Nivel de asseguracao",
    "Distincao entre trabalhos de asseguracao",
    "Etica, independencia e limitacoes"
  ),
  
  Analise = c(
    "Trabalho academico de estudo e documentacao de procedimentos de auditoria, baseado em informacoes publicas e testes didaticos com dados sinteticos. Nao constitui contratacao de auditoria nem trabalho independente de asseguracao.",
    "Usuario academico principal: professor responsavel pela disciplina Auditoria 1. A finalidade e demonstrar a aplicacao dos conceitos e procedimentos estudados. O uso por outros usuarios nao foi presumido.",
    "Demonstracoes contabeis anuais da Frasle Mobility S.A. relativas a 2025, com comparativos de 2024, notas explicativas e relatorio do auditor independente publicado.",
    "Como referencia, utilizam-se as demonstracoes e divulgacoes contabeis publicadas, as normas contabeis aplicaveis e a Estrutura Conceitual e NBC TA pertinentes ao exercicio. A versao consultada de cada norma deve ser registrada na relacao de fontes.",
    "Em uma auditoria real, a administracao e responsavel pela elaboracao das demonstracoes e pelos controles internos pertinentes; o auditor e responsavel por obter seguranca razoavel e emitir relatorio conforme o trabalho contratado. Este projeto nao assume essas responsabilidades profissionais.",
    "Fontes: documentos publicos da companhia e bases oficiais, quando identificadas; dados sinteticos para testes didaticos. Cada evidencia deve ter referencia, fonte e classificacao. Procedimentos dependentes de acesso interno permanecem planejados e nao executados.",
    "Uma auditoria de demonstracoes contabeis busca seguranca razoavel, que e alta, mas nao absoluta. Este projeto academico nao oferece seguranca razoavel nem limitada e nao emite opiniao independente.",
    "A auditoria de demonstracoes contabeis e um trabalho de asseguracao razoavel sujeito as normas de auditoria. Outros trabalhos de asseguracao podem ter objeto, criterios e nivel de asseguracao diferentes; procedimentos acordados e trabalhos de consultoria nao equivalem a uma auditoria com opiniao independente.",
    "O estudo considera a importancia da etica, independencia, ceticismo profissional e julgamento. Como nao existe contratacao de auditoria, acesso a registros internos ou emissao de opiniao, nao se declara independencia profissional nem conclusao de asseguracao."
  ),
  
  Procedimento_evidencia = c(
    "Delimitacao do escopo academico.",
    "Identificacao do usuario principal e finalidade.",
    "Consulta as demonstracoes publicadas de 2025 e comparativos de 2024.",
    "Identificacao dos criterios de referencia e registro das normas consultadas.",
    "Distincao entre responsabilidades em auditoria real e objetivo academico.",
    "Classificacao entre evidencia publica, procedimento planejado e simulacao.",
    "Explicacao conceitual, sem atribuicao de asseguracao ao projeto.",
    "Comparacao conceitual entre tipos de trabalho.",
    "Registro das limitacoes e dos cuidados eticos."
  ),
  
  Resultado = c(
    "Escopo academico definido.",
    "Usuario principal identificado.",
    "Objeto identificado; referencias documentais devem constar no indice de fontes.",
    "Criterios de referencia identificados; confirmar versoes na relacao de fontes.",
    "Responsabilidades diferenciadas.",
    "Fontes e tipos de procedimento devem ser rastreaveis nos papeis relacionados.",
    "Nenhum nivel de asseguracao e atribuido a este projeto.",
    "Diferencas conceituais documentadas.",
    "Limitacoes declaradas; nao ha opiniao profissional independente."
  ),
  
  Limitacoes = c(
    "Nao existe contrato de auditoria.",
    "Nao foram presumidos usuarios adicionais.",
    "O objeto foi examinado por meio de informacoes publicas.",
    "A aplicabilidade e a versao das normas devem ser verificadas na fonte oficial.",
    "Nao houve atuacao como auditor independente da companhia.",
    "Nao houve acesso a registros internos ou confirmacoes externas.",
    "Os testes sinteticos nao produzem asseguracao sobre a companhia.",
    "A descricao e conceitual e nao representa a execucao de outros trabalhos.",
    "Nao foram realizados procedimentos profissionais em nome da UnB."
  ),
  
  Preparador = matricula_preparador,
  Data_preparacao = data_preparacao,
  Revisor = "Pendente de revisao",
  Data_revisao = "Pendente",
  stringsAsFactors = FALSE
)

write.csv(
  pt,
  arquivo,
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("PT EC - Estrutura Conceitual atualizado.\n")
cat("Arquivo:", arquivo, "\n")
cat("Linhas:", nrow(pt), "\n")
cat("Revisao:", unique(pt$Revisor), "\n")
