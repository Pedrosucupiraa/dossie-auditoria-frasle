# 04_codigo/41_calculo_materialidade.R
# PT 320 - Materialidade (NBC TA 320 e NBC TA 450)
#
# Valores de entrada: DFP 2025 consolidada da Fras-le Mobility (CVM), em R$ mil.
#   Balanço Patrimonial: conta 1 (Ativo Total) e 2.03 (Patrimônio Líquido Consolidado)
#   DRE consolidada: 3.01 (Receita de Venda), 3.06 (Resultado Financeiro),
#                    3.07 (Resultado Antes dos Tributos), 3.11 (Lucro Consolidado)
# Os percentuais são premissas acadêmicas usuais; a NBC TA 320 NÃO fixa percentuais.
#
# Gera:
#   05_resultados/calculo_materialidade.csv
#   05_resultados/comparacao_referenciais_materialidade.csv
#   02_papeis_trabalho/PT32_materialidade.csv

dir.create("05_resultados", showWarnings = FALSE)
dir.create("02_papeis_trabalho", showWarnings = FALSE)

fmt <- function(x, d = 2) formatC(x, format = "f", digits = d, big.mark = ".", decimal.mark = ",")

# ------------------------------------------------------------------ entradas
saldo_intangivel <- 1874550            # R$ mil (população do teste MUS)
pct_execucao <- 0.75                   # materialidade de execução = 75% da global
pct_ldi      <- 0.05                   # limite de distorções irrelevantes = 5% da global
fator_conf   <- 3.0                    # mesmo fator usado no PT 530

ref <- data.frame(
  referencial = c("Ativo total", "Receita de venda (líquida)", "Lucro antes dos tributos",
                  "Patrimônio líquido consolidado"),
  conta_dfp = c("1", "3.01", "3.07", "2.03"),
  valor_2025_mil = c(7222660, 5490878, 320897, 2481481),
  valor_2024_mil = c(4869614, 3965776, 543300, 2251485),
  percentual = c(0.01, 0.01, 0.05, 0.01),
  stringsAsFactors = FALSE
)
selecionado <- "Ativo total"

ref$variacao_pct <- (ref$valor_2025_mil / ref$valor_2024_mil - 1) * 100
ref$materialidade_global_mil <- ref$valor_2025_mil * ref$percentual
ref$materialidade_execucao_mil <- ref$materialidade_global_mil * pct_execucao
ref$intervalo_mus_mil <- ref$materialidade_execucao_mil / fator_conf
ref$selecoes_mus <- ceiling(saldo_intangivel / ref$intervalo_mus_mil)
ref$selecionado <- ifelse(ref$referencial == selecionado, "SIM", "não")

mg <- ref$materialidade_global_mil[ref$referencial == selecionado]
ref$global_adotada_sobre_este_pct <- round(mg / ref$materialidade_global_mil * 100, 1)

# O intangível entra como materialidade ESPECÍFICA (não é referencial global)
mat_especifica <- 0.01 * saldo_intangivel

me  <- mg * pct_execucao
ldi <- mg * pct_ldi

# ---------------------------------------------------- calculo_materialidade.csv
calculo <- data.frame(
  parametro = c("Materialidade global", "Materialidade de execução",
                "Limite de distorções irrelevantes", "Materialidade específica do intangível"),
  base_referencia = c("Ativo total 2025 (DFP 1)", "Materialidade global", "Materialidade global",
                      "Saldo do intangível 2025"),
  valor_base_mil = c(ref$valor_2025_mil[ref$referencial == selecionado], mg, mg, saldo_intangivel),
  percentual_aplicado = c("1,0%", "75,0%", "5,0%", "1,0%"),
  valor_calculado_mil = round(c(mg, me, ldi, mat_especifica), 2),
  justificativa = c("Referencial principal; ver PT32 e comparacao_referenciais_materialidade.csv",
                    "Premissa acadêmica de 75% da global",
                    "Premissa acadêmica de 5% da global (NBC TA 450)",
                    "Premissa acadêmica; registrada como limite específico, não usada para dimensionar a MUS"),
  stringsAsFactors = FALSE
)
write.csv(calculo, "05_resultados/calculo_materialidade.csv", row.names = FALSE, fileEncoding = "UTF-8")

# ------------------------------------------- comparacao_referenciais_materialidade.csv
saida <- ref[, c("referencial", "conta_dfp", "valor_2025_mil", "valor_2024_mil", "variacao_pct",
                 "percentual", "materialidade_global_mil", "materialidade_execucao_mil",
                 "intervalo_mus_mil", "selecoes_mus", "global_adotada_sobre_este_pct", "selecionado")]
saida$variacao_pct <- round(saida$variacao_pct, 1)
saida[, c("materialidade_global_mil", "materialidade_execucao_mil", "intervalo_mus_mil")] <-
  round(saida[, c("materialidade_global_mil", "materialidade_execucao_mil", "intervalo_mus_mil")], 2)
write.csv(saida, "05_resultados/comparacao_referenciais_materialidade.csv",
          row.names = FALSE, fileEncoding = "UTF-8")

# ------------------------------------------------------------------ textos do PT32
g <- function(nome, campo) ref[[campo]][ref$referencial == nome]
ordem <- order(ref$materialidade_global_mil)
menor <- ref$referencial[ordem[1]]
maior <- ref$referencial[ordem[length(ordem)]]

res_comparacao <- paste(sprintf("%s (%s%%): R$ %s mil",
                                ref$referencial, fmt(ref$percentual * 100, 0),
                                fmt(ref$materialidade_global_mil)), collapse = "; ")

LIM <- "Trabalho acadêmico baseado em informações públicas; percentuais são premissas, pois a NBC TA 320 não fixa percentuais; não equivale a auditoria independente"
linhas <- list(
  c("Definir o objetivo da fixação da materialidade",
    "Planejamento", "Escopo acadêmico; NBC TA 320 e NBC TA 450",
    "Fixar materialidade global, de execução, limite de distorções irrelevantes e materialidade específica do intangível"),
  c("Levantar os referenciais nas demonstrações consolidadas de 2025 e 2024",
    "Evidência pública", "01_fontes/155265_006211_20102026101023.pdf (BP: 1 e 2.03; DRE: 3.01 e 3.07)",
    paste0("Ativo total R$ ", fmt(g("Ativo total", "valor_2025_mil"), 0), " mil; receita R$ ",
           fmt(g("Receita de venda (líquida)", "valor_2025_mil"), 0), " mil; lucro antes dos tributos R$ ",
           fmt(g("Lucro antes dos tributos", "valor_2025_mil"), 0), " mil; patrimônio líquido R$ ",
           fmt(g("Patrimônio líquido consolidado", "valor_2025_mil"), 0), " mil")),
  c("Calcular a materialidade global sob cada referencial",
    "Evidência pública", "05_resultados/comparacao_referenciais_materialidade.csv",
    res_comparacao),
  c("Avaliar a estabilidade de cada referencial entre 2024 e 2025",
    "Evidência pública", "05_resultados/comparacao_referenciais_materialidade.csv",
    paste0("Variação 2025 contra 2024: ativo total ", fmt(g("Ativo total", "variacao_pct"), 1),
           "%; receita ", fmt(g("Receita de venda (líquida)", "variacao_pct"), 1),
           "%; patrimônio líquido ", fmt(g("Patrimônio líquido consolidado", "variacao_pct"), 1),
           "%; lucro antes dos tributos ", fmt(g("Lucro antes dos tributos", "variacao_pct"), 1),
           "%; o resultado financeiro passou de +R$ 24.129 mil para -R$ 403.209 mil")),
  c("Justificar o ativo total como referencial principal",
    "Análise documental", "Itens anteriores deste PT",
    paste0("O trabalho examina uma conta patrimonial (intangível, ", fmt(saldo_intangivel / g("Ativo total", "valor_2025_mil") * 100, 2),
           "% do ativo); o lucro antes dos tributos oscilou ", fmt(g("Lucro antes dos tributos", "variacao_pct"), 1),
           "% e é afetado por resultado financeiro volátil. O ativo total também cresceu ",
           fmt(g("Ativo total", "variacao_pct"), 1),
           "%, portanto a escolha não se apoia em estabilidade, mas na natureza patrimonial do objeto e na instabilidade do lucro")),
  c("Concluir a comparação com os demais referenciais",
    "Análise documental", "05_resultados/comparacao_referenciais_materialidade.csv",
    paste0("A materialidade global adotada (R$ ", fmt(mg), " mil) é a maior entre os referenciais (", maior,
           "), equivale a ", fmt(g("Lucro antes dos tributos", "global_adotada_sobre_este_pct"), 1),
           "% da obtida com ", tolower(menor), " e a ",
           fmt(g("Receita de venda (líquida)", "global_adotada_sobre_este_pct"), 1),
           "% da obtida com a receita; a escolha é a mais permissiva da comparação")),
  c("Medir o efeito da escolha sobre a extensão da amostragem (PT 530)",
    "Simulação (base sintética)", "05_resultados/comparacao_referenciais_materialidade.csv",
    paste0("Seleções MUS: ", paste(sprintf("%s = %d", ref$referencial, ref$selecoes_mus), collapse = "; "),
           "; a amostra de ", g("Ativo total", "selecoes_mus"), " seleções é a menor, por refletir a materialidade mais alta")),
  c("Definir materialidade de execução, limite de distorções irrelevantes e materialidade específica",
    "Evidência pública", "05_resultados/calculo_materialidade.csv",
    paste0("Execução (75%): R$ ", fmt(me), " mil; limite de distorções irrelevantes (5%): R$ ", fmt(ldi),
           " mil; específica do intangível (1% do saldo): R$ ", fmt(mat_especifica), " mil (não usada no dimensionamento da MUS)")),
  c("Registrar conclusão e limitações",
    "Conclusão documental", "Itens anteriores deste PT",
    paste0("Ativo total mantido como referencial, por ser o objeto patrimonial e o lucro instável, com ciência de que é a escolha mais permissiva; ",
           "percentuais são premissas acadêmicas e a materialidade deveria ser reavaliada com a conclusão dos testes"))
)

pt32 <- do.call(rbind, lapply(seq_along(linhas), function(i) {
  l <- linhas[[i]]
  data.frame(Codigo = sprintf("PT32-%02d", i), Norma = "NBC TA 320 / NBC TA 450",
             Procedimento = l[1], Natureza = l[2], Evidencia = l[3], Resultado = l[4],
             Limitacao = LIM, stringsAsFactors = FALSE)
}))
write.csv(pt32, "02_papeis_trabalho/PT32_materialidade.csv", row.names = FALSE, fileEncoding = "UTF-8")

cat("Materialidade global:", fmt(mg), "| execução:", fmt(me), "| LDI:", fmt(ldi),
    "| específica intangível:", fmt(mat_especifica), "\n")
print(saida[, c("referencial", "materialidade_global_mil", "selecoes_mus")])
cat("PT32_materialidade.csv gerado. Pode apagar PT32_materialidade.txt.\n")
