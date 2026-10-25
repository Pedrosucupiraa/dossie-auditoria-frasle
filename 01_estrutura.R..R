
# P2 - Auditoria 1
# Companhia: Frasle Mobility S.A.
# Matricula: 241003375
# Exercicio: 2025
# Linguagem: R

# Criar as pastas do projeto
pastas <- c(
  "01_fontes",
  "02_papeis_trabalho",
  "03_base_sintetica",
  "04_codigo",
  "05_resultados",
  "06_matrizes"
)

for (pasta in pastas) {
  if (!dir.exists(pasta)) {
    dir.create(pasta)
  }
}

# Conferir as pastas criadas
list.files()

# Registrar a identificacao do trabalho
projeto <- data.frame(
  companhia = "Frasle Mobility S.A.",
  matricula = "241003375",
  exercicio = 2025,
  linguagem = "R"
)

print(projeto)

# Criar a pasta de fontes, caso ainda não exista
if (!dir.exists("01_fontes")) {
  dir.create("01_fontes", recursive = TRUE)
}

# Registrar as fontes que serão utilizadas
fontes <- data.frame(
  codigo = c("F01", "F02", "F03"),
  documento = c(
    "Demonstracoes financeiras de 2025",
    "Relacoes com investidores",
    "Dados abertos da CVM"
  ),
  instituicao = c(
    "CVM",
    "Frasle Mobility",
    "CVM"
  ),
  link = c(
    "https://www.rad.cvm.gov.br/ENET/frmGerenciaPaginaFRE.aspx?CodigoTipoInstituicao=1&NumeroSequencialDocumento=155265",
    "https://ri.fraslemobility.com/",
    "https://dados.cvm.gov.br/dataset/cia_aberta-doc-dfp"
  ),
  data_acesso = rep(
    format(Sys.Date(), "%d/%m/%Y"),
    3
  ),
  stringsAsFactors = FALSE
)

# Salvar o arquivo CSV
write.csv(
  fontes,
  "01_fontes/registro_fontes.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# Conferir se foi criado
file.exists("01_fontes/registro_fontes.csv")



ativo_total <- 7222660

contas_ativo <- data.frame(
  conta = c(
    "Intangivel",
    "Imobilizado",
    "Estoques",
    "Caixa e equivalentes de caixa"
  ),
  saldo_2025 = c(
    1874550,
    1450996,
    1443447,
    1316248
  )
)

# Calcular percentual sobre o ativo total
contas_ativo$percentual_ativo <- (
  contas_ativo$saldo_2025 / ativo_total
) * 100

# Ordenar da maior para a menor conta
contas_ativo <- contas_ativo[
  order(-contas_ativo$saldo_2025),
]

# Exibir valores com duas casas decimais
contas_ativo$percentual_ativo <- round(
  contas_ativo$percentual_ativo, 2
)

print(contas_ativo)

# Garantir q a pasta existe antes de salvar
dir.create("05_resultados", showWarnings = FALSE)

# Salvar a tabela no projeto
write.csv(
  contas_ativo,
  "05_resultados/analise_materialidade.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# Conferir se o arquivo foi criado

file.exists("05_resultados/analise_materialidade.csv")

# Criar as pastas restantes do projeto

pastas <- c(
  "02_papeis_trabalho",
  "03_base_sintetica",
  "04_codigo",
  "05_resultados",
  "06_matrizes"
)

for (pasta in pastas) {
  if (!dir.exists(pasta)) {
    dir.create(pasta)
  }
}

# ==================================================
# PT02 - NOTA EXPLICATIVA 16: IMPAIRMENT
# Companhia: Frasle Mobility S.A.
# Exercicio: 2025
# Matricula: 241003375
# ==================================================

# Garantir que a pasta de destino exista
dir.create("02_papeis_trabalho", showWarnings = FALSE)

# Registrar a analise preliminar da Nota 16
nota16 <- data.frame(
  codigo = c("PT02-01", "PT02-02", "PT02-03", "PT02-04"),
  
  assunto = c(
    "Objetivo da nota",
    "Procedimento divulgado pela companhia",
    "Riscos preliminares de auditoria",
    "Limitacoes do trabalho"
  ),
  
  descricao = c(
    "Avaliar a recuperabilidade de determinados ativos",
    paste(
      "A companhia informa que realizou testes de recuperabilidade",
      "nas unidades com indicios de perda e em ativos especificados",
      "na Nota Explicativa 16"
    ),
    paste(
      "Risco de estimativas inadequadas nos fluxos de caixa,",
      "nas taxas de desconto e nas expectativas de crescimento"
    ),
    paste(
      "Analise documental baseada em informacoes publicas;",
      "os calculos internos e as premissas detalhadas nao foram",
      "auditados diretamente neste trabalho academico"
    )
  ),
  
  classificacao = c(
    "Informacao divulgada",
    "Informacao divulgada",
    "Risco preliminar a investigar",
    "Limitacao"
  ),
  
  fonte = c(
    "Nota Explicativa 16",
    "Nota Explicativa 16",
    "Analise preliminar da Nota Explicativa 16",
    "Limitacao do trabalho academico"
  ),
  
  stringsAsFactors = FALSE
)

# Salvar na pasta de papeis de trabalho
write.csv(
  nota16,
  "02_papeis_trabalho/PT02_nota16_impairment.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# Conferir se o arquivo foi criado
file.exists(
  "02_papeis_trabalho/PT02_nota16_impairment.csv"
)

# Visualizar o registro
print(nota16)

# ==================================================
# PT03 - NOTA EXPLICATIVA 18: INTANGIVEL
# Companhia: Frasle Mobility S.A.
# Exercicio: 2025
# Matricula: 241003375
# ==================================================

dir.create("02_papeis_trabalho", showWarnings = FALSE)

nota18 <- data.frame(
  codigo = c(
    "PT03-01",
    "PT03-02",
    "PT03-03",
    "PT03-04",
    "PT03-05"
  ),
  
  assunto = c(
    "Softwares",
    "Amortizacao",
    "Marcas e carteira de clientes",
    "Agio e impairment",
    "Movimentacao dos saldos"
  ),
  
  informacao_divulgada = c(
    "Softwares elegiveis sao capitalizados e amortizados durante a vida util estimada, limitada a seis anos",
    "A amortizacao considera a vida util estimada e o consumo dos beneficios economicos",
    "A nota apresenta marcas registradas e carteira de clientes entre os ativos intangiveis",
    "O agio nao e amortizado e esta sujeito a testes de recuperabilidade",
    "A tabela apresenta saldos iniciais, aquisicoes, transferencias, amortizacao e saldos finais"
  ),
  
  risco_preliminar = c(
    "Capitalizacao indevida ou vida util inadequada",
    "Erro na estimativa da amortizacao",
    "Mensuracao ou classificacao inadequada",
    "Valor contabil superior ao valor recuperavel",
    "Movimentacoes incompletas ou classificadas incorretamente"
  ),
  
  fonte = c(
    "Nota Explicativa 18, pagina 95",
    "Nota Explicativa 18, pagina 95",
    "Nota Explicativa 18, paginas 95 e 96",
    "Notas Explicativas 16 e 18, pagina 95",
    "Nota Explicativa 18, pagina 96"
  ),
  
  natureza = c(
    "Informacao divulgada",
    "Informacao divulgada",
    "Informacao divulgada",
    "Informacao divulgada e risco preliminar",
    "Informacao divulgada"
  ),
  
  stringsAsFactors = FALSE
)

write.csv(
  nota18,
  "02_papeis_trabalho/PT03_nota18_intangivel.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

print(nota18)

file.exists(
  "02_papeis_trabalho/PT03_nota18_intangivel.csv"
)

# Comparacao do intangivel consolidado - 2024 e 2025

comparacao_intangivel <- data.frame(
  conta = "Intangivel consolidado",
  saldo_2024 = 586859,
  saldo_2025 = 1874550
)

comparacao_intangivel$variacao_absoluta <-
  comparacao_intangivel$saldo_2025 -
  comparacao_intangivel$saldo_2024

comparacao_intangivel$variacao_percentual <-
  round(
    (comparacao_intangivel$variacao_absoluta /
       comparacao_intangivel$saldo_2024) * 100,
    2
  )

print(comparacao_intangivel)

write.csv(
  comparacao_intangivel,
  "05_resultados/comparacao_intangivel_2024_2025.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

file.exists(
  "05_resultados/comparacao_intangivel_2024_2025.csv"
)

# PT04 - Movimentacao do intangivel consolidado

dir.create("02_papeis_trabalho", showWarnings = FALSE)

movimentacao_intangivel <- data.frame(
  item = c(
    "Saldo inicial de 2025",
    "Adicoes por combinacao de negocio",
    "Mais-valia na combinacao de negocio",
    "Agio na combinacao de negocio",
    "Despesa de amortizacao do exercicio",
    "Saldo final de 2025"
  ),
  
  valor_R_mil = c(
    586859,
    203682,
    543063,
    594496,
    -90209,
    1874550
  ),
  
  natureza = c(
    "Saldo divulgado em 31/12/2024",
    "Movimentacao divulgada na Nota 18",
    "Movimentacao divulgada na Nota 18",
    "Movimentacao divulgada na Nota 18",
    "Amortizacao divulgada na Nota 18",
    "Saldo divulgado em 31/12/2025"
  ),
  
  risco_preliminar = c(
    "Conferencia do saldo de abertura",
    "Existencia, mensuracao e classificacao",
    "Mensuracao das mais-valias reconhecidas",
    "Reconhecimento e recuperabilidade do agio",
    "Calculo e periodo de amortizacao",
    "Conferencia do saldo final"
  ),
  
  stringsAsFactors = FALSE
)

write.csv(
  movimentacao_intangivel,
  "02_papeis_trabalho/PT04_movimentacao_intangivel.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

print(movimentacao_intangivel)

file.exists(
  "02_papeis_trabalho/PT04_movimentacao_intangivel.csv"
)

# ==================================================
# RECONCILIACAO DO INTANGIVEL CONSOLIDADO
# Nota Explicativa 18 - Exercicio 2025
# Valores em R$ mil
# ==================================================

dir.create("05_resultados", showWarnings = FALSE)

# Movimentacoes do custo bruto do intangivel
mov_custo <- data.frame(
  movimentacao = c(
    "Saldo inicial do custo em 2024",
    "Adicao por combinacao de negocio",
    "Aquisicoes",
    "Baixas",
    "Transferencias",
    "Variacao cambial",
    "Efeito de hiperinflacao",
    "Mais-valia na combinacao de negocio",
    "Agio na combinacao de negocio",
    "Saldo final do custo em 2025"
  ),
  valor_R_mil = c(
    817821, 203682, 13034, -5169, 0,
    11591, 25568, 543063, 594496, 2204086
  )
)

# Movimentacoes da amortizacao e perda por recuperabilidade
mov_amortizacao <- data.frame(
  movimentacao = c(
    "Saldo inicial da amortizacao em 2024",
    "Adicao por combinacao de negocio",
    "Despesa de amortizacao do exercicio",
    "Baixas",
    "Transferencias",
    "Variacao cambial",
    "Efeito de hiperinflacao",
    "Perdas por reducao ao valor recuperavel",
    "Saldo final da amortizacao em 2025"
  ),
  valor_R_mil = c(
    -230962, -5641, -90209, 110, 0,
    5236, -8461, 391, -329536
  )
)

# Calcular os saldos liquidos
saldo_liquido_2024 <- 817821 - 230962
saldo_liquido_2025 <- 2204086 - 329536

variacao_liquida <- saldo_liquido_2025 - saldo_liquido_2024

# Verificar a soma das movimentacoes
variacao_custo <- sum(mov_custo$valor_R_mil[-1]) -
  mov_custo$valor_R_mil[10]

variacao_amortizacao <- sum(mov_amortizacao$valor_R_mil[-1]) -
  mov_amortizacao$valor_R_mil[9]

# Tabela-resumo da reconciliacao
reconciliacao <- data.frame(
  indicador = c(
    "Saldo liquido em 2024",
    "Saldo liquido em 2025",
    "Variacao liquida",
    "Variacao do custo bruto",
    "Variacao da amortizacao e perdas"
  ),
  valor_R_mil = c(
    saldo_liquido_2024,
    saldo_liquido_2025,
    variacao_liquida,
    2204086 - 817821,
    -329536 - (-230962)
  )
)

print(mov_custo)
print(mov_amortizacao)
print(reconciliacao)

# Salvar a reconciliacao
write.csv(
  reconciliacao,
  "05_resultados/reconciliacao_intangivel.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# Conferir o arquivo e a igualdade dos saldos
file.exists("05_resultados/reconciliacao_intangivel.csv")

saldo_liquido_2024 == 586859
saldo_liquido_2025 == 1874550
variacao_liquida == 1287691

# PT05 - Conclusao da reconciliacao do intangivel

conclusao_reconciliacao <- data.frame(
  item = c(
    "Objetivo",
    "Resultado aritmetico",
    "Interpretacao",
    "Limitacao",
    "Proximo procedimento"
  ),
  descricao = c(
    "Comparar os saldos liquidos do intangivel consolidado de 2024 e 2025",
    "Os saldos usados no calculo resultam em variacao positiva de R$ 1.287.691 mil",
    "O aumento deve ser analisado considerando aquisicoes, combinacoes de negocios e amortizacao",
    "A igualdade aritmetica nao comprova a exatidao de todas as movimentacoes transcritas nem a validade dos registros",
    "Conferir cada movimentacao com a tabela completa e planejar testes sobre aquisicoes, agio e amortizacao"
  ),
  stringsAsFactors = FALSE
)

write.csv(
  conclusao_reconciliacao,
  "02_papeis_trabalho/PT05_conclusao_reconciliacao.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

print(conclusao_reconciliacao)

file.exists(
  "02_papeis_trabalho/PT05_conclusao_reconciliacao.csv"
)


# ETAPA 6 - Conferir as contas do ativo selecionadas

cat("Total do ativo consolidado em 2025: R$ 7.222.660 mil\n\n")

print(read.csv(
  "05_resultados/analise_materialidade.csv",
  fileEncoding = "UTF-8"
))

cat("\nArquivo encontrado? ")
print(file.exists("05_resultados/analise_materialidade.csv"))


# ETAPA 7 - Analise preliminar das contas do ativo

ativo_total <- 7222660

contas_ativo <- data.frame(
  codigo = c(
    "1.01.01", "1.01.02", "1.01.03",
    "1.01.04", "1.01.06", "1.01.08",
    "1.02.01", "1.02.02", "1.02.03",
    "1.02.04"
  ),
  conta = c(
    "Caixa e equivalentes de caixa",
    "Aplicacoes financeiras - circulante",
    "Contas a receber - circulante",
    "Estoques",
    "Tributos a recuperar - circulante",
    "Outros ativos circulantes",
    "Ativo realizavel a longo prazo",
    "Investimentos",
    "Imobilizado",
    "Intangivel"
  ),
  saldo_2025 = c(
    1316248, 13869, 546566, 1443447, 98308,
    89, 411446, 67141, 1450996, 1874550
  )
)

contas_ativo$percentual_ativo <- round(
  contas_ativo$saldo_2025 / ativo_total * 100, 2
)

contas_ativo <- contas_ativo[
  order(-contas_ativo$saldo_2025),
]

write.csv(
  contas_ativo,
  "05_resultados/analise_materialidade.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

print(contas_ativo)
print(file.exists("05_resultados/analise_materialidade.csv"))

