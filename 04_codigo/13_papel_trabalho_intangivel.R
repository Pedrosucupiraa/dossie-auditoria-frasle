
# PT06 - Auditoria de ativos intangiveis
# Trabalho academico com procedimentos simulados.
# Nao constitui auditoria independente real.

dir.create("02_papeis_trabalho", showWarnings = FALSE)

pt06 <- data.frame(
  campo = c(
    "Codigo",
    "Titulo",
    "Normas relacionadas",
    "Preparador",
    "Data de elaboracao",
    "Revisor",
    "Objetivo",
    "Conta auditada",
    "Saldo de referencia",
    "Origem do saldo",
    "Assercoes relevantes",
    "Riscos identificados",
    "Populacao analisada",
    "Fonte da populacao",
    "Procedimentos executados",
    "Evidencias e referencias cruzadas",
    "Resultados",
    "Excecoes identificadas",
    "Conclusao",
    "Limitacoes",
    "Proximos procedimentos"
  ),
  descricao = c(
    "PT06",
    "Procedimentos sobre ativos intangiveis",
    "NBC TA 200, 230, 300, 315, 320, 330, 500, 530 e 540, conforme aplicabilidade",
    "Matricula 241003375",
    as.character(Sys.Date()),
    "Pendente de revisao academica; nao preencher como revisado sem revisao efetiva",
    "Avaliar, para fins educacionais, riscos de reconhecimento, mensuracao, amortizacao e recuperabilidade dos ativos intangiveis.",
    "Ativo intangivel consolidado",
    "R$ 1.874.550 mil em 31/12/2025",
    "Demonstracoes financeiras consolidadas de 2025 e Nota Explicativa 18; confirmar pagina e referencia no documento-fonte.",
    "Existencia, direitos e obrigacoes, integridade, exatidao, avaliacao e alocacao, classificacao e apresentacao.",
    "Risco de vida util inadequada, amortizacao incorreta, reconhecimento indevido e perda por impairment nao reconhecida.",
    "Base sintetica com 500.000 registros e 250 erros intencionalmente inseridos.",
    "Arquivo base_sintetica_intangivel.csv, acompanhado de log_erros_inseridos.csv. Dados sinteticos, nao extraidos do cadastro real da companhia.",
    "Validacao da quantidade de registros, unicidade dos IDs, consistencia da quantidade de erros no log e reconciliacao do total sintetico ao saldo de referencia. Testes de excecao executados sobre a base sintetica.",
    "PT02: Nota 16 e impairment; PT03: Nota 18; PT04: movimentacao do intangivel; PT05: reconciliacao; arquivos de validacao e analise em 05_resultados.",
    "A base apresentou 500.000 registros, 500.000 IDs unicos, 250 erros marcados e 250 linhas no log. Soma do valor contabil sintetico reconciliada a R$ 1.874.550 mil.",
    "Foram criadas excecoes simuladas de vida util, amortizacao e indicador de impairment. A deteccao depende das regras aplicadas; sinalizacao nao equivale automaticamente a erro contabil real.",
    "Os controles estruturais e a reconciliacao sintetica passaram. Os testes demonstram funcionamento do procedimento sobre dados artificiais, mas nao comprovam a existencia, avaliacao ou recuperabilidade dos ativos reais da companhia.",
    "Base sintetica; ausencia de acesso ao razao contabil, contratos, cadastro real de intangiveis, laudos de avaliacao, projecoes aprovadas e evidencias internas.",
    "Conferir a movimentacao da Nota 18 diretamente na DFP; analisar a politica de amortizacao por classe; avaliar premissas de impairment da Nota 16; documentar quais procedimentos possuem evidencia publica e quais permanecem planejados ou simulados."
  ),
  stringsAsFactors = FALSE
)

write.csv(
  pt06,
  "02_papeis_trabalho/PT06_auditoria_intangivel.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("PT06 criado em 02_papeis_trabalho/PT06_auditoria_intangivel.csv\n")
