# PT02 - Procedimentos complementares de impairment
# Fonte: Demonstracoes Financeiras de 2025, Nota Explicativa 16
# Natureza: analise documental academica de informacoes publicas

procedimentos <- data.frame(
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
    "Avaliar a coerencia das premissas divulgadas",
    "Examinar calculos detalhados e modelos internos de avaliacao",
    "Realizar testes de sensibilidade das premissas"
  ),
  
  classificacao = c(
    "Analise documental realizada",
    "Analise documental realizada",
    "Analise documental limitada",
    "Planejado - nao executado",
    "Planejado - nao executado"
  ),
  
  evidencia_disponivel = c(
    "Nota 16: divulgacao da politica de recuperabilidade, incluindo fluxos de caixa descontados, taxa de desconto e crescimento futuro",
    "Nota 16: divulgacao de unidades geradoras de caixa avaliadas e respectivas informacoes, incluindo taxas de desconto",
    "Nota 16: descricao das premissas utilizadas nas estimativas de recuperabilidade",
    "Modelos de avaliacao e calculos internos nao disponibilizados para este trabalho",
    "Dados detalhados e modelos internos necessarios para os testes nao disponibilizados"
  ),
  
  resultado_atual = c(
    "A companhia divulga os criterios de avaliacao e informa que ativos com vida util indefinida e agio estao sujeitos a testes de recuperabilidade",
    "A companhia informa que testou unidades com indicios de perda e determinados ativos intangiveis; declara que as UGCs avaliadas eram recuperaveis na data-base",
    "As premissas divulgadas podem ser examinadas documentalmente, mas seus calculos e sua razoabilidade nao foram validados de forma independente",
    "Procedimento nao executado por falta de acesso aos modelos e documentos internos",
    "Procedimento nao executado por falta dos dados detalhados necessarios"
  ),
  
  limitacao = c(
    "A verificacao se limita ao conteudo divulgado na Nota 16",
    "A divulgacao publica nao comprova, isoladamente, a integridade dos testes realizados pela companhia",
    "Nao houve recalculo dos fluxos de caixa nem validacao independente da taxa de desconto ou do crescimento projetado",
    "Sem acesso aos modelos internos e aos documentos de suporte",
    "Sem dados suficientes para recalcular cenarios e medir a sensibilidade das estimativas"
  ),
  
  fonte = rep(
    "Demonstracoes Financeiras de 2025 - Nota Explicativa 16",
    5
  ),
  
  stringsAsFactors = FALSE
)

write.csv(
  procedimentos,
  "02_papeis_trabalho/PT02_procedimentos_complementares_revisado.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Arquivo atualizado e salvo.\n")

print(procedimentos)