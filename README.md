# Dossiê Acadêmico de Auditoria — Frasle Mobility S.A. (exercício de 2025)

- **Universidade de Brasília (UnB)** — Auditoria 1 (CCA0024), Turma 02, 2026.2
- **Docente:** Prof. Dr. Lucas Oliveira Gomes Ferreira
- **Estudante:** Pedro Henrique De Oliveira Sucupira — matrícula 241003375
- **Companhia:** Frasle Mobility S.A. (Companhia Aberta, registro CVM 0155265) — demonstrações consolidadas de 2025, com comparativos de 2024

------------------------------------------------------------------------

## 1. O que este trabalho é (e o que não é)

Trabalho acadêmico. Não houve contratação, acesso à companhia nem contato com a administração, e **nenhuma opinião de auditoria é emitida**. Todo resultado do dossiê é de um destes quatro tipos, e a coluna `Natureza` dos papéis de trabalho e a coluna `status_cobertura` da matriz informam qual:

| Natureza oficial (P2) | Significado |
|------------------------------------|------------------------------------|
| **Realizado com evidência pública** | Dado extraído das demonstrações financeiras publicadas na CVM (`01_fontes/`), com fonte e página. |
| **Planejado por falta de acesso** | Procedimento descrito, mas que dependeria de acesso que não existiu (registros internos, confirmações, administração). Inclui o que antes era rotulado "Conceitual ou preliminar". |
| **Simulado para fins didáticos** | Teste sobre a base sintética de 500.000 registros ou sobre premissas hipotéticas. Vale só para a simulação; não é evidência sobre a companhia. |

Os quatro rótulos antigos foram reduzidos aos três oficiais pelo script 47. Os textos anteriores constam em `06_matrizes/log_padronizacao_natureza.csv` (1ª padronização) e `06_matrizes/log_padronizacao_natureza_v2.csv` (esta).

Uma referência normativa, o volume de registros ou a reconciliação aritmética **não substituem** o julgamento sobre a afirmação examinada.

## 1.1 Nome da companhia e prazo

- **Mudança de nome:** a Nota 1 da DFP informa que a **Frasle Mobility S.A.** foi "denominada até 31 de dezembro de 2025 como Frasle S.A."; as ações seguem negociadas na B3 sob **FRAS3** (DFP, p.66). A data efetiva da mudança e a eventual alteração do código de negociação não foram confirmadas além da Nota 1.
- **Revisão:** o campo de revisão de todos os PTs está "Pendente de revisão"; nenhuma assinatura é simulada.
- **Versões das normas:** registradas em `matriz_cobertura_normas.csv` a partir da lista do CFC (consultada em 11/11/2026). NBC TA 240 (R2) e 570 (R1) foram publicadas no DOU em 25/09/2026 e só se aplicam a períodos iniciados em ou após 01/01/2027 (notícia do CFC de 28/09/2026); para o exercício de 2025 vale a NBC TA 240 (R1) e a versão da NBC TA 570 anterior à R1. O número da resolução dessas versões anteriores não consta na lista do CFC consultada e deve ser conferido.

## 2. Estrutura do repositório

```         
01_fontes/               DFP 2025 (PDF da CVM) e registro de fontes
02_papeis_trabalho/      Papéis de trabalho (PT) em CSV, todos no esquema de 7 colunas
  versoes_anteriores/    Versões substituídas na consolidação (preservadas)
03_base_sintetica/       Base sintética de 500.000 registros do intangível, log de erros e dicionário
04_codigo/               Scripts em R (numerados)
05_resultados/           Resultados gerados pelos scripts, incluindo a planilha editável
06_matrizes/             Matriz de cobertura das 27 atividades e índices dos PTs
02_papeis_trabalho/roteiro/  27 PTs do roteiro (PT-EC.md, PT-200.md … PT-600.md) + roteiro_pts_consolidado.csv
07_programas_auditoria/  Programas: receitas, disponibilidades, estoques, imobilizado, passivos, estimativas
08_minutas/              Minutas didáticas (210, 260, 505, 580) — nenhuma enviada ou assinada
09_conclusao_integrada.md  Conclusão integrada, sem opinião
dossie_auditoria_frasle_P2.pdf  Dossiê PDF com referências cruzadas
relatorio_tecnico_v2.*   Relatório (gerado pelo script 39 em 02_papeis_trabalho/; cópia do PDF na raiz)
```

**Esquema dos PTs:** `Codigo, Norma, Procedimento, Natureza, Evidencia, Resultado, Limitacao`. Os campos que não cabem nessas colunas (tema, risco, referências cruzadas, status, área, título, preparador, revisor, datas) estão preservados em:

- `06_matrizes/detalhes_procedimentos_pts.csv` — por procedimento (colunas `Codigo`, `Campo`, `Valor`);
- `06_matrizes/indice_papeis_trabalho.csv` — por papel de trabalho.

Nenhum PT tem revisor independente: o campo de revisão está sempre "pendente".

## 3. Cobertura das 27 atividades

A matriz `06_matrizes/matriz_cobertura_normas.csv` lista as 27 atividades (Estrutura Conceitual e NBC TA 200 a 600) com o procedimento, a evidência vinculada, o resultado, o status e a limitação de cada uma. **Todas têm natureza e versão da norma registradas** (coluna `versao_norma`); nenhuma é tratada como auditoria executada. A matriz foi regerada pelo script 47 e liga cada atividade ao PT do roteiro em `02_papeis_trabalho/roteiro/`; os PTs antigos (PT02 … PT32) ficam como apoio e são citados como "Legado" em cada PT. As normas sem PT próprio no início do trabalho (230, 300, 315, 330, 450, 500 e 530) têm agora `PT_230.csv`, `PT_300.csv`, `PT_315.csv`, `PT_330.csv`, `PT_450.csv`, `PT_500.csv` e `PT_530.csv`. A NBC TA 540 é coberta pelo `PT02_nota16_impairment.csv` e pelo `PT02_procedimentos_complementares.csv`, e a NBC TA 320 pelo `PT32_materialidade.csv`.

## 4. Como reexecutar (ordem)

Pré-requisitos: R com os pacotes base; `data.table` (opcional, acelera a leitura da base) e `rmarkdown` (opcional, para o PDF). Execute a partir da raiz do projeto, no console do R, com `source("04_codigo/<arquivo>.R")`.

A base sintética já está versionada em `03_base_sintetica/` (gerada e validada pelos scripts 06 a 12 e investigada no 19). Não é necessário regerá-la.

| Ordem | Script | O que produz |
|------------------------|------------------------|------------------------|
| 1 | `20_pt_fraude.R`, `21_pt_continuidade.R`, `22` a `34`, `36`, `37`, `38` (sem `21_atualizar_matriz.R`) | PT07 a PT24 (um script por PT) |
| 2 | `43_pts_novos_explandidos.R` | `PT_230`, `PT_300`, `PT_315`, `PT_330`, `PT_450`, `PT_500` (e um `PT_530` provisório) |
| 3 | `18_atualizar_pt02_impairment.R` | Sensibilidade do DCF didático, amostra MUS, `PT02_nota16_impairment.csv` e `PT_530.csv` definitivo |
| 4 | `41_calculo_materialidade.R` | Materialidade, comparação de referenciais e `PT32_materialidade.csv` |
| 5 | `14_matriz_cobertura_normas.R` | Matriz de cobertura das 27 atividades |
| 6 | `44_padronizar_pts.R` | Converte os PTs de 17, 14 e 8 colunas para o esquema de 7 colunas |
| 7 | `45_consolidar_pts.R` | Consolida PT02 complementar e PT03 a PT06; arquiva versões anteriores |
| 8 | `46_padronizar_natureza.R` | Reduz a coluna `Natureza` dos PTs aos quatro rótulos e grava o log |
| 9 | `39_gerar_relatorio_tecnico.R` | Relatório técnico (`.md` e PDF), lendo os CSVs de resultados |
| 10 | `python3 04_codigo/47_conformidade_p2.py` | 27 PTs do roteiro, matriz com versões, fontes, programas, minutas, conclusão integrada e Natureza nas 3 classes oficiais (substitui o 46 e a matriz do 14) |
| 11 | `python3 04_codigo/48_gerar_xlsx.py` | `05_resultados/planilhas_editaveis_p2.xlsx` (materialidade, amostra MUS, reconciliação, analíticos, inseridos × detectados; com fórmulas) |
| 12 | `python3 04_codigo/49_verificacao_p2.py` | Lista OK/FALTA contra as instruções do P2 |

Observações: o script 18 deve rodar **depois** do 43 (ele regrava o `PT_530.csv`). Os scripts 13, 15, 16 e 17 geraram os formatos anteriores de PT02 a PT06 e são históricos; não devem ser reexecutados depois do 45. Os scripts `21_atualizar_matriz.R`, `35_revisar_matriz_final.R` e `42_revisar_cobertura_normas.R` atualizavam a matriz num formato antigo e estão em `04_codigo/versoes_anteriores/`: a matriz atual vem do script 47 (o 14 gerava a versão anterior; não rodar o 14 depois do 47). O script 19 lista os erros inseridos que cada teste não detectou (`erros_vida_util_nao_detectados.csv` e `erros_amortizacao_nao_detectados.csv`, ambos de Goodwill, excluído do teste de vida útil). Se o console acusar objetos de outro script, rode `rm(list = ls())` antes de cada `source()`. O `01_estrutura.R` (exploração inicial, formatos antigos de PT02 a PT05) também é histórico e fica em `04_codigo/versoes_anteriores/`.

## 5. Principais resultados (todos lidos de `05_resultados/`)

### Materialidade — `PT32_materialidade.csv`, `calculo_materialidade.csv`, `comparacao_referenciais_materialidade.csv`

Os percentuais são premissas acadêmicas; a NBC TA 320 não fixa percentuais. Referenciais das demonstrações consolidadas de 2025 (R\$ mil):

| Referencial               | Valor 2025 |  \% | Materialidade global | Seleções MUS |
|---------------------------|-----------:|----:|---------------------:|-------------:|
| **Ativo total (adotado)** |  7.222.660 |  1% |        **72.226,60** |          104 |
| Receita de venda          |  5.490.878 |  1% |            54.908,78 |          137 |
| Patrimônio líquido        |  2.481.481 |  1% |            24.814,81 |          303 |
| Lucro antes dos tributos  |    320.897 |  5% |            16.044,85 |          468 |

Derivados do ativo total: execução (75%) R\$ 54.169,95 mil; limite de distorções irrelevantes (5%) R\$ 3.611,33 mil; materialidade específica do intangível (1% do saldo) R\$ 18.745,50 mil.

**Justificativa e limite da escolha:** o ativo total foi mantido porque o objeto do trabalho é uma conta patrimonial (intangível: 25,95% do ativo) e o lucro antes dos tributos caiu 40,9% no ano, com resultado financeiro de +R\$ 24.129 mil para −R\$ 403.209 mil. O ativo total também cresceu (+48,3%), de modo que a escolha **não** se apoia em estabilidade. É o referencial **mais permissivo** da comparação (a materialidade adotada equivale a 4,5 vezes a obtida com o lucro antes dos tributos).

**Decisão (13/11/2026):** mantido 1% do ativo total como materialidade global, com a limitação acima registrada.

### Reconciliação do intangível — `PT05_conclusao_reconciliacao.csv`, `reconciliacao_intangivel_revisada.csv`

Evidência pública: saldo inicial R\$ 586.859 mil + movimentações R\$ 1.287.691 mil = R\$ 1.874.550 mil, igual ao divulgado (diferença zero). A igualdade aritmética não comprova existência, direitos, mensuração nem recuperabilidade.

### Base sintética e detecção — `PT06`, `PT_450`, `comparacao_erros_teste.csv`

Simulação. A base tem 500.000 registros (soma R\$ 1.874.550 mil, construída para igualar o saldo público) e 250 erros inseridos.

| Tipo de erro                    | Inseridos | Detectados |  Taxa |
|---------------------------------|----------:|-----------:|------:|
| Vida útil inadequada            |        79 |         55 | 69,6% |
| Indicador de impairment ausente |        86 |         86 |  100% |
| Amortização inconsistente       |        85 |         57 | 67,1% |

52 erros não foram detectados (24 de vida útil e 28 de amortização), todos em registros de Goodwill: o teste de vida útil exclui Goodwill por desenho e, nos 28 de amortização, o valor registrado e o esperado são ambos zero (`erros_vida_util_nao_detectados.csv` e `erros_amortizacao_nao_detectados.csv`, script 19). O teste de indicador de impairment sinalizou 100.113 registros: 86 são os erros inseridos e 100.027 têm indicador "Nao avaliado", estado válido da simulação que o teste também sinaliza.

### Amostragem por unidade monetária — `PT_530.csv`, `amostragem_mus_projecao.csv`, `mus_amostra_selecionada.csv`

Simulação. Confiança de 95%, materialidade de execução R\$ 54.169,95 mil, intervalo R\$ 18.056,65 mil, **104 seleções** sorteadas com `set.seed(241003375)`. A lista dos itens está em `mus_amostra_selecionada.csv`. Resultado: 0 erros inseridos na amostra; limite superior de distorção (Stringer, 95%) R\$ 54.092,89 mil, abaixo da materialidade de execução. Nenhum registro da base atinge o intervalo, portanto não há camada testada a 100%.

**Limite desta evidência:** os 250 erros inseridos somam apenas R\$ 1.056,35 mil de valor contábil; uma amostra dessa dimensão tem baixa chance de encontrá-los. A ausência de erros na amostra não prova a ausência de erros na base.

### Sensibilidade de um DCF didático — `PT02_nota16_impairment.csv`, `analise_sensibilidade_*.csv`, `sensibilidade_mus_editavel.xlsx`

Simulação com **premissas hipotéticas**: fluxo de caixa de R\$ 250.000 mil por ano, WACC base de 11,5% e crescimento de 3,0%. **Não é o modelo da administração da Frasle nem dado público**; demonstra o método e **não conclui sobre a razoabilidade da estimativa real**, que não foi testada. No modelo ilustrativo, o valor recuperável do cenário base é R\$ 2.941.176 mil contra um saldo de R\$ 1.874.550 mil; a perda simulada só aparece com WACC de 16,34% (+4,84 p.p.) ou com queda de 36,3% no fluxo de caixa. A planilha `05_resultados/sensibilidade_mus_editavel.xlsx` permite alterar as premissas (abas DCF didático, MUS e Materialidade).

## 6. Rastreabilidade (resultado → arquivo → script)

| Resultado | Arquivo | Script | Natureza |
|------------------|------------------|------------------|------------------|
| Materialidade e comparação de referenciais | `PT32_materialidade.csv`, `calculo_materialidade.csv`, `comparacao_referenciais_materialidade.csv` | 41 | Evidência pública + premissas |
| Variações analíticas 2024–2025 | `analise_procedimentos_analiticos.csv` (PT17) | 30 | Evidência pública |
| Reconciliação do intangível | `reconciliacao_intangivel_revisada.csv`; `PT05_conclusao_reconciliacao.csv` | 15 (cálculo; em `versoes_anteriores/`, já executado) e 45 (PT05) | Evidência pública |
| Erros inseridos e detecção na base | `resumo_erros_inseridos.csv` (10); `comparacao_erros_teste.csv`, `resumo_deteccao_independente.csv` (11) | 10 e 11 (validação da base: 09) | Simulação |
| Amostra MUS | `mus_amostra_selecionada.csv`, `amostragem_mus_projecao.csv` | 18 | Simulação |
| Sensibilidade do DCF didático | `analise_sensibilidade_impairment.csv`, `..._ponto_ruptura.csv`, `..._grade.csv` | 18 | Simulação (hipotética) |
| Matriz das 27 atividades | `06_matrizes/matriz_cobertura_normas.csv` | 14 | Status por atividade |
| Relatório técnico | `02_papeis_trabalho/relatorio_tecnico_v2.md` | 39 | Lê os CSVs acima |

## 7. Exceções não resolvidas e limitações

- 52 dos 250 erros simulados não foram detectados pelos testes (`PT_450.csv`). A origem foi localizada (todos em Goodwill, fora do alcance do teste de vida útil, e com amortização zero nos de amortização), mas os testes não foram redesenhados para cobri-los e o efeito deles não foi mensurado.
- As sinalizações de indicador de impairment acima dos erros inseridos não foram investigadas individualmente.
- O efeito monetário dos erros simulados foi medido só para amortização inconsistente (R\$ 158,40 mil); vida útil e indicador de impairment não têm efeito monetário direto mensurável na base.
- A estimativa de recuperabilidade real, os controles internos, as confirmações externas, as representações da administração, a auditoria de grupo e os componentes **não foram examinados**: não houve acesso.
- Os percentuais de materialidade são premissas; o resultado da amostragem vale só para a base sintética.
- Nenhum papel de trabalho foi revisado por terceiro.

## 8. Conclusão integrada

Ver `09_conclusao_integrada.md`: nenhuma opinião é emitida. A base sintética (500.000 registros) reconcilia ao saldo do intangível; seu código está em `04_codigo/` e o arquivo (66,9 MB) cabe no limite do GitHub.

### Conclusão do trabalho

Com base em informações públicas e em uma base sintética, o trabalho: (i) fixou e justificou a materialidade com comparação de quatro referenciais; (ii) verificou que o saldo do intangível reconcilia aritmeticamente com a nota publicada; (iii) demonstrou testes de detecção e uma amostra MUS reproduzível sobre dados simulados; e (iv) demonstrou o método de sensibilidade com premissas hipotéticas. **Não é possível concluir** sobre a existência, a mensuração ou a recuperabilidade do intangível da companhia, nem sobre as demais contas. Os resultados sobre a base sintética não se aplicam à Frasle Mobility S.A.

## 9. Fontes

- CVM — Demonstrações Financeiras Padronizadas (DFP 2025), Frasle Mobility S.A., documento 155265 (`01_fontes/`; consultado em 23/10/2026).
- Portal de Relações com Investidores: ri.fraslemobility.com.
- CFC — Normas Brasileiras de Contabilidade Técnicas de Auditoria (NBC TA 200 a 600): https://cfc.org.br/tecnica/normas-brasileiras-de-contabilidade/nbc-ta-de-auditoria-independente/ (consultada em 11/11/2026).
- Lista completa, com endereço, data, página e exercício: `01_fontes/registro_fontes.csv`.
