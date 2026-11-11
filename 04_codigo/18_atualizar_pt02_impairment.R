# 04_codigo/18_atualizar_pt02_impairment.R
# PT 540 (sensibilidade de estimativa) e PT 530 (amostragem MUS).
#
# IMPORTANTE - natureza dos resultados:
#  * O DCF abaixo é DIDÁTICO E ILUSTRATIVO. Fluxo de caixa, WACC e g são
#    premissas HIPOTÉTICAS definidas pelo autor; não são o modelo da
#    administração da Fras-le nem foram obtidas de fonte pública.
#    O resultado mostra o método de sensibilidade, não a razoabilidade da
#    estimativa real.
#  * A amostra MUS é selecionada sobre a base SINTÉTICA; vale só para a simulação.
#
# Reexecução: source("04_codigo/18_atualizar_pt02_impairment.R")
# Pré-requisitos: 03_base_sintetica/base_sintetica_intangivel.csv

dir.create("05_resultados", showWarnings = FALSE)
dir.create("02_papeis_trabalho", showWarnings = FALSE)

fmt <- function(x, d = 2) {
  formatC(x, format = "f", digits = d, big.mark = ".", decimal.mark = ",")
}

# =====================================================================
# 1. PREMISSAS EDITÁVEIS
# =====================================================================
valor_contabil <- 1874550.00   # R$ mil - saldo público do intangível (DFP 2025)

# --- Premissas HIPOTÉTICAS do DCF didático (alterar aqui para testar outros cenários)
fcf_base  <- 250000.00         # fluxo de caixa anual hipotético (R$ mil)
wacc_base <- 0.115             # taxa de desconto hipotética
taxa_g    <- 0.03              # crescimento na perpetuidade hipotético

# --- Parâmetros da amostragem
ativo_total <- 7222660.00      # R$ mil - ativo total 2025 (DFP)
mat_global  <- 0.01 * ativo_total
me          <- 0.75 * mat_global   # materialidade de execução (R$ mil)
fator_conf  <- 3.00                # fator de confiança de planejamento (95%, zero erros)
semente     <- 241003375           # semente do sorteio (matrícula)

# =====================================================================
# 2. SENSIBILIDADE DO DCF DIDÁTICO (PT 540)
# =====================================================================
deltas <- c(-0.02, -0.01, 0.00, 0.01, 0.02, 0.05)
wacc   <- wacc_base + deltas
vr     <- fcf_base / (wacc - taxa_g)
imp    <- pmax(0, valor_contabil - vr)
margem <- (vr / valor_contabil - 1) * 100

cenario <- ifelse(deltas == 0, "Cenário base",
                  sprintf("WACC %+.1f p.p.", deltas * 100))

conclusao <- ifelse(
  imp > 0,
  paste0("Valor recuperável abaixo do contábil: perda simulada de R$ ", fmt(imp, 0), " mil"),
  paste0("Valor recuperável excede o contábil em ", fmt(margem, 1), "%")
)

df_sens <- data.frame(
  cenario = cenario,
  wacc_aplicado = sprintf("%.2f%%", wacc * 100),
  taxa_g = sprintf("%.2f%%", taxa_g * 100),
  fluxo_caixa_hipotetico_mil = fcf_base,
  valor_recuperavel_mil = round(vr, 2),
  valor_contabil_mil = valor_contabil,
  impairment_necessario_mil = round(imp, 2),
  margem_pct = round(margem, 1),
  variacao_vs_base_mil = round(vr - vr[deltas == 0], 2),
  conclusao = conclusao,
  natureza = "Simulação didática - premissas hipotéticas, não é a estimativa da administração",
  stringsAsFactors = FALSE
)
write.csv(df_sens, "05_resultados/analise_sensibilidade_impairment.csv",
          row.names = FALSE, fileEncoding = "UTF-8")

# Pontos de ruptura (calculados, não digitados)
wacc_ruptura <- fcf_base / valor_contabil + taxa_g
fcf_ruptura  <- valor_contabil * (wacc_base - taxa_g)
df_rup <- data.frame(
  indicador = c("WACC de ruptura (fluxo hipotético mantido)",
                "Aumento do WACC sobre o base até a ruptura (p.p.)",
                "Fluxo de caixa de ruptura (WACC base mantido, R$ mil)",
                "Queda do fluxo até a ruptura (%)"),
  valor = c(round(wacc_ruptura * 100, 2),
            round((wacc_ruptura - wacc_base) * 100, 2),
            round(fcf_ruptura, 2),
            round((1 - fcf_ruptura / fcf_base) * 100, 1)),
  stringsAsFactors = FALSE
)
write.csv(df_rup, "05_resultados/analise_sensibilidade_ponto_ruptura.csv",
          row.names = FALSE, fileEncoding = "UTF-8")

# Grade bidimensional: fluxo de caixa x WACC
grade <- expand.grid(fator_fluxo = c(1.0, 0.9, 0.8, 0.7, 0.6),
                     wacc = wacc_base + deltas)
grade$fluxo_caixa_mil <- fcf_base * grade$fator_fluxo
grade$valor_recuperavel_mil <- round(grade$fluxo_caixa_mil / (grade$wacc - taxa_g), 2)
grade$impairment_mil <- round(pmax(0, valor_contabil - grade$valor_recuperavel_mil), 2)
write.csv(grade, "05_resultados/analise_sensibilidade_grade.csv",
          row.names = FALSE, fileEncoding = "UTF-8")

# =====================================================================
# 3. AMOSTRAGEM POR UNIDADE MONETÁRIA (PT 530) SOBRE A BASE SINTÉTICA
# =====================================================================
arq_base <- "03_base_sintetica/base_sintetica_intangivel.csv"
colunas  <- c("id_registro", "tipo_intangivel", "valor_contabil_mil",
              "amortizacao_acumulada_mil", "amortizacao_esperada_mil",
              "erro_inserido", "tipo_erro")

if (requireNamespace("data.table", quietly = TRUE)) {
  base <- as.data.frame(data.table::fread(arq_base, select = colunas))
} else {
  base <- read.csv(arq_base, stringsAsFactors = FALSE)[, colunas]
}
base$erro_inserido <- as.logical(base$erro_inserido)

N <- nrow(base)
V <- sum(base$valor_contabil_mil)
stopifnot(abs(V - valor_contabil) < 1)        # a base precisa somar o saldo público

J <- me / fator_conf                           # intervalo de amostragem
n <- ceiling(V / J)                            # número de seleções (unidades monetárias)

# Itens de valor elevado (>= J) seriam testados a 100%
n_valor_elevado <- sum(base$valor_contabil_mil >= J)
n_valor_zero    <- sum(base$valor_contabil_mil <= 0)   # não podem ser selecionados em MUS

# Seleção sistemática com início aleatório (circular)
set.seed(semente)
inicio <- runif(1, 0, J)
pontos <- inicio + (0:(n - 1)) * J
pontos[pontos > V] <- pontos[pontos > V] - V
acum   <- cumsum(base$valor_contabil_mil)
idx    <- findInterval(pontos, acum, left.open = TRUE) + 1

val_erros <- sum(base$valor_contabil_mil[base$erro_inserido %in% TRUE])
selecoes  <- base[idx, ]                       # uma linha por seleção
n_unicos  <- length(unique(idx))

# Distorção monetária mensurável: só "Amortização inconsistente"
# (esperada - acumulada); vida útil e indicador de impairment não têm efeito
# monetário direto mensurável na base.
eh_erro  <- selecoes$erro_inserido %in% TRUE
eh_amort <- eh_erro & (selecoes$tipo_erro %in% "Amortizacao inconsistente")
selecoes$distorcao_mil <- ifelse(
  eh_amort, selecoes$amortizacao_esperada_mil - selecoes$amortizacao_acumulada_mil, 0)
selecoes$tainting <- pmin(1, pmax(0, selecoes$distorcao_mil / selecoes$valor_contabil_mil))

amostra <- data.frame(
  ordem_selecao = seq_len(nrow(selecoes)),
  id_registro = selecoes$id_registro,
  tipo_intangivel = selecoes$tipo_intangivel,
  valor_contabil_mil = selecoes$valor_contabil_mil,
  erro_inserido = selecoes$erro_inserido,
  tipo_erro = selecoes$tipo_erro,
  distorcao_mil = round(selecoes$distorcao_mil, 6),
  tainting = round(selecoes$tainting, 6),
  stringsAsFactors = FALSE
)
write.csv(amostra, "05_resultados/mus_amostra_selecionada.csv",
          row.names = FALSE, fileEncoding = "UTF-8")

# Avaliação: projeção pontual e limite superior (Stringer, 95%)
n_erros_amostra <- sum(eh_erro)
proj <- J * sum(selecoes$tainting)
tn   <- sort(selecoes$tainting[selecoes$tainting > 0], decreasing = TRUE)
cb   <- function(k) qchisq(0.95, 2 * (k + 1)) / 2     # fator de Poisson a 95% para k erros
lim_sup <- J * (cb(0) + if (length(tn) > 0)
  sum(tn * (cb(seq_along(tn)) - cb(seq_along(tn) - 1))) else 0)

aceita <- lim_sup < me
conclusao_mus <- if (aceita) {
  paste0("Limite superior de distorção (R$ ", fmt(lim_sup), " mil) abaixo da materialidade de execução (R$ ",
         fmt(me), " mil): a amostra não indica distorção relevante NO SALDO SIMULADO")
} else {
  paste0("Limite superior de distorção (R$ ", fmt(lim_sup), " mil) excede a materialidade de execução (R$ ",
         fmt(me), " mil): ampliar a amostra e investigar")
}

df_mus <- data.frame(
  parametro_amostral = c(
    "População (N)", "Valor monetário da população (V)", "Nível de confiança",
    "Fator de confiança de planejamento (CB)", "Materialidade de execução (ME)",
    "Intervalo de amostragem (J)", "Número de seleções (n = V / J, arredondado para cima)",
    "Semente do sorteio", "Início aleatório", "Registros distintos selecionados",
    "Itens com valor >= J (testados a 100%)", "Registros de valor zero (não selecionáveis)",
    "Erros encontrados na amostra", "Distorção observada na amostra",
    "Projeção pontual de distorção", "Limite superior de distorção (Stringer, 95%)",
    "Conclusão da amostragem"),
  valor = c(N, sprintf("%.2f", V), "95", sprintf("%.2f", fator_conf), sprintf("%.2f", me),
            sprintf("%.2f", J), n, semente, sprintf("%.4f", inicio), n_unicos,
            n_valor_elevado, n_valor_zero, n_erros_amostra,
            sprintf("%.6f", sum(selecoes$distorcao_mil)), sprintf("%.6f", proj),
            sprintf("%.2f", lim_sup), conclusao_mus),
  unidade = c("registros", "R$ mil", "%", "fator de Poisson", "R$ mil", "R$ mil",
              "seleções", "", "R$ mil", "registros", "registros", "registros",
              "registros", "R$ mil", "R$ mil", "R$ mil", ""),
  observacao_tecnica = c(
    "Base sintética completa",
    "Igual ao saldo público do intangível",
    "Risco de aceitação incorreta de 5%",
    "Zero erros esperados",
    "75% da materialidade global (1% do ativo total)",
    "ME / CB",
    "Cada seleção é uma unidade monetária da população",
    "Fixa o sorteio; reexecutar reproduz a mesma amostra",
    "Sorteado entre 0 e J",
    "Um registro pode ser selecionado mais de uma vez",
    paste0("Maior valor individual da base: R$ ", fmt(max(base$valor_contabil_mil), 4), " mil"),
    "Registros de valor zero têm probabilidade nula em MUS",
    "Erros inseridos presentes entre os itens selecionados",
    "Só 'Amortizacao inconsistente' tem efeito monetário mensurável (esperada - acumulada)",
    "J x soma das proporções de distorção",
    "Calculado com o limite de Stringer; sem erros equivale a cerca de 3 x J",
    "Válida apenas para a base sintética"),
  stringsAsFactors = FALSE
)
write.csv(df_mus, "05_resultados/amostragem_mus_projecao.csv",
          row.names = FALSE, fileEncoding = "UTF-8")

# =====================================================================
# 4. PAPÉIS DE TRABALHO PT02 (540) E PT_530 NO ESQUEMA ÚNICO
# =====================================================================
LIM <- "Trabalho acadêmico baseado em informações públicas e base sintética; não equivale a auditoria independente"
monta_pt <- function(prefixo, norma, linhas) {
  do.call(rbind, lapply(seq_along(linhas), function(i) {
    l <- linhas[[i]]
    data.frame(Codigo = sprintf("%s-%02d", prefixo, i), Norma = norma,
               Procedimento = l[1], Natureza = l[2], Evidencia = l[3],
               Resultado = l[4], Limitacao = LIM, stringsAsFactors = FALSE)
  }))
}

i_base <- which(deltas == 0)
i_max  <- which.max(deltas)
pt02 <- monta_pt("PT02", "NBC TA 540", list(
  c("Definir o objetivo da análise da estimativa de recuperabilidade do intangível",
    "Planejamento", "Escopo acadêmico do trabalho",
    "Avaliar como a conclusão sobre a recuperabilidade reagiria a variações das premissas"),
  c("Identificar a estimativa relevante nas divulgações públicas",
    "Análise documental", "DFP 2025, nota de intangível e impairment",
    "Recuperabilidade é uma estimativa com julgamento; modelo, fluxos e premissas da administração não foram obtidos"),
  c("Construir um DCF didático ilustrativo com premissas hipotéticas",
    "Simulação (premissas hipotéticas)", "05_resultados/analise_sensibilidade_impairment.csv",
    paste0("Fluxo hipotético R$ ", fmt(fcf_base, 0), " mil, WACC ", fmt(wacc_base * 100, 1),
           "%, g ", fmt(taxa_g * 100, 1), "%: valor recuperável de R$ ", fmt(vr[i_base], 0),
           " mil contra saldo de R$ ", fmt(valor_contabil, 0), " mil (margem de ",
           fmt(margem[i_base], 1), "%); as premissas não vêm da companhia")),
  c("Executar a sensibilidade à taxa de desconto e ao fluxo de caixa",
    "Simulação (premissas hipotéticas)",
    "05_resultados/analise_sensibilidade_impairment.csv; analise_sensibilidade_ponto_ruptura.csv; analise_sensibilidade_grade.csv",
    paste0("Perda simulada só surge com WACC de ", fmt(wacc_ruptura * 100, 2), "% (+",
           fmt((wacc_ruptura - wacc_base) * 100, 2), " p.p.) ou queda de ",
           fmt((1 - fcf_ruptura / fcf_base) * 100, 1), "% no fluxo; em WACC +5,0 p.p. a perda simulada é de R$ ",
           fmt(imp[i_max], 0), " mil")),
  c("Avaliar método, dados, premissas e viés da estimativa real da administração",
    "Planejado - não executado", "Sem acesso ao modelo, fluxos ou premissas da companhia",
    "Não foi testada a estimativa da administração; a sensibilidade acima não substitui esse teste"),
  c("Registrar conclusão preliminar e limitações",
    "Conclusão documental", "Itens anteriores deste PT",
    "Sensibilidade executada somente sobre modelo ilustrativo; não se conclui sobre a razoabilidade da estimativa da administração")
))
write.csv(pt02, "02_papeis_trabalho/PT02_nota16_impairment.csv",
          row.names = FALSE, fileEncoding = "UTF-8")

pt530 <- monta_pt("PT530", "NBC TA 530", list(
  c("Definir população, unidade de amostragem e método",
    "Simulação (base sintética)", "03_base_sintetica/base_sintetica_intangivel.csv",
    paste0("População: ", fmt(N, 0), " registros sintéticos, R$ ", fmt(V, 0),
           " mil; unidade: real monetário; método: MUS com seleção sistemática e início aleatório")),
  c("Calcular os parâmetros da amostragem",
    "Simulação (base sintética)", "05_resultados/amostragem_mus_projecao.csv",
    paste0("Confiança de 95% (fator ", fmt(fator_conf, 1), "), ME R$ ", fmt(me),
           " mil, intervalo R$ ", fmt(J), " mil, ", n, " seleções")),
  c("Tratar os itens de valor elevado",
    "Simulação (base sintética)", "05_resultados/amostragem_mus_projecao.csv",
    paste0(n_valor_elevado, " registro(s) com valor igual ou superior ao intervalo; ",
           fmt(n_valor_zero, 0), " registros de valor zero não são selecionáveis em MUS")),
  c("Selecionar os itens da amostra",
    "Simulação (base sintética)", "05_resultados/mus_amostra_selecionada.csv",
    paste0(n, " seleções sobre ", n_unicos, " registros distintos; semente ", semente,
           " e início aleatório ", fmt(inicio, 4), "; a lista está no arquivo e é reproduzível")),
  c("Avaliar o resultado da amostra e projetar as distorções",
    "Simulação (base sintética)", "05_resultados/mus_amostra_selecionada.csv; amostragem_mus_projecao.csv",
    paste0(n_erros_amostra, " erro(s) inserido(s) entre os itens selecionados; distorção observada R$ ",
           fmt(sum(selecoes$distorcao_mil), 4), " mil; projeção R$ ", fmt(proj, 4),
           " mil; limite superior (Stringer, 95%) R$ ", fmt(lim_sup), " mil contra ME de R$ ", fmt(me), " mil")),
  c("Registrar conclusão preliminar e limitações",
    "Conclusão documental", "Itens anteriores deste PT",
    paste0(conclusao_mus, ". Os ", sum(base$erro_inserido %in% TRUE), " erros inseridos somam R$ ",
           fmt(val_erros), " mil de valor contábil, ",
           "de modo que uma amostra de ", n, " seleções tem baixa chance de encontrá-los; ",
           "a ausência de erros na amostra não prova ausência de erros na base"))
))
write.csv(pt530, "02_papeis_trabalho/PT_530.csv", row.names = FALSE, fileEncoding = "UTF-8")

cat("Sensibilidade (DCF didático) e MUS atualizadas.\n")
cat("WACC de ruptura:", round(wacc_ruptura * 100, 2), "%\n")
cat("Seleções:", n, "| registros distintos:", n_unicos, "| erros na amostra:", n_erros_amostra, "\n")
cat("Limite superior (Stringer):", round(lim_sup, 2), "| ME:", round(me, 2), "\n")
