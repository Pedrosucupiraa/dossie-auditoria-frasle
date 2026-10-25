

# PT24 - NBC TA 600: Auditoria de Grupo

pt600 <- data.frame(
  Codigo = c("PT24-01", "PT24-02", "PT24-03", "PT24-04", "PT24-05"),
  Titulo = rep("Auditoria de Grupo", 5),
  Norma = rep("NBC TA 600", 5),
  
  Objetivo_PT = c(
    "Documentar aspectos relativos a identificacao do grupo e de seus componentes.",
    "Registrar a abrangencia da analise das demonstracoes consolidadas.",
    "Identificar riscos preliminares associados a auditoria de grupo.",
    "Documentar a limitacao de acesso a informacoes sobre auditores de componentes.",
    "Delimitar o alcance da analise academica."
  ),
  
  Tema = c(
    "Identificacao do grupo e componentes",
    "Abrangencia das demonstracoes consolidadas",
    "Riscos de distorcao relevante no grupo",
    "Participacao de auditores de componentes",
    "Limitacoes da analise academica"
  ),
  
  Risco_ou_aspecto_avaliado = c(
    "Identificacao incompleta de entidades componentes ou de sua relevancia.",
    "Risco de a analise nao abranger adequadamente as informacoes consolidadas.",
    "Riscos relacionados a consolidacao, combinacoes de negocios e eliminacoes intragrupo.",
    "Impossibilidade de avaliar instrucoes, comunicacoes e trabalhos de auditores de componentes.",
    "Risco de extrapolar conclusoes alem das evidencias publicas disponiveis."
  ),
  
  Procedimento = c(
    "Identificar, nas fontes publicas disponiveis, as informacoes sobre o grupo e suas entidades componentes.",
    "Examinar as demonstracoes consolidadas de 2025 e os comparativos de 2024.",
    "Registrar riscos preliminares que exigiriam procedimentos adicionais em auditoria real.",
    "Registrar a ausencia de documentacao interna sobre auditores de componentes.",
    "Documentar expressamente as limitacoes do trabalho academico."
  ),
  
  Natureza = c(
    "Analise documental limitada",
    "Analise documental",
    "Avaliacao preliminar de riscos",
    "Limitacao de escopo",
    "Delimitacao do alcance"
  ),
  
  Evidencia_ou_fonte = c(
    "Demonstracoes financeiras e informacoes publicas do grupo; identificacao detalhada ainda a confirmar.",
    "Demonstracoes financeiras consolidadas publicadas de 2025 e comparativos de 2024.",
    "Demonstracoes financeiras, notas explicativas e informacoes publicas sobre combinacoes de negocios.",
    "Nenhuma documentacao interna de auditores de componentes foi disponibilizada.",
    "Fontes publicas e papeis de trabalho academicos produzidos neste projeto."
  ),
  
  Referencias_cruzadas = c(
    "01_fontes; PT03 - intangivel; PT04 - movimentacao",
    "01_fontes; analise materialidade",
    "PT03 - intangivel; PT04 - movimentacao; PT07 - riscos de fraude",
    "PT18 - NBC TA 200; PT19 - NBC TA 210",
    "README; relatorio tecnico do dossie"
  ),
  
  Resultado = c(
    "A identificacao detalhada das entidades componentes e de sua relevancia permanece pendente de confirmacao documental.",
    "A analise considera as demonstracoes consolidadas publicadas de 2025 e os comparativos de 2024.",
    "Foram documentados riscos preliminares que demandariam avaliacao e evidencias adicionais.",
    "Nao foi possivel avaliar o trabalho de auditores de componentes por falta de documentacao interna.",
    "Nao e possivel concluir sobre a suficiência da auditoria do grupo ou a atuacao dos auditores de componentes."
  ),
  
  Status_procedimento = c(
    "Identificacao detalhada pendente de confirmacao",
    "Analise documental das demonstracoes consolidadas",
    "Riscos preliminares documentados",
    "Nao avaliado por falta de documentacao interna",
    "Limitacoes explicitadas"
  ),
  
  Limitacao = rep(
    "A analise utiliza fontes publicas e procedimentos academicos; nao houve acesso a arquivos internos de auditoria nem a documentacao de auditores de componentes.",
    5
  ),
  
  Preparador = rep("241003375", 5),
  Data_elaboracao = rep("2026-10-24", 5),
  Revisor = rep("Pendente de revisao", 5),
  Data_revisao = rep("Pendente", 5),
  
  stringsAsFactors = FALSE
)

write.csv(
  pt600,
  "02_papeis_trabalho/PT24_auditoria_grupo.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("PT24 - NBC TA 600 atualizado.\n")
cat("Arquivo: 02_papeis_trabalho/PT24_auditoria_grupo.csv\n")
cat("Quantidade de linhas:", nrow(pt600), "\n")
cat("Quantidade de colunas:", ncol(pt600), "\n")

print(pt600[, c(
  "Codigo", "Tema", "Status_procedimento", "Revisor"
)])

