# Relatório Técnico — Dossiê Acadêmico de Auditoria
**Frasle Mobility S.A. | Exercício de 2025**

## 1. Identificação

- **Companhia analisada:** Frasle Mobility S.A. (Companhia Aberta, registro CVM 0155265)
- **Exercício:** 01/01/2025 a 31/12/2025, com comparativos de 2024
- **Instituição / disciplina:** Universidade de Brasília — Auditoria 1 (CCA0024), Turma 02, 2026.2
- **Docente:** Prof. Dr. Lucas Oliveira Gomes Ferreira
- **Estudante:** Pedro Henrique De Oliveira Sucupira (matrícula 241003375)
- **Data de geração:** 11/11/2026

## 2. Natureza do trabalho e como ler os resultados

Este é um trabalho acadêmico. Não houve contratação, acesso à companhia, contato com a administração nem opinião de auditoria. Cada resultado deste relatório é de um de três tipos:

- **Evidência pública:** dado extraído das demonstrações financeiras publicadas na CVM (`01_fontes/`).
- **Planejado — não executado:** procedimento descrito, mas que dependeria de acesso que não existiu.
- **Simulação:** teste sobre a base sintética de 500.000 registros ou sobre premissas hipotéticas; vale só para a simulação e não é evidência sobre a companhia.

A coluna de status da matriz de cobertura (seção 10) classifica cada uma das 27 atividades. Nenhuma está marcada como executada em auditoria real.

## 3. Fontes e método

- Demonstrações financeiras consolidadas de 2025 e 2024 (CVM, documento 155265), consultadas em 23/10/2026 (`01_fontes/registro_fontes.csv`).
- Cálculos em R, numerados em `04_codigo/`, gerando os arquivos de `05_resultados/`. Este relatório lê esses arquivos para montar as tabelas e os resultados.
- A base sintética (`03_base_sintetica/`) foi gerada por código, é identificada como sintética em cada registro e foi construída para somar ao saldo público do intangível.

## 4. Materialidade (NBC TA 320 e 450) — PT32

Foi adotado o **ativo total de 2025** como referencial principal, com materialidade global de R$ 72.226,60 mil. Os percentuais são premissas acadêmicas; a NBC TA 320 não fixa percentuais. A comparação com os demais referenciais, a partir das demonstrações consolidadas:

| Referencial | Valor 2025 | Variação vs 2024 | Percentual | Materialidade global | Seleções MUS | Adotado |
| --- | --- | --- | --- | --- | --- | --- |
| Ativo total | 7.222.660 | 48,3% | 1% | 72.226,60 | 104 | SIM |
| Receita de venda (líquida) | 5.490.878 | 38,5% | 1% | 54.908,78 | 137 | não |
| Lucro antes dos tributos | 320.897 | -40,9% | 5% | 16.044,85 | 468 | não |
| Patrimônio líquido consolidado | 2.481.481 | 10,2% | 1% | 24.814,81 | 303 | não |

A materialidade adotada é a **mais alta** da comparação. Justificativa: o objeto do trabalho é uma conta patrimonial (o intangível, 25,95% do ativo) e o lucro antes dos tributos variou -40,9% no ano. O ativo total também variou 48,3%, então a escolha não se apoia em estabilidade. Como consequência, a amostra MUS fica menor (104 seleções contra 468 com o lucro antes dos tributos).

| Parâmetro | Base | Percentual | Valor (R$ mil) |
| --- | --- | --- | --- |
| Materialidade global | Ativo total 2025 (DFP 1) | 1,0% | 72.226,60 |
| Materialidade de execução | Materialidade global | 75,0% | 54.169,95 |
| Limite de distorções irrelevantes | Materialidade global | 5,0% | 3.611,33 |
| Materialidade específica do intangível | Saldo do intangível 2025 | 1,0% | 18.745,50 |

Detalhe e cálculo editável: `02_papeis_trabalho/PT32_materialidade.csv` e `05_resultados/sensibilidade_mus_editavel.xlsx`.

## 5. Procedimentos analíticos (NBC TA 520) — PT17

Evidência pública: comparação dos saldos consolidados de 2024 e 2025.

| Conta | 2024 | 2025 | Variação | Variação % | Observação |
| --- | --- | --- | --- | --- | --- |
| Ativo total | 4.869.614 | 7.222.660 | 2.353.046 | 48,3% | Variacao relevante para investigacao; nao representa erro confirmado |
| Intangivel | 586.859 | 1.874.550 | 1.287.691 | 219,4% | Variacao relevante para investigacao; nao representa erro confirmado |
| Imobilizado e arrendamentos | 969.831 | 1.450.996 | 481.165 | 49,6% | Variacao relevante para investigacao; nao representa erro confirmado |
| Estoques | 1.054.752 | 1.443.447 | 388.695 | 36,9% | Variacao relevante para investigacao; nao representa erro confirmado |
| Caixa e equivalentes de caixa | 844.881 | 1.316.248 | 471.367 | 55,8% | Variacao relevante para investigacao; nao representa erro confirmado |

As variações são sinais para investigação, não erros. A demonstração dos fluxos de caixa consolidada registra saída de R$ 2.090.324 mil em combinação de negócios em 2025, compatível com o crescimento do intangível, mas a alocação do preço de aquisição e o teste de ágio não foram examinados e as explicações da administração não foram obtidas.

## 6. Reconciliação aritmética do intangível — PT05

Evidência pública: saldo inicial R$ 586.859 mil + movimentações R$ 1.287.691 mil = R$ 1.874.550 mil, igual ao saldo divulgado; diferença de R$ 0 mil. A reconciliação aritmética não comprova existência, direitos, mensuração nem recuperabilidade.

## 7. Base sintética e testes de detecção — PT06 e PT_450 (simulação)

A base tem 500.000 registros e 250 erros inseridos deliberadamente. Resultado dos testes automáticos em R:

| Tipo | Inseridos | Sinalizados | Não detectados | Detecção |
| --- | --- | --- | --- | --- |
| Vida util inadequada | 79 | 55 | 24 | 69,6% |
| Indicador de impairment ausente | 86 | 86 | 0 | 100,0% |
| Amortizacao inconsistente | 85 | 57 | 28 | 67,1% |

**52 erros inseridos não foram detectados.** O arquivo `05_resultados/erros_vida_util_nao_detectados.csv` deveria listar os de vida útil e precisa ser revisto. O teste de indicador de impairment sinalizou mais registros do que os erros inseridos:

| Teste | Registros sinalizados |
| --- | --- |
| Vida util inferior a tres anos | 55 |
| Indicador de impairment ausente ou nao avaliado | 100.113 |
| Amortizacao diferente da referencia sintetica | 57 |

A maior parte das sinalizações de indicador de impairment corresponde ao estado 'Nao avaliado', que é um valor válido na simulação e que o teste também sinaliza; essas sinalizações não foram investigadas individualmente.

## 8. Amostragem por unidade monetária — PT_530 (simulação)

Sobre a base sintética (R$ 1.874.550 mil): confiança de 95%, materialidade de execução de R$ 54.169,95 mil, intervalo de R$ 18.056,65 mil e 104 seleções, sorteadas com semente 241003375. A lista dos itens está em `05_resultados/mus_amostra_selecionada.csv`.

Resultado: 0 erro(s) inserido(s) entre os itens selecionados; limite superior de distorção de R$ 54.092,89 mil contra materialidade de execução de R$ 54.169,95 mil.

Limite desta evidência: os 250 erros inseridos somam apenas R$ 1.056,35 mil de valor contábil; uma amostra dessa dimensão tem baixa chance de encontrá-los, e a ausência de erros na amostra não prova a ausência de erros na base. A conclusão vale só para a simulação.

## 9. Sensibilidade de um DCF didático — PT02 (simulação)

O modelo abaixo é **didático e ilustrativo**: fluxo de caixa, WACC e crescimento são premissas hipotéticas do autor, não o modelo da administração da Frasle nem dado público. O exercício demonstra o método de sensibilidade; **não conclui sobre a razoabilidade da estimativa real**, que não foi testada (método, dados, premissas e viés da administração permanecem fora do alcance).

Premissas hipotéticas: fluxo de caixa de R$ 250.000 mil por ano, g de 3.00%. Valor contábil comparado: R$ 1.874.550 mil.

| Cenário | WACC | Valor recuperável (R$ mil) | Margem | Perda simulada (R$ mil) |
| --- | --- | --- | --- | --- |
| WACC -2.0 p.p. | 9.50% | 3.846.154 | 105,2% | 0 |
| WACC -1.0 p.p. | 10.50% | 3.333.333 | 77,8% | 0 |
| Cenário base | 11.50% | 2.941.176 | 56,9% | 0 |
| WACC +1.0 p.p. | 12.50% | 2.631.579 | 40,4% | 0 |
| WACC +2.0 p.p. | 13.50% | 2.380.952 | 27,0% | 0 |
| WACC +5.0 p.p. | 16.50% | 1.851.852 | -1,2% | 22.698 |

Ponto de ruptura do modelo ilustrativo: WACC de 16,34% (4,84 p.p. acima do cenário base) ou queda de 36,3% no fluxo de caixa. Grade completa em `05_resultados/analise_sensibilidade_grade.csv`.

## 10. Matriz de cobertura das 27 atividades

Fonte: `06_matrizes/matriz_cobertura_normas.csv`. Todas as atividades têm status parcial ou planejado; o detalhe de cada resultado e de cada limitação está na matriz e no PT indicado.

| Atividade | Status | Evidência |
| --- | --- | --- |
| Estrutura Conceitual | Parcial – conceitual; planejado, não executado | 02_papeis_trabalho/PT22_estrutura_conceitual.csv |
| NBC TA 200 (R1) | Parcial – conceitual; planejado, não executado | 02_papeis_trabalho/PT18_objetivos_auditor.csv |
| NBC TA 210 (R1) | Parcial – conceitual; planejado, não executado | 02_papeis_trabalho/PT19_termos_trabalho.csv |
| NBC TA 220 (R1) | Parcial – conceitual; planejado, não executado | 02_papeis_trabalho/PT23_gestao_qualidade.csv |
| NBC TA 230 (R1) | Parcial – documentação própria | 02_papeis_trabalho/PT_230.csv; 06_matrizes/matriz_cobertura_normas.csv |
| NBC TA 240 (R1) | Parcial – planejado, não executado | 02_papeis_trabalho/PT07_riscos_fraude.csv |
| NBC TA 250 (R1) | Parcial – evidência pública; testes planejados | 02_papeis_trabalho/PT11_leis_regulamentos.csv |
| NBC TA 260 (R1) | Parcial – planejado, não executado | 02_papeis_trabalho/PT12_comunicacao_governanca.csv |
| NBC TA 265 | Parcial – planejado, não executado | 02_papeis_trabalho/PT13_deficiencias_controles.csv |
| NBC TA 300 (R1) | Parcial – planejamento inicial | 02_papeis_trabalho/PT_300.csv |
| NBC TA 315 (R2) | Parcial – evidência pública | 02_papeis_trabalho/PT_315.csv |
| NBC TA 320 (R1) | Parcial – cálculo com premissas ilustrativas | 02_papeis_trabalho/PT32_materialidade.csv; 05_resultados/calculo_materialidade.csv |
| NBC TA 330 (R1) | Parcial – simulação (base sintética) | 02_papeis_trabalho/PT_330.csv |
| NBC TA 402 | Parcial – planejado, não executado | 02_papeis_trabalho/PT20_organizacoes_servicos.csv |
| NBC TA 450 (R1) | Parcial – simulação (base sintética) | 02_papeis_trabalho/PT_450.csv; apoio: 05_resultados/resumo_geral_excecoes.csv |
| NBC TA 500 (R1) | Parcial – simulação reconciliada a evidência pública | 02_papeis_trabalho/PT_500.csv; apoio: 05_resultados/reconciliacao_intangivel_revisada.csv |
| NBC TA 501 | Parcial – evidência pública; testes planejados | 02_papeis_trabalho/PT15_itens_selecionados.csv |
| NBC TA 505 | Planejado – não executado | 02_papeis_trabalho/PT16_confirmacoes_externas.csv |
| NBC TA 510 (R1) | Parcial – evidência pública | 02_papeis_trabalho/PT14_saldos_iniciais.csv |
| NBC TA 520 | Parcial – evidência pública (cálculo em R) | 02_papeis_trabalho/PT17_procedimentos_analiticos.csv |
| NBC TA 530 | Parcial – simulação (base sintética) | 02_papeis_trabalho/PT_530.csv; apoio: 05_resultados/amostragem_mus_projecao.csv |
| NBC TA 540 (R2) | Parcial – simulação (DCF didático) | 02_papeis_trabalho/PT02_nota16_impairment.csv; 05_resultados/analise_sensibilidade_impairment.csv |
| NBC TA 550 | Parcial – evidência pública | 02_papeis_trabalho/PT10_partes_relacionadas.csv |
| NBC TA 560 | Parcial – evidência pública | 02_papeis_trabalho/PT09_eventos_subsequentes.csv |
| NBC TA 570 | Parcial – evidência pública | 02_papeis_trabalho/PT08_continuidade_operacional.csv |
| NBC TA 580 | Planejado – não executado | 02_papeis_trabalho/PT21_representacoes_formais.csv |
| NBC TA 600 (R1) | Parcial – evidência pública; componentes pendentes | 02_papeis_trabalho/PT24_auditoria_grupo.csv |

## 11. Relatório dos auditores independentes (evidência pública)

O relatório da KPMG Auditores Independentes S.S., de 11 de março de 2026, que consta do documento da CVM, expressa opinião sem ressalva sobre as demonstrações individuais e consolidadas. Esse relatório é de terceiros e não substitui nem foi revisado por este trabalho.

## 12. Exceções não resolvidas e limites do alcance

- 52 dos 250 erros simulados não foram detectados pelos testes e seguem sem investigação.
- As sinalizações de indicador de impairment acima dos erros inseridos não foram investigadas.
- O efeito monetário dos erros simulados foi medido só para amortização inconsistente; vida útil e indicador de impairment não têm efeito monetário direto na base.
- A estimativa de recuperabilidade real, os controles internos, as confirmações externas, as representações da administração e os componentes do grupo não foram examinados: não houve acesso.
- Os papéis de trabalho de várias normas têm natureza conceitual ou de planejamento. A documentação ainda precisa consolidar versões duplicadas e padronizar o esquema de colunas dos PTs antigos.

## 13. Conclusão

Com base apenas em informações públicas e em uma base sintética, este trabalho (i) fixou e justificou a materialidade com comparação de quatro referenciais, (ii) verificou que o saldo do intangível reconcilia aritmeticamente com a nota publicada, (iii) demonstrou testes de detecção e uma amostra MUS reproduzível sobre dados simulados e (iv) demonstrou o método de sensibilidade com premissas hipotéticas. Não é possível concluir sobre a existência, a mensuração ou a recuperabilidade do intangível da companhia, nem sobre as demais contas. Os resultados sobre a base sintética não se aplicam à Frasle Mobility S.A.

## 14. Referências

- CFC: Normas Brasileiras de Contabilidade Técnicas de Auditoria (NBC TA 200 a 600).
- CVM: Demonstrações Financeiras Padronizadas (DFP 2025) — Frasle Mobility S.A. (documento 155265).
- Portal de Relações com Investidores: ri.fraslemobility.com.
