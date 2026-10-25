
# PT20 - Organizacoes prestadoras de servicos
# Norma: NBC TA 402
# Analise conceitual e limitacoes de acesso

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt402 <- data.frame(
  Codigo = c(
    "PT20-01", "PT20-02", "PT20-03",
    "PT20-04", "PT20-05"
  ),
  
  Titulo = rep(
    "Consideracoes de Auditoria Relativas a Entidade que Utiliza Organizacao Prestadora de Servicos",
    5
  ),
  
  Norma = rep("NBC TA 402", 5),
  
  Objetivo_PT = rep(
    paste(
      "Documentar os aspectos da NBC TA 402 relevantes ao",
      "planejamento academico da auditoria da Frasle Mobility S.A.",
      "e delimitar as evidencias que nao puderam ser obtidas."
    ),
    5
  ),
  
  Tema = c(
    "Identificacao de servicos terceirizados relevantes",
    "Compreensao dos servicos e controles",
    "Riscos de distorcao relacionados aos servicos",
    "Relatorios de controles da prestadora",
    "Limitacoes dos procedimentos"
  ),
  
  Risco_ou_aspecto_avaliado = c(
    "Risco de nao identificar servicos que possam afetar o relato financeiro e os controles relevantes",
    "Risco de compreender insuficientemente os servicos e seus efeitos sobre os controles da entidade",
    "Risco de distorcao relevante relacionada ao uso de organizacao prestadora de servicos",
    "Risco de apoiar conclusoes em relatorios de controles inexistentes, inadequados ou nao avaliados",
    "Risco de interpretar a falta de acesso como prova de inexistencia de prestadores relevantes"
  ),
  
  Procedimento = c(
    "Examinar as informacoes publicas disponiveis para identificar indicios de servicos terceirizados relevantes; a identificacao permanece pendente de confirmacao",
    "Planejar a obtencao de entendimento sobre a natureza dos servicos, sua relevancia para o relato financeiro e os controles relacionados",
    "Considerar conceitualmente como os servicos utilizados poderiam afetar as afirmacoes das demonstracoes financeiras",
    "Documentar a necessidade de avaliar relatorios de controles pertinentes, caso existam, sejam aplicaveis e estejam disponiveis",
    "Registrar procedimentos nao realizados, a causa da limitacao e as evidencias adicionais necessarias numa auditoria real"
  ),
  
  Natureza = c(
    "Analise preliminar de informacoes publicas; nao confirmada",
    "Procedimento planejado; sem acesso a controles internos",
    "Avaliacao conceitual de risco",
    "Procedimento nao executado; relatorios nao obtidos",
    "Limitacao documentada"
  ),
  
  Evidencia_ou_fonte = c(
    "Demonstracoes financeiras e notas publicadas; prestadores relevantes especificos nao confirmados",
    "Nao houve acesso aos processos internos ou aos controles de prestadores",
    "Risco considerado no planejamento; nenhum teste de controles de prestadores executado",
    "Nenhum relatorio de controles de prestadores foi obtido neste projeto",
    "Escopo academico baseado em informacoes publicas e dados sinteticos"
  ),
  
  Referencias_cruzadas = c(
    "PT EC; PT18; PT19",
    "PT06; PT13; PT18",
    "PT06; PT07; PT17",
    "PT06; PT13",
    "PT18; PT19"
  ),
  
  Resultado = c(
    "A existencia e a relevancia de prestadores especificos requerem confirmacao adicional",
    "A compreensao dos controles permanece limitada pela ausencia de acesso interno",
    "Nao ha base para concluir sobre a eficacia dos controles de prestadores",
    "O procedimento nao foi executado; nao foram obtidas evidencias sobre relatorios",
    "A analise e limitada; a ausencia de evidencia nao comprova a ausencia de prestadores relevantes"
  ),
  
  Status_procedimento = c(
    "Analise preliminar; confirmacao pendente",
    "Planejado; nao executado",
    "Avaliacao conceitual",
    "Nao executado",
    "Limitacao documentada"
  ),
  
  Limitacao = rep(
    paste(
      "Trabalho academico baseado em informacoes publicas e",
      "procedimentos delimitados; sem acesso aos sistemas,",
      "contratos, controles internos ou relatorios de prestadores.",
      "Nao equivale a auditoria independente."
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
  pt402,
  "02_papeis_trabalho/PT20_organizacoes_servicos.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("PT20 - NBC TA 402 atualizado.\n")
cat("Arquivo: 02_papeis_trabalho/PT20_organizacoes_servicos.csv\n")
cat("Quantidade de linhas:", nrow(pt402), "\n")
cat("Quantidade de colunas:", ncol(pt402), "\n")

print(
  pt402[, c(
    "Codigo",
    "Tema",
    "Status_procedimento",
    "Revisor"
  )]
)

