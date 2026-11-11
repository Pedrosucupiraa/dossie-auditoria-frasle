# 04_codigo/39_gerar_relatorio_tecnico.R
# Gera o relatório técnico a partir dos CSVs de resultados.
# Os números das tabelas e das conclusões vêm de 05_resultados/ e 06_matrizes/.
# Execute DEPOIS dos scripts 43, 18, 41 e 14.
# Saídas: 02_papeis_trabalho/relatorio_tecnico_v2.md (e .pdf, se rmarkdown estiver instalado)

dir.create("02_papeis_trabalho", showWarnings = FALSE, recursive = TRUE)

# ----------------------------------------------------------------- utilitários
fmt <- function(x, d = 2) formatC(x, format = "f", digits = d, big.mark = ".", decimal.mark = ",")
le  <- function(arq) read.csv(arq, stringsAsFactors = FALSE, fileEncoding = "UTF-8", check.names = FALSE)
md_tabela <- function(df) {
  df[] <- lapply(df, function(x) gsub("\\|", "/", as.character(x)))
  c(paste0("| ", paste(names(df), collapse = " | "), " |"),
    paste0("|", paste(rep(" --- ", ncol(df)), collapse = "|"), "|"),
    apply(df, 1, function(l) paste0("| ", paste(l, collapse = " | "), " |")))
}

# ------------------------------------------------------------------- dados
mat    <- le("05_resultados/calculo_materialidade.csv")
refs   <- le("05_resultados/comparacao_referenciais_materialidade.csv")
anal   <- le("05_resultados/analise_procedimentos_analiticos.csv")
reco   <- le("05_resultados/reconciliacao_intangivel_revisada.csv")
mus    <- le("05_resultados/amostragem_mus_projecao.csv")
sens   <- le("05_resultados/analise_sensibilidade_impairment.csv")
rup    <- le("05_resultados/analise_sensibilidade_ponto_ruptura.csv")
det    <- le("05_resultados/comparacao_erros_teste.csv")
sinal  <- le("05_resultados/resumo_deteccao_independente.csv")
matriz <- le("06_matrizes/matriz_cobertura_normas.csv")

m <- function(p) mat$valor_calculado_mil[mat$parametro == p]
mus_v <- function(p) mus$valor[mus$parametro_amostral == p]
mg <- m("Materialidade global"); me <- m("Materialidade de execução")
ldi <- m("Limite de distorções irrelevantes"); mesp <- m("Materialidade específica do intangível")
saldo <- reco$saldo_divulgado_R_mil

# ------------------------------------------------------------------- tabelas
t_ref <- data.frame(
  Referencial = refs$referencial,
  `Valor 2025` = fmt(refs$valor_2025_mil, 0),
  `Variação vs 2024` = paste0(fmt(refs$variacao_pct, 1), "%"),
  Percentual = paste0(fmt(refs$percentual * 100, 0), "%"),
  `Materialidade global` = fmt(refs$materialidade_global_mil),
  `Seleções MUS` = refs$selecoes_mus,
  Adotado = refs$selecionado, check.names = FALSE)

t_mat <- data.frame(Parâmetro = mat$parametro, Base = mat$base_referencia,
                    Percentual = mat$percentual_aplicado,
                    `Valor (R$ mil)` = fmt(mat$valor_calculado_mil), check.names = FALSE)

t_anal <- data.frame(Conta = anal$Conta, `2024` = fmt(anal$Valor_2024, 0), `2025` = fmt(anal$Valor_2025, 0),
                     `Variação` = fmt(anal$Variacao_absoluta, 0),
                     `Variação %` = paste0(fmt(anal$Variacao_percentual, 1), "%"),
                     Observação = anal$Observacao, check.names = FALSE)

t_sens <- data.frame(Cenário = sens$cenario, WACC = sens$wacc_aplicado,
                     `Valor recuperável (R$ mil)` = fmt(sens$valor_recuperavel_mil, 0),
                     `Margem` = paste0(fmt(sens$margem_pct, 1), "%"),
                     `Perda simulada (R$ mil)` = fmt(sens$impairment_necessario_mil, 0), check.names = FALSE)

t_det <- data.frame(Tipo = det$categoria, Inseridos = det$erros_inseridos,
                    Sinalizados = det$erros_sinalizados_pelo_teste,
                    `Não detectados` = det$erros_inseridos - det$erros_sinalizados_pelo_teste,
                    `Detecção` = paste0(fmt(det$taxa_deteccao_pct, 1), "%"), check.names = FALSE)

t_sinal <- data.frame(Teste = sinal$teste, `Registros sinalizados` = fmt(sinal$registros_sinalizados, 0),
                      check.names = FALSE)

t_matriz <- data.frame(Atividade = matriz$norma, Status = matriz$status_cobertura,
                       Evidência = matriz$evidencia_vinculada, check.names = FALSE)

nao_det <- sum(det$erros_inseridos - det$erros_sinalizados_pelo_teste)
erros_total <- sum(det$erros_inseridos)

# ------------------------------------------------------------------- texto
linhas <- c(
  "# Relatório Técnico — Dossiê Acadêmico de Auditoria",
  "**Frasle Mobility S.A. | Exercício de 2025**",
  "",
  "## 1. Identificação",
  "",
  "- **Companhia analisada:** Frasle Mobility S.A. (Companhia Aberta, registro CVM 0155265)",
  "- **Exercício:** 01/01/2025 a 31/12/2025, com comparativos de 2024",
  "- **Instituição / disciplina:** Universidade de Brasília — Auditoria 1 (CCA0024), Turma 02, 2026.2",
  "- **Docente:** Prof. Dr. Lucas Oliveira Gomes Ferreira",
  "- **Estudante:** Pedro Henrique De Oliveira Sucupira (matrícula 241003375)",
  paste0("- **Data de geração:** ", format(Sys.Date(), "%d/%m/%Y")),
  "",
  "## 2. Natureza do trabalho e como ler os resultados",
  "",
  "Este é um trabalho acadêmico. Não houve contratação, acesso à companhia, contato com a administração nem opinião de auditoria. Cada resultado deste relatório é de um de três tipos:",
  "",
  "- **Evidência pública:** dado extraído das demonstrações financeiras publicadas na CVM (`01_fontes/`).",
  "- **Planejado — não executado:** procedimento descrito, mas que dependeria de acesso que não existiu.",
  "- **Simulação:** teste sobre a base sintética de 500.000 registros ou sobre premissas hipotéticas; vale só para a simulação e não é evidência sobre a companhia.",
  "",
  "A coluna de status da matriz de cobertura (seção 10) classifica cada uma das 27 atividades. Nenhuma está marcada como executada em auditoria real.",
  "",
  "## 3. Fontes e método",
  "",
  "- Demonstrações financeiras consolidadas de 2025 e 2024 (CVM, documento 155265), consultadas em 23/10/2026 (`01_fontes/registro_fontes.csv`).",
  "- Cálculos em R, numerados em `04_codigo/`, gerando os arquivos de `05_resultados/`. Este relatório lê esses arquivos para montar as tabelas e os resultados.",
  "- A base sintética (`03_base_sintetica/`) foi gerada por código, é identificada como sintética em cada registro e foi construída para somar ao saldo público do intangível.",
  "",
  "## 4. Materialidade (NBC TA 320 e 450) — PT32",
  "",
  paste0("Foi adotado o **ativo total de 2025** como referencial principal, com materialidade global de R$ ", fmt(mg),
         " mil. Os percentuais são premissas acadêmicas; a NBC TA 320 não fixa percentuais. A comparação com os demais referenciais, a partir das demonstrações consolidadas:"),
  "",
  md_tabela(t_ref),
  "",
  paste0("A materialidade adotada é a **mais alta** da comparação. Justificativa: o objeto do trabalho é uma conta patrimonial (o intangível, ",
         fmt(saldo / refs$valor_2025_mil[refs$referencial == "Ativo total"] * 100, 2),
         "% do ativo) e o lucro antes dos tributos variou ",
         fmt(refs$variacao_pct[refs$referencial == "Lucro antes dos tributos"], 1),
         "% no ano. O ativo total também variou ", fmt(refs$variacao_pct[refs$referencial == "Ativo total"], 1),
         "%, então a escolha não se apoia em estabilidade. Como consequência, a amostra MUS fica menor (",
         refs$selecoes_mus[refs$referencial == "Ativo total"], " seleções contra ",
         refs$selecoes_mus[refs$referencial == "Lucro antes dos tributos"], " com o lucro antes dos tributos)."),
  "",
  md_tabela(t_mat),
  "",
  "Detalhe e cálculo editável: `02_papeis_trabalho/PT32_materialidade.csv` e `05_resultados/sensibilidade_mus_editavel.xlsx`.",
  "",
  "## 5. Procedimentos analíticos (NBC TA 520) — PT17",
  "",
  "Evidência pública: comparação dos saldos consolidados de 2024 e 2025.",
  "",
  md_tabela(t_anal),
  "",
  "As variações são sinais para investigação, não erros. A demonstração dos fluxos de caixa consolidada registra saída de R$ 2.090.324 mil em combinação de negócios em 2025, compatível com o crescimento do intangível, mas a alocação do preço de aquisição e o teste de ágio não foram examinados e as explicações da administração não foram obtidas.",
  "",
  "## 6. Reconciliação aritmética do intangível — PT05",
  "",
  paste0("Evidência pública: saldo inicial R$ ", fmt(reco$saldo_inicial_R_mil, 0), " mil + movimentações R$ ",
         fmt(reco$total_movimentacoes_R_mil, 0), " mil = R$ ", fmt(reco$saldo_calculado_R_mil, 0),
         " mil, igual ao saldo divulgado; diferença de R$ ", fmt(reco$diferenca_R_mil, 0),
         " mil. A reconciliação aritmética não comprova existência, direitos, mensuração nem recuperabilidade."),
  "",
  "## 7. Base sintética e testes de detecção — PT06 e PT_450 (simulação)",
  "",
  paste0("A base tem 500.000 registros e ", erros_total, " erros inseridos deliberadamente. Resultado dos testes automáticos em R:"),
  "",
  md_tabela(t_det),
  "",
  paste0("**", nao_det, " erros inseridos não foram detectados** (24 de vida útil e 28 de amortização), todos em registros de Goodwill: o teste de vida útil exclui Goodwill por desenho e, nos de amortização, o valor registrado e o esperado são zero. Os registros estão em `05_resultados/erros_vida_util_nao_detectados.csv` e `erros_amortizacao_nao_detectados.csv`. O teste de indicador de impairment sinalizou mais registros do que os erros inseridos:"),
  md_tabela(t_sinal),
  "",
  "A maior parte das sinalizações de indicador de impairment corresponde ao estado 'Nao avaliado', que é um valor válido na simulação e que o teste também sinaliza; essas sinalizações não foram investigadas individualmente.",
  "",
  "## 8. Amostragem por unidade monetária — PT_530 (simulação)",
  "",
  paste0("Sobre a base sintética (R$ ", fmt(as.numeric(mus_v("Valor monetário da população (V)")), 0),
         " mil): confiança de 95%, materialidade de execução de R$ ", fmt(me),
         " mil, intervalo de R$ ", fmt(as.numeric(mus_v("Intervalo de amostragem (J)"))),
         " mil e ", mus_v("Número de seleções (n = V / J, arredondado para cima)"),
         " seleções, sorteadas com semente ", mus_v("Semente do sorteio"),
         ". A lista dos itens está em `05_resultados/mus_amostra_selecionada.csv`."),
  "",
  paste0("Resultado: ", mus_v("Erros encontrados na amostra"), " erro(s) inserido(s) entre os itens selecionados; limite superior de distorção de R$ ",
         fmt(as.numeric(mus_v("Limite superior de distorção (Stringer, 95%)"))), " mil contra materialidade de execução de R$ ", fmt(me), " mil."),
  "",
  paste0("Limite desta evidência: os ", erros_total, " erros inseridos somam apenas R$ 1.056,35 mil de valor contábil; uma amostra dessa dimensão tem baixa chance de encontrá-los, e a ausência de erros na amostra não prova a ausência de erros na base. A conclusão vale só para a simulação."),
  "",
  "## 9. Sensibilidade de um DCF didático — PT02 (simulação)",
  "",
  "O modelo abaixo é **didático e ilustrativo**: fluxo de caixa, WACC e crescimento são premissas hipotéticas do autor, não o modelo da administração da Frasle nem dado público. O exercício demonstra o método de sensibilidade; **não conclui sobre a razoabilidade da estimativa real**, que não foi testada (método, dados, premissas e viés da administração permanecem fora do alcance).",
  "",
  paste0("Premissas hipotéticas: fluxo de caixa de R$ ", fmt(sens$fluxo_caixa_hipotetico_mil[1], 0),
         " mil por ano, g de ", sens$taxa_g[1], ". Valor contábil comparado: R$ ", fmt(saldo, 0), " mil."),
  "",
  md_tabela(t_sens),
  "",
  paste0("Ponto de ruptura do modelo ilustrativo: WACC de ", fmt(rup$valor[1]), "% (", fmt(rup$valor[2]),
         " p.p. acima do cenário base) ou queda de ", fmt(rup$valor[4], 1), "% no fluxo de caixa. Grade completa em `05_resultados/analise_sensibilidade_grade.csv`."),
  "",
  "## 10. Matriz de cobertura das 27 atividades",
  "",
  "Fonte: `06_matrizes/matriz_cobertura_normas.csv`. Todas as atividades têm status parcial ou planejado; o detalhe de cada resultado e de cada limitação está na matriz e no PT indicado.",
  "",
  md_tabela(t_matriz),
  "",
  "## 11. Relatório dos auditores independentes (evidência pública)",
  "",
  "O relatório da KPMG Auditores Independentes S.S., de 11 de março de 2026, que consta do documento da CVM, expressa opinião sem ressalva sobre as demonstrações individuais e consolidadas. Esse relatório é de terceiros e não substitui nem foi revisado por este trabalho.",
  "",
  "## 12. Exceções não resolvidas e limites do alcance",
  "",
  paste0("- ", nao_det, " dos ", erros_total, " erros simulados não foram detectados pelos testes. A origem foi localizada (Goodwill, fora do alcance do teste), mas os testes não foram redesenhados para cobri-los."),
  "- As sinalizações de indicador de impairment acima dos erros inseridos não foram investigadas.",
  "- O efeito monetário dos erros simulados foi medido só para amortização inconsistente; vida útil e indicador de impairment não têm efeito monetário direto na base.",
  "- A estimativa de recuperabilidade real, os controles internos, as confirmações externas, as representações da administração e os componentes do grupo não foram examinados: não houve acesso.",
  "- Os papéis de trabalho de várias normas têm natureza conceitual ou de planejamento. A documentação ainda precisa consolidar versões duplicadas e padronizar o esquema de colunas dos PTs antigos.",
  "",
  "## 13. Conclusão",
  "",
  paste0("Com base apenas em informações públicas e em uma base sintética, este trabalho (i) fixou e justificou a materialidade com comparação de quatro referenciais, (ii) verificou que o saldo do intangível reconcilia aritmeticamente com a nota publicada, (iii) demonstrou testes de detecção e uma amostra MUS reproduzível sobre dados simulados e (iv) demonstrou o método de sensibilidade com premissas hipotéticas. ",
         "Não é possível concluir sobre a existência, a mensuração ou a recuperabilidade do intangível da companhia, nem sobre as demais contas. Os resultados sobre a base sintética não se aplicam à Frasle Mobility S.A."),
  "",
  "## 14. Referências",
  "",
  "- CFC: Normas Brasileiras de Contabilidade Técnicas de Auditoria (NBC TA 200 a 600).",
  "- CVM: Demonstrações Financeiras Padronizadas (DFP 2025) — Frasle Mobility S.A. (documento 155265).",
  "- Portal de Relações com Investidores: ri.fraslemobility.com."
)

con <- file("02_papeis_trabalho/relatorio_tecnico_v2.md", open = "w", encoding = "UTF-8")
writeLines(linhas, con)
close(con)
cat("Relatório gerado: 02_papeis_trabalho/relatorio_tecnico_v2.md\n")

if (requireNamespace("rmarkdown", quietly = TRUE)) {
  try(rmarkdown::render(input = "02_papeis_trabalho/relatorio_tecnico_v2.md",
                        output_file = "relatorio_tecnico_v2.pdf", quiet = TRUE), silent = TRUE)
  cat("Tentativa de gerar o PDF concluída (exige LaTeX instalado).\n")
} else {
  cat("Aviso: instale o pacote rmarkdown para gerar o PDF automaticamente.\n")
}
