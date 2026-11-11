
# PT14 - NBC TA 510: Saldos Iniciais

pt510 <- data.frame(
  Codigo = sprintf("PT14-%02d", 1:6),
  Titulo = rep("Saldos Iniciais", 6),
  Norma = rep("NBC TA 510", 6),
  
  Objetivo_PT = c(
    "Definir o objetivo da avaliacao dos saldos iniciais.",
    "Comparar saldos finais de 2024 e iniciais de 2025 quando as informacoes estiverem disponiveis.",
    "Examinar a consistencia das informacoes comparativas publicadas.",
    "Considerar riscos de distorcao relevante originados em periodos anteriores.",
    "Definir procedimentos adicionais necessarios para obter evidencia sobre saldos iniciais.",
    "Documentar a conclusao preliminar e as limitacoes da analise."
  ),
  
  Tema = c(
    "Objetivo e escopo",
    "Comparacao de saldos",
    "Informacoes comparativas",
    "Riscos de periodos anteriores",
    "Procedimentos adicionais",
    "Conclusao e limitacoes"
  ),
  
  Risco_ou_aspecto_avaliado = c(
    "Escopo insuficiente para avaliar os saldos iniciais.",
    "Diferencas entre saldos finais anteriores e saldos iniciais do periodo atual.",
    "Inconsistencias ou omissoes nas informacoes comparativas.",
    "Distorcoes originadas em periodos anteriores com efeito no periodo atual.",
    "Ausencia de evidencia suficiente e apropriada sobre saldos iniciais.",
    "Risco de apresentar conclusoes alem do alcance das evidencias obtidas."
  ),
  
  Procedimento = c(
    "Delimitar os objetivos e as limitacoes da analise academica.",
    "Comparar os valores publicados de 2024 e 2025 quando houver correspondencia adequada entre as contas.",
    "Examinar demonstracoes financeiras e notas explicativas publicadas.",
    "Identificar riscos preliminares que exigiriam procedimentos adicionais em auditoria real.",
    "Planejar testes adicionais e consulta aos papeis do auditor anterior, se aplicavel.",
    "Registrar o que foi analisado, o que permanece pendente e as limitacoes."
  ),
  
  Natureza = c(
    "Planejamento",
    "Analise documental; comparacao a confirmar por conta",
    "Analise documental",
    "Avaliacao preliminar",
    "Planejado - nao executado",
    "Conclusao documental"
  ),
  
  Evidencia_ou_fonte = c(
    "Escopo academico do trabalho.",
    "DFP 2025 e informacoes comparativas de 2024.",
    "Demonstracoes financeiras e notas explicativas publicadas.",
    "Saldos comparativos e riscos identificados no dossie.",
    "Papeis do auditor anterior e registros internos nao disponibilizados.",
    "Documentos publicos examinados e papeis de trabalho produzidos."
  ),
  
  Referencias_cruzadas = c(
    "01_fontes; README",
    "05_resultados/comparacao_intangivel_2024_2025.csv",
    "01_fontes; PT03; PT04",
    "PT07; PT17",
    "PT16; documentacao interna nao disponivel",
    "Relatorio tecnico do dossie"
  ),
  
  Resultado = c(
    "Escopo da analise de saldos iniciais documentado.",
    "A comparacao deve ser interpretada por conta e conforme a natureza dos saldos; variacoes entre exercicios nao comprovam, isoladamente, divergencias de abertura.",
    "As informacoes publicadas permitem analise documental, mas nao substituem os registros contabeis subjacentes.",
    "Foram considerados riscos preliminares, sem presumir a existencia de erro.",
    "Testes especificos de saldos iniciais nao executados por falta de acesso a registros internos e papeis do auditor anterior.",
    "A analise publica, isoladamente, nao comprova a existencia ou exatidao dos saldos iniciais."
  ),
  
  Status_procedimento = c(
    "Escopo documentado",
    "Comparacao por conta pendente de verificacao",
    "Analise documental planejada",
    "Riscos preliminares documentados",
    "Procedimento adicional nao executado",
    "Limitacoes documentadas"
  ),
  
  Limitacao = rep(
    "Trabalho academico baseado em informacoes publicas; nao equivale a auditoria independente e nao inclui acesso a registros contabeis internos ou papeis do auditor anterior.",
    6
  ),
  
  Preparador = rep("241003375", 6),
  Data_elaboracao = rep("2026-10-24", 6),
  Revisor = rep("Pendente de revisao", 6),
  Data_revisao = rep("Pendente", 6),
  
  stringsAsFactors = FALSE
)

write.csv(
  pt510,
  "02_papeis_trabalho/PT14_saldos_iniciais.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("PT14 - NBC TA 510 atualizado.\n")
cat("Arquivo: 02_papeis_trabalho/PT14_saldos_iniciais.csv\n")
cat("Quantidade de linhas:", nrow(pt510), "\n")
cat("Quantidade de colunas:", ncol(pt510), "\n")

print(pt510[, c(
  "Codigo", "Tema", "Status_procedimento", "Revisor"
)])

