
# ============================================================
# PROJETO: P2 - Auditoria 1
# EMPRESA: Frasle Mobility S.A.
# ARQUIVO: 14_matriz_cobertura_normas.R
# OBJETIVO: Criar matriz de cobertura das normas de auditoria
# ============================================================

# 1. Criar a lista das normas exigidas
matriz_normas <- data.frame(
  Norma = c(
    "Estrutura Conceitual",
    "NBC TA 200",
    "NBC TA 210",
    "NBC TA 220",
    "NBC TA 230",
    "NBC TA 240",
    "NBC TA 250",
    "NBC TA 260",
    "NBC TA 265",
    "NBC TA 300",
    "NBC TA 315",
    "NBC TA 320",
    "NBC TA 330",
    "NBC TA 402",
    "NBC TA 450",
    "NBC TA 500",
    "NBC TA 501",
    "NBC TA 505",
    "NBC TA 510",
    "NBC TA 520",
    "NBC TA 530",
    "NBC TA 540",
    "NBC TA 550",
    "NBC TA 560",
    "NBC TA 570",
    "NBC TA 580",
    "NBC TA 600"
  ),
  
  Tema = c(
    "Estrutura e conceitos fundamentais da auditoria",
    "Objetivos gerais do auditor independente",
    "Termos do trabalho de auditoria",
    "Gestão da qualidade da auditoria",
    "Documentação de auditoria",
    "Responsabilidades relativas a fraude",
    "Leis e regulamentos",
    "Comunicação com responsáveis pela governança",
    "Comunicação de deficiências de controles internos",
    "Planejamento da auditoria",
    "Identificação e avaliação de riscos",
    "Materialidade no planejamento e execução",
    "Respostas do auditor aos riscos avaliados",
    "Organizações prestadoras de serviços",
    "Avaliação de distorções identificadas",
    "Evidência de auditoria",
    "Considerações específicas para determinadas áreas",
    "Confirmações externas",
    "Trabalhos iniciais e saldos iniciais",
    "Procedimentos analíticos",
    "Amostragem em auditoria",
    "Estimativas contábeis",
    "Partes relacionadas",
    "Eventos subsequentes",
    "Continuidade operacional",
    "Representações formais",
    "Auditorias de grupo"
  ),
  
  Status = c(
    "A desenvolver", "A desenvolver", "A desenvolver",
    "A desenvolver", "Parcial - documentação criada",
    "A desenvolver", "A desenvolver", "A desenvolver",
    "A desenvolver", "Parcial - planejamento inicial",
    "Parcial - riscos preliminares", "Parcial - materialidade",
    "Parcial - testes sintéticos", "A desenvolver",
    "A desenvolver", "Parcial - base sintética",
    "A desenvolver", "Planejado - sem confirmação externa",
    "A desenvolver", "Parcial - procedimentos analíticos",
    "Parcial - testes na base sintética",
    "Parcial - intangível e impairment",
    "A desenvolver", "A desenvolver",
    "A desenvolver", "A desenvolver", "A desenvolver"
  ),
  
  Evidencia_ou_procedimento = c(
    "Relacionar conceitos aos procedimentos e limitações do dossiê",
    "Definir objetivo e limites dos procedimentos documentados",
    "Registrar condições e limitações do trabalho acadêmico",
    "Descrever limites de qualidade e ausência de revisão independente",
    "Papéis de trabalho PT02 a PT06 e scripts de análise",
    "Planejar avaliação de riscos de fraude; sem afirmar detecção real",
    "Planejar consulta a informações públicas sobre conformidade",
    "Identificar comunicações públicas relevantes, se disponíveis",
    "Planejar avaliação de deficiências; sem acesso aos controles internos",
    "Documentar escopo, fontes, contas e procedimentos",
    "Análise preliminar de riscos de intangíveis e impairment",
    "Análise comparativa dos saldos e participação no ativo",
    "Testes analíticos e sintéticos claramente identificados",
    "Planejar entendimento de serviços terceirizados relevantes",
    "Documentar exceções encontradas na base sintética",
    "Demonstrações, notas explicativas e base sintética",
    "Planejar procedimentos específicos conforme a conta aplicável",
    "Planejar confirmação; não realizada neste trabalho",
    "Planejar análise de saldos iniciais e comparativos",
    "Comparação de saldos de 2024 e 2025",
    "Base sintética de 500 mil registros e seleção de exceções",
    "Nota explicativa de intangíveis e impairment",
    "Planejar identificação de partes relacionadas nas notas",
    "Planejar busca de eventos subsequentes em fontes públicas",
    "Planejar avaliação com base nas informações públicas disponíveis",
    "Não obtidas representações formais da administração",
    "Planejar análise de informações públicas do grupo"
  ),
  
  Limitacao = rep(
    "Trabalho acadêmico; não equivale a auditoria independente",
    27
  ),
  
  stringsAsFactors = FALSE
)

# 2. Registrar a data de elaboração
matriz_normas$Data_elaboracao <- as.character(Sys.Date())

# 3. Criar a pasta de destino, se necessário
if (!dir.exists("06_matrizes")) {
  dir.create("06_matrizes", recursive = TRUE)
}

# 4. Salvar a matriz em CSV
write.csv(
  matriz_normas,
  "06_matrizes/matriz_cobertura_normas.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# 5. Conferir o resultado
cat("Matriz de cobertura criada.\n")
cat("Quantidade de normas listadas:", nrow(matriz_normas), "\n")
cat("Arquivo: 06_matrizes/matriz_cobertura_normas.csv\n")

print(matriz_normas[, c("Norma", "Status")])


# Complemento da matriz de cobertura das normas

arquivo_matriz <- "06_matrizes/matriz_cobertura_normas.csv"

matriz <- read.csv(
  arquivo_matriz,
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

# Atualizar a NBC TA 450
i <- matriz[[1]] == "NBC TA 450"

matriz[i, 3] <- "Parcial - excecoes sinteticas analisadas"
matriz[i, 4] <- paste(
  "Comparacao entre erros inseridos e excecoes detectadas",
  "na base sintetica; resultados limitados ao teste simulado"
)

# Atualizar a NBC TA 520
i <- matriz[[1]] == "NBC TA 520"

matriz[i, 3] <- "Parcial - analise documental e comparativa"
matriz[i, 4] <- paste(
  "Comparacao dos saldos divulgados de 2024 e 2025",
  "e analise da variacao do intangivel"
)

# Atualizar a NBC TA 540
i <- matriz[[1]] == "NBC TA 540"

matriz[i, 3] <- "Parcial - analise documental limitada"
matriz[i, 4] <- paste(
  "Analise da divulgacao sobre intangiveis e impairment;",
  "modelos internos e premissas nao foram auditados diretamente"
)

# Salvar a matriz atualizada
write.csv(
  matriz,
  arquivo_matriz,
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Matriz atualizada.\n")
print(
  matriz[
    matriz[[1]] %in%
      c("NBC TA 450", "NBC TA 520", "NBC TA 540"),
  ]
)
