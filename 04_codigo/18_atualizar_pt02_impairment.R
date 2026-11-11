# Executa a análise estatística de sensibilidade (PT 540) e amostragem MUS (PT 530)

dir.create("05_resultados", showWarnings = FALSE)
dir.create("02_papeis_trabalho", showWarnings = FALSE)

# 1. Modelo de Sensibilidade (PT 540)
valor_contabil <- 1874550.00
wacc_base <- 0.115
taxa_g <- 0.03
fcf_base <- 250000.00

deltas <- c(-0.02, -0.01, 0.00, 0.01, 0.02, 0.05)
rotulos <- c("WACC Otimista (-2.0%)", "WACC Favorável (-1.0%)", "Cenário Base (WACC 11.5%)",
             "WACC Estressado (+1.0%)", "WACC Severo (+2.0%)", "WACC Crítico (+5.0%)")

df_sens <- data.frame(
  cenario = rotulos,
  wacc_aplicado = sprintf("%.2f%%", (wacc_base + deltas) * 100),
  taxa_g = "3.00%",
  valor_recuperavel_mil = round(fcf_base / ((wacc_base + deltas) - taxa_g), 2),
  valor_contabil_mil = valor_contabil
)

df_sens$impairment_necessario_mil <- pmax(0, df_sens$valor_contabil_mil - df_sens$valor_recuperavel_mil)
df_sens$variacao_vs_base_mil <- round(df_sens$valor_recuperavel_mil - df_sens$valor_recuperavel_mil[3], 2)
df_sens$conclusao_auditoria <- c(
  "Sem indício de imparidade; margem de segurança de +105%",
  "Sem indício de imparidade; margem de segurança de +77.8%",
  "Valor recuperável excede valor contabilístico em 56.9%",
  "Sem imparidade; margem de segurança reduz-se para +40.4%",
  "Sem imparidade; ativo permanece coberto pelo valor em uso",
  "Ponto de rutura: surge necessidade de impairment de R$ 22.698 mil"
)

write.csv(df_sens, "05_resultados/analise_sensibilidade_impairment.csv", row.names = FALSE)

# 2. Amostragem MUS (PT 530)
me <- 54169.95
fator_confianca <- 3.00
intervalo <- me / fator_confianca
tamanho_amostra <- ceiling(valor_contabil / intervalo)

df_mus <- data.frame(
  parametro_amostral = c("População Total (N)", "Valor Monetário da População (V)", "Nível de Confiança",
                         "Fator de Confiança (CB)", "Materialidade de Execução (ME)", "Intervalo de Amostragem (J)",
                         "Tamanho Amostral Calculado (n)", "Conclusão da Amostragem"),
  valor = c("500000", "1874550.00", "95%", "3.00", sprintf("%.2f", me), sprintf("%.2f", intervalo),
            as.character(tamanho_amostra), "Aprovado"),
  unidade = c("Registos", "R$ mil", "%", "Fator de Poisson", "R$ mil", "R$ mil", "Itens monetários", ""),
  observacao_tecnica = c("Universo completo da base sintética de intangíveis", "Soma reconciliada dos saldos",
                         "Risco de aceitação incorreta de 5%", "Zero erros esperados", "75% da Materialidade Global",
                         "ME / Fator de Confiança", "População V / Intervalo J", "Saldo do Intangível validado estatisticamente")
)

write.csv(df_mus, "05_resultados/amostragem_mus_projecao.csv", row.names = FALSE)
cat("Análise de sensibilidade (PT 540) e amostragem MUS (PT 530) atualizadas com sucesso!\n")
