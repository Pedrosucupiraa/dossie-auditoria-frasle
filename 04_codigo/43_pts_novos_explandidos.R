# 04_codigo/43_pts_novos_expandidos.R
# Gera os PTs das normas que não tinham papel de trabalho próprio:
# 230, 300, 315, 330, 450, 500 e 530.
# Esquema único (igual ao de PT07 a PT12):
#   Codigo, Norma, Procedimento, Natureza, Evidencia, Resultado, Limitacao
# Natureza usa sempre uma destas categorias:
#   Planejamento | Evidência pública | Simulação (base sintética) |
#   Análise documental | Planejado - não executado | Conclusão documental
# Todos os números abaixo vêm dos arquivos em 05_resultados/ e 03_base_sintetica/.

dir.create("02_papeis_trabalho", showWarnings = FALSE)

LIM <- "Trabalho acadêmico baseado em informações públicas e base sintética; não equivale a auditoria independente"

# Cada linha: c(Procedimento, Natureza, Evidencia, Resultado)
monta_pt <- function(prefixo, norma, linhas) {
  df <- do.call(rbind, lapply(seq_along(linhas), function(i) {
    l <- linhas[[i]]
    data.frame(
      Codigo = sprintf("%s-%02d", prefixo, i),
      Norma = norma,
      Procedimento = l[1],
      Natureza = l[2],
      Evidencia = l[3],
      Resultado = l[4],
      Limitacao = LIM,
      stringsAsFactors = FALSE
    )
  }))
  df
}

grava <- function(df, arquivo) {
  write.csv(df, file.path("02_papeis_trabalho", arquivo),
            row.names = FALSE, fileEncoding = "UTF-8")
  cat("Gerado:", arquivo, "(", nrow(df), "linhas )\n")
}

# ---------------------------------------------------------------- PT 230
pt230 <- monta_pt("PT230", "NBC TA 230", list(
  c("Definir o objetivo da documentação e do índice dos papéis de trabalho",
    "Planejamento",
    "Escopo acadêmico do trabalho",
    "Organizar papéis, scripts e resultados com referência cruzada e controle de versão"),
  c("Indexar os papéis de trabalho existentes em 02_papeis_trabalho/",
    "Análise documental",
    "02_papeis_trabalho/; 06_matrizes/matriz_cobertura_normas.csv",
    "Existem PT02 a PT24 e PT32; PT230, PT300, PT315, PT330, PT450, PT500 e PT530 são gerados pelo script 43; versões anteriores arquivadas em 02_papeis_trabalho/versoes_anteriores/; esquema de 7 colunas em todos os PTs"),
  c("Relacionar cada resultado ao script que o produz",
    "Análise documental",
    "04_codigo/ (scripts numerados); 05_resultados/",
    "Os scripts numerados em 04_codigo/ geram os CSVs de 05_resultados/; a ordem de reexecução do README deve ser validada em ambiente limpo"),
  c("Registrar preparador, data e revisor de cada papel",
    "Análise documental",
    "PT05 e PT06: preparador matrícula 241003375; revisor 'pendente'",
    "Não houve revisão independente; nenhum papel deve ser apresentado como revisado"),
  c("Considerar guarda, versionamento e fechamento da documentação",
    "Planejado - não executado",
    "Repositório Git/GitHub",
    "Controle de versão feito pelo Git; assinatura de conclusão e prazo de guarda não se aplicam a trabalho acadêmico"),
  c("Registrar conclusão preliminar e limitações",
    "Conclusão documental",
    "Papéis de trabalho e matriz de cobertura",
    "Documentação parcial: faltam consolidar duplicatas e padronizar o esquema de colunas dos PTs; não equivale a documentação de auditoria concluída")
))
grava(pt230, "PT_230.csv")

# ---------------------------------------------------------------- PT 300
pt300 <- monta_pt("PT300", "NBC TA 300", list(
  c("Definir o objetivo do planejamento da auditoria acadêmica",
    "Planejamento",
    "Enunciado e escopo do trabalho",
    "Planejar o exame do intangível consolidado da Fras-le (exercício de 2025, comparativo de 2024)"),
  c("Documentar o escopo: conta, exercício e fontes",
    "Evidência pública",
    "03_base_sintetica/planejamento_base_intangivel.csv; 01_fontes/registro_fontes.csv",
    "Conta selecionada: intangível consolidado; saldo de 2025 R$ 1.874.550 mil e de 2024 R$ 586.859 mil"),
  c("Identificar as contas relevantes do ativo",
    "Evidência pública",
    "05_resultados/analise_materialidade.csv",
    "Ativo total de R$ 7.222.660 mil; intangível 25,95%, imobilizado 20,09%, estoques 19,98% e caixa 18,22% do ativo"),
  c("Elaborar programas de auditoria por ciclo (receita, estoques, caixa, imobilizado)",
    "Planejado - não executado",
    "Nenhum programa por ciclo elaborado além do intangível",
    "Somente o intangível tem procedimentos (PT02 a PT06 e simulação); as demais contas só foram comparadas analiticamente (PT17)"),
  c("Definir cronograma, equipe e recursos",
    "Planejado - não executado",
    "Trabalho individual acadêmico",
    "Cronograma e alocação de equipe não definidos; não há equipe nem supervisão"),
  c("Registrar conclusão preliminar e limitações",
    "Conclusão documental",
    "Itens anteriores deste PT",
    "Planejamento limitado ao intangível; programas por ciclo e cronograma permanecem pendentes")
))
grava(pt300, "PT_300.csv")

# ---------------------------------------------------------------- PT 315
pt315 <- monta_pt("PT315", "NBC TA 315", list(
  c("Definir o objetivo da identificação e avaliação de riscos",
    "Planejamento",
    "Escopo acadêmico do trabalho",
    "Identificar riscos de distorção relevante no intangível com base em informações públicas"),
  c("Obter entendimento da entidade a partir de informações públicas",
    "Evidência pública",
    "01_fontes/155265_006211_20102026101023.pdf (DFP 2025)",
    "Demonstrações consolidadas consultadas; ambiente de controle, TI e processos internos não foram compreendidos"),
  c("Identificar fatores de risco do intangível a partir dos números públicos",
    "Evidência pública",
    "05_resultados/comparacao_intangivel_2024_2025.csv; 05_resultados/reconciliacao_intangivel.csv",
    "Saldo passou de R$ 586.859 mil para R$ 1.874.550 mil (+219,42%); variação do custo bruto de R$ 1.386.265 mil; causa da variação não investigada"),
  c("Relacionar o risco às afirmações (existência, valorização, apresentação)",
    "Análise documental",
    "05_resultados/analise_materialidade.csv; 05_resultados/calculo_materialidade.csv",
    "Saldo do intangível (R$ 1.874.550 mil) supera a materialidade global (R$ 72.226,60 mil); risco considerado relevante em valorização, amortização e recuperabilidade; avaliação preliminar, sem testes de controles"),
  c("Entender controles internos relevantes e ambiente de TI",
    "Planejado - não executado",
    "Sem acesso a controles, sistemas ou pessoal da companhia",
    "Não foi avaliado o desenho nem a implementação de nenhum controle"),
  c("Registrar conclusão preliminar e limitações",
    "Conclusão documental",
    "Itens anteriores deste PT",
    "Riscos identificados apenas no nível de informações públicas; avaliação por conta e afirmação permanece incompleta")
))
grava(pt315, "PT_315.csv")

# ---------------------------------------------------------------- PT 330
pt330 <- monta_pt("PT330", "NBC TA 330", list(
  c("Definir o objetivo da resposta aos riscos avaliados",
    "Planejamento",
    "PT_315.csv",
    "Associar cada risco do intangível a um teste, com natureza, época e extensão"),
  c("Relacionar riscos a testes sobre a base sintética",
    "Simulação (base sintética)",
    "03_base_sintetica/base_sintetica_intangivel.csv; 05_resultados/resumo_deteccao_independente.csv",
    "Risco de vida útil, de indicador de impairment e de amortização foram associados a testes automáticos em R"),
  c("Executar os testes sobre a base sintética e comparar com os erros inseridos",
    "Simulação (base sintética)",
    "05_resultados/comparacao_erros_teste.csv",
    "Vida útil: 55 de 79 erros sinalizados (69,62%); indicador de impairment: 86 de 86 (100%); amortização: 57 de 85 (67,06%)"),
  c("Definir natureza, época e extensão",
    "Análise documental",
    "04_codigo/11_detectar_excecoes.R; PT_530.csv",
    "Natureza: recálculo e triagem automática; extensão: 100% dos 500.000 registros sintéticos e amostra MUS; época: sem trabalho de campo"),
  c("Planejar testes de controles e substantivos para as demais contas",
    "Planejado - não executado",
    "Sem acesso a registros e controles internos",
    "Nenhuma resposta a riscos foi executada fora da base sintética"),
  c("Registrar conclusão preliminar e limitações",
    "Conclusão documental",
    "Itens anteriores deste PT",
    "Respostas executadas apenas em simulação; os resultados não se aplicam à companhia real")
))
grava(pt330, "PT_330.csv")

# ---------------------------------------------------------------- PT 450
pt450 <- monta_pt("PT450", "NBC TA 450", list(
  c("Definir o objetivo da avaliação das distorções identificadas",
    "Planejamento",
    "Escopo acadêmico do trabalho",
    "Acumular as distorções da simulação e avaliar o efeito sobre a conclusão"),
  c("Acumular as distorções inseridas na base sintética",
    "Simulação (base sintética)",
    "05_resultados/resumo_erros_inseridos.csv",
    "250 erros inseridos: 85 de amortização, 86 de indicador de impairment e 79 de vida útil"),
  c("Comparar as distorções inseridas com as sinalizadas pelos testes",
    "Simulação (base sintética)",
    "05_resultados/comparacao_erros_teste.csv",
    "198 de 250 sinalizados; 52 não detectados (24 de vida útil e 28 de amortização)"),
  c("Quantificar o efeito monetário das distorções simuladas e compará-lo ao limite de distorções irrelevantes",
    "Simulação (base sintética)",
    "03_base_sintetica/base_sintetica_intangivel.csv; 05_resultados/calculo_materialidade.csv (limite de R$ 3.611,33 mil)",
    "Amortização inconsistente: diferença de R$ 158,40 mil entre amortização esperada e acumulada nos 85 registros; vida útil e indicador de impairment não têm efeito monetário direto mensurável na base; o valor contábil total dos 250 registros é R$ 1.056,35 mil, abaixo do limite de R$ 3.611,33 mil"),
  c("Investigar as exceções não resolvidas",
    "Simulação (base sintética)",
    "05_resultados/comparacao_erros_teste.csv; 05_resultados/resumo_deteccao_independente.csv; 05_resultados/erros_vida_util_nao_detectados.csv",
    "O teste de indicador de impairment sinalizou 100.113 registros: 86 são os erros inseridos (indicador ausente) e 100.027 têm indicador 'Nao avaliado', estado válido da simulação que o teste também sinaliza; 52 erros não foram detectados (24 de vida útil e 28 de amortização) e o arquivo de vida útil não detectada está vazio, o que precisa ser corrigido"),
  c("Registrar conclusão preliminar e limitações",
    "Conclusão documental",
    "Itens anteriores deste PT",
    "Efeito monetário simulado abaixo do limite de distorções irrelevantes; 52 exceções não detectadas seguem em investigação; nenhuma distorção real foi identificada nem testada")
))
grava(pt450, "PT_450.csv")

# ---------------------------------------------------------------- PT 500
pt500 <- monta_pt("PT500", "NBC TA 500", list(
  c("Definir o objetivo da avaliação da evidência de auditoria",
    "Planejamento",
    "Escopo acadêmico do trabalho",
    "Avaliar relevância, confiabilidade e suficiência da evidência disponível"),
  c("Reconciliar aritmeticamente o saldo do intangível com a nota publicada",
    "Evidência pública",
    "05_resultados/reconciliacao_intangivel_revisada.csv; PT05",
    "Saldo inicial R$ 586.859 mil + movimentações R$ 1.287.691 mil = R$ 1.874.550 mil, igual ao divulgado; diferença zero"),
  c("Somar a base sintética e comparar com o saldo público",
    "Simulação (base sintética)",
    "03_base_sintetica/base_sintetica_intangivel.csv; 04_codigo/09_validar_base_intangivel.R",
    "500.000 registros somam R$ 1.874.550 mil em valor_contabil_mil; a base foi construída para igualar o saldo, então a igualdade não é evidência independente"),
  c("Avaliar a confiabilidade das fontes",
    "Análise documental",
    "01_fontes/registro_fontes.csv",
    "DFP publicada é fonte externa pública; a base sintética não representa o razão contábil nem transações reais"),
  c("Planejar procedimentos com registros reais (inspeção, recálculo, confirmação)",
    "Planejado - não executado",
    "Sem acesso a razão, contratos ou documentos internos",
    "Existência, direitos e mensuração do intangível não foram verificados"),
  c("Registrar conclusão preliminar e limitações",
    "Conclusão documental",
    "Itens anteriores deste PT",
    "Evidência insuficiente para opinar; a reconciliação aritmética não comprova existência nem valorização")
))
grava(pt500, "PT_500.csv")

# ---------------------------------------------------------------- PT 530
# Atenção: atualizar as linhas 04 e 05 depois de corrigir o script 18
# (lista de itens sorteados, semente e distorção observada).
pt530 <- monta_pt("PT530", "NBC TA 530", list(
  c("Definir população, unidade de amostragem e método",
    "Simulação (base sintética)",
    "03_base_sintetica/base_sintetica_intangivel.csv",
    "População: 500.000 registros sintéticos, R$ 1.874.550 mil; unidade: real monetário; método: MUS"),
  c("Calcular os parâmetros da amostragem",
    "Simulação (base sintética)",
    "05_resultados/amostragem_mus_projecao.csv; 04_codigo/18_atualizar_pt02_impairment.R",
    "Confiança de 95% (fator 3,0), materialidade de execução R$ 54.169,95 mil, intervalo R$ 18.056,65 mil, n = 104"),
  c("Registrar o tratamento dos itens de valor elevado",
    "Simulação (base sintética)",
    "05_resultados/amostragem_mus_projecao.csv",
    "12 itens acima do intervalo seriam testados a 100%; a lista desses itens ainda não foi gravada"),
  c("Selecionar os itens da amostra",
    "Planejado - não executado",
    "Nenhum arquivo com os itens sorteados, ponto de partida ou semente",
    "Seleção não documentada; o script 18 precisa gravar a lista dos itens selecionados"),
  c("Avaliar o resultado da amostra e projetar as distorções",
    "Planejado - não executado",
    "Nenhum arquivo com a distorção observada na amostra",
    "O resultado 'Aprovado' e a projeção zero do CSV atual não têm suporte na lista dos itens testados"),
  c("Registrar conclusão preliminar e limitações",
    "Conclusão documental",
    "Itens anteriores deste PT",
    "Parâmetros calculados; seleção e avaliação da amostra pendentes; resultado válido só para a base sintética")
))
grava(pt530, "PT_530.csv")

cat("PTs novos gerados no esquema único (7 colunas).\n")

