
# Projeto: Auditoria 1 - Frasle Mobility S.A.
# Estrutura da base sintetica de intangivel
# Todos os registros futuros serao simulados.

campos_base <- data.frame(
  campo = c(
    "id_registro",
    "tipo_intangivel",
    "unidade_geradora_caixa",
    "data_reconhecimento",
    "valor_original_mil",
    "vida_util_anos",
    "amortizacao_acumulada_mil",
    "valor_contabil_mil",
    "indicador_impairment",
    "erro_inserido",
    "tipo_erro",
    "origem_dado"
  ),
  finalidade = c(
    "Identificador unico do registro simulado",
    "Categoria do ativo intangivel",
    "Unidade hipotetica associada ao ativo",
    "Data simulada de reconhecimento",
    "Valor original hipotetico em R$ mil",
    "Vida util hipotetica em anos",
    "Amortizacao acumulada hipotetica em R$ mil",
    "Valor contabil liquido hipotetico em R$ mil",
    "Indicador simulado para direcionar teste de recuperabilidade",
    "Indica se foi inserido erro intencionalmente",
    "Classificacao do erro intencional, quando houver",
    "Identifica explicitamente a natureza sintetica"
  ),
  stringsAsFactors = FALSE
)

dir.create("03_base_sintetica", showWarnings = FALSE)

write.csv(
  campos_base,
  "03_base_sintetica/dicionario_base_intangivel.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

print(campos_base)
print(file.exists(
  "03_base_sintetica/dicionario_base_intangivel.csv"
))

