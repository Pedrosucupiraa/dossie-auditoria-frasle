
# ============================================================
# PROJETO: P2 - Auditoria 1
# PAPEL DE TRABALHO: PT02 - Impairment
# OBJETIVO: Complementar a documentacao da Nota 16
# ============================================================

procedimentos_impairment <- data.frame(
  codigo = c(
    "PT02-05",
    "PT02-06",
    "PT02-07",
    "PT02-08",
    "PT02-09"
  ),
  
  procedimento = c(
    "Conferir a divulgacao da politica de impairment na Nota 16",
    "Verificar as informacoes divulgadas sobre unidades geradoras de caixa",
    "Avaliar a coerencia das premissas de fluxos de caixa, crescimento e desconto",
    "Solicitar e examinar os calculos detalhados e modelos de avaliacao",
    "Planejar testes de sensibilidade das premissas utilizadas"
  ),
  
  classificacao = c(
    "Evidencia publica a conferir",
    "Evidencia publica a conferir",
    "Analise documental limitada",
    "Planejado - sem acesso aos calculos internos",
    "Planejado - depende das premissas detalhadas"
  ),
  
  evidencia_disponivel = c(
    "Nota Explicativa 16 das demonstracoes financeiras de 2025",
    "Nota Explicativa 16, conforme informacoes divulgadas",
    "Descricao publica das premissas, se divulgadas na nota",
    "Calculos internos nao disponibilizados neste trabalho",
    "Dados detalhados para sensibilidade nao disponiveis"
  ),
  
  resultado_atual = c(
    "A conferir diretamente na fonte original",
    "A conferir diretamente na fonte original",
    "Nao foi possivel validar os calculos internos",
    "Procedimento nao executado",
    "Procedimento nao executado"
  ),
  
  limitacao = c(
    "A transcricao da nota deve ser comparada com o PDF original",
    "A divulgacao publica nao substitui os registros internos",
    "Nao houve validacao independente das premissas",
    "Sem acesso aos modelos e documentos de suporte",
    "Sem acesso aos dados necessarios para recalcular cenarios"
  ),
  
  stringsAsFactors = FALSE
)

write.csv(
  procedimentos_impairment,
  "02_papeis_trabalho/PT02_procedimentos_complementares.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Complemento do PT02 salvo.\n")
cat("Arquivo: 02_papeis_trabalho/PT02_procedimentos_complementares.csv\n")
cat("Procedimentos documentados:", nrow(procedimentos_impairment), "\n")
