
# PT08 - Continuidade operacional
# NBC TA 570
# Analise academica baseada em informacoes publicas

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt_continuidade <- data.frame(
  Codigo = c(
    "PT08-01", "PT08-02", "PT08-03",
    "PT08-04", "PT08-05", "PT08-06"
  ),
  Norma = rep("NBC TA 570", 6),
  Procedimento = c(
    "Definir o objetivo da avaliacao de continuidade operacional",
    "Consultar as demonstracoes financeiras e o relatorio do auditor",
    "Considerar informacoes publicas relevantes para liquidez e endividamento",
    "Verificar se ha divulgacao de incerteza relevante sobre continuidade",
    "Planejar procedimentos adicionais que dependeriam de dados internos",
    "Registrar conclusao preliminar e limitacoes"
  ),
  Natureza = c(
    "Planejamento",
    "Analise documental realizada",
    "Analise documental preliminar",
    "Verificacao documental",
    "Planejado - nao executado",
    "Conclusao documental"
  ),
  Evidencia = c(
    "Escopo academico do trabalho",
    "DFP 2025 e relatorio do auditor independente",
    "Demonstracoes contabeis publicadas; analise limitada",
    "Relatorio do auditor e notas explicativas publicados",
    "Sem acesso a fluxo de caixa projetado, planos internos ou atas",
    "Informacoes publicamente divulgadas"
  ),
  Resultado = c(
    "Avaliar a adequacao da consideracao de continuidade operacional",
    "Documentos publicos identificados como fonte de analise",
    "Indicadores devem ser interpretados em conjunto; nao comprovam isoladamente risco de continuidade",
    "Registrar somente o que estiver expressamente divulgado nos documentos",
    "Testes de previsoes, financiamento futuro e planos da administracao nao executados",
    "Nao concluir sobre ausencia ou existencia de incerteza relevante sem evidencias suficientes"
  ),
  Limitacao = rep(
    "Trabalho academico; nao equivale a auditoria independente",
    6
  ),
  stringsAsFactors = FALSE
)

write.csv(
  pt_continuidade,
  "02_papeis_trabalho/PT08_continuidade_operacional.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Papel de trabalho PT08 criado.\n")
cat("Arquivo: 02_papeis_trabalho/PT08_continuidade_operacional.csv\n")
print(pt_continuidade)

