# Dossiê Acadêmico de Auditoria

## 1. Identificação

- Entidade: Frasle Mobility S.A.
- Exercício analisado: 2025, com comparativos de 2024.
- Disciplina: Auditoria 1 - CCA0024 - Turma 02 - 2026.2.
- Natureza: estudo acadêmico baseado em demonstrações financeiras publicadas, notas explicativas, relatório do auditor independente e procedimentos analíticos e demonstrativos desenvolvidos em R.
- Data-base das demonstrações: 31 de dezembro de 2025.
- Pedro Henrique De Oliveira Sucupira - 241003375

## 2. Objetivo e escopo

O objetivo deste trabalho é desenvolver e documentar uma abordagem acadêmica de auditoria das demonstrações financeiras da Frasle Mobility S.A., referentes ao exercício encerrado em 31 de dezembro de 2025, considerando as informações comparativas de 2024. O estudo contempla a identificação e a avaliação preliminar de riscos de distorção relevante, a análise de variações patrimoniais, a reconciliação aritmética de saldos, a elaboração de procedimentos de auditoria e a execução de testes demonstrativos com dados sintéticos, com ênfase na conta de ativos intangíveis.

O trabalho considera a Estrutura Conceitual e as Normas Brasileiras de Contabilidade aplicáveis à auditoria independente incluídas no escopo acadêmico, buscando demonstrar a aplicação do julgamento profissional, do ceticismo profissional, da avaliação de riscos e da obtenção e análise de evidências.

A análise utiliza informações públicas da companhia e procedimentos reproduzíveis em R. Os testes realizados com dados sintéticos têm finalidade exclusivamente demonstrativa e não constituem evidência sobre registros contábeis reais da entidade.

Este dossiê não constitui uma auditoria independente contratada, não substitui os procedimentos de um auditor habilitado e não emite opinião própria sobre as demonstrações financeiras. As conclusões estão limitadas às informações públicas examinadas e aos testes efetivamente documentados. Procedimentos que dependem de acesso a documentos internos, sistemas, confirmações externas ou outras evidências não públicas são apresentados como procedimentos complementares propostos ou pendentes, conforme aplicável.

## 3. Fontes e metodologia

O trabalho foi desenvolvido com base nas informações públicas da Frasle Mobility S.A. referentes ao exercício encerrado em 31 de dezembro de 2025, incluindo as demonstrações financeiras padronizadas (DFP), os valores comparativos de 2024, as notas explicativas e o relatório do auditor independente. As fontes institucionais consultadas incluem a Comissão de Valores Mobiliários (CVM) e a página de Relações com Investidores da companhia, conforme registrado em 01_fontes/registro_fontes.csv.

A metodologia compreendeu a leitura e a análise das informações financeiras divulgadas, a comparação de saldos entre 2024 e 2025, a identificação de variações patrimoniais relevantes, a avaliação preliminar de riscos relacionados aos ativos intangíveis e a reconciliação aritmética da movimentação desses ativos com os saldos divulgados nas demonstrações financeiras.

Para demonstrar procedimentos analíticos e regras de detecção de exceções, foi desenvolvida em R uma base sintética com 500.000 registros e 250 erros inseridos deliberadamente. Os testes avaliaram regras relacionadas à vida útil dos ativos, aos indicadores de impairment e à amortização. Os registros e erros simulados não correspondem a lançamentos contábeis reais da companhia.

Os procedimentos foram documentados em papéis de trabalho e complementados por tabelas de resultados, arquivos de reconciliação e uma matriz de cobertura das normas consideradas no escopo acadêmico. Os caminhos dos arquivos são indicados para facilitar a rastreabilidade e a reprodução das análises.

A metodologia apresenta limitações decorrentes da utilização de informações públicas e da ausência de acesso aos registros contábeis analíticos, aos documentos de suporte, aos controles internos e às premissas detalhadas utilizadas pela administração. Consequentemente, as análises e os testes demonstrativos não permitem concluir, isoladamente, sobre a existência, a mensuração, a recuperabilidade ou a ausência de distorções nos saldos reais da entidade.

## 4. Materialidade e seleção da conta

Com base nas demonstrações financeiras consolidadas da Frasle Mobility S.A. referentes ao exercício de 2025, o ativo total correspondeu a R$ 7.222.660 mil, enquanto os ativos intangíveis totalizaram R$ 1.874.550 mil. Dessa forma, os intangíveis representaram aproximadamente 25,95% do ativo total consolidado, constituindo uma conta relevante para o direcionamento dos procedimentos de auditoria.

A seleção dos ativos intangíveis para análise aprofundada considerou sua representatividade patrimonial e a complexidade dos julgamentos contábeis envolvidos em seu reconhecimento e mensuração. Entre os aspectos relevantes estão os ativos provenientes de combinações de negócios, a identificação e a mensuração de marcas e carteiras de clientes, a determinação das vidas úteis, o cálculo da amortização e a avaliação de possíveis perdas por redução ao valor recuperável (impairment), especialmente em relação ao ágio por expectativa de rentabilidade futura (goodwill).

Para fins acadêmicos, adotou-se provisoriamente o ativo total de 2025 como base de referência para a estimativa da materialidade global. Conforme documentado no papel de trabalho PT32_materialidade.txt e no arquivo 05_resultados/calculo_materialidade.csv, a aplicação do percentual ilustrativo de 1% sobre o ativo total resultou em materialidade global estimada de R$ 72.226,60 mil. A materialidade para execução foi estimada em 75% desse valor, correspondendo a R$ 54.169,95 mil.

Adicionalmente, calculou-se, para fins de análise de sensibilidade, o equivalente a 2% do saldo dos ativos intangíveis, correspondente a R$ 37.491 mil. Esse valor representa apenas um cenário ilustrativo e não constitui materialidade específica formalmente estabelecida para a conta.

Os percentuais utilizados são premissas acadêmicas preliminares, adotadas para demonstrar a aplicação dos conceitos de materialidade, e não percentuais obrigatórios estabelecidos pela NBC TA 320. Em uma auditoria independente, a definição e a revisão da materialidade devem considerar o julgamento profissional, as necessidades dos usuários das demonstrações financeiras, a natureza da entidade e os riscos identificados durante o trabalho.

Assim, a seleção dos ativos intangíveis e os parâmetros de materialidade apresentados serviram para orientar a priorização das análises e dos procedimentos documentados neste dossiê, sem representar a definição formal de materialidade em uma auditoria independente real.

## 5. Procedimentos analíticos

A comparação das demonstrações financeiras consolidadas entre 2024 e 2025 evidenciou variações patrimoniais relevantes. O ativo total aumentou R$ 2.353.046 mil, equivalente a 48,32%. No mesmo período, os ativos intangíveis aumentaram R$ 1.287.691 mil (219,42%), o imobilizado e os ativos de direito de uso relacionados a arrendamentos aumentaram R$ 481.165 mil (49,61%), os estoques aumentaram R$ 388.695 mil (36,85%) e o caixa e equivalentes de caixa aumentaram R$ 471.367 mil (55,79%).

O crescimento dos ativos intangíveis, superior ao crescimento do ativo total, constitui um ponto de atenção para a auditoria, especialmente diante da relevância de ativos associados a combinações de negócios e dos julgamentos necessários à determinação de vidas úteis, amortização e recuperabilidade. A variação também deve ser interpretada considerando os efeitos de aquisições e da incorporação de novos ativos ao patrimônio durante o exercício.

As variações observadas no imobilizado, nos arrendamentos e nos estoques também justificam investigação adicional. Entre os procedimentos complementares possíveis estão a comparação com o exercício anterior, a análise das movimentações e dos documentos de suporte, a verificação da consistência entre saldos contábeis e notas explicativas e, conforme aplicável, testes de existência, avaliação e corte das operações.

Em relação ao caixa e equivalentes de caixa, o aumento do saldo poderia ser investigado por meio da análise dos fluxos de caixa, das conciliações bancárias e de confirmações externas, caso houvesse acesso às evidências necessárias.

As variações identificadas constituem indícios para direcionamento dos procedimentos de auditoria, mas não demonstram, isoladamente, a existência de distorção relevante. Os procedimentos complementares mencionados são propostas de investigação e não devem ser interpretados como executados quando dependem de documentos internos ou evidências não disponíveis.

## 6. Reconciliação do intangível

A reconciliação aritmética da movimentação dos ativos intangíveis referente a 2025 partiu do saldo inicial de R$ 586.859 mil e incorporou movimentações líquidas de R$ 1.287.691 mil, resultando em saldo calculado de R$ 1.874.550 mil. Esse valor corresponde ao saldo final divulgado nas demonstrações financeiras, de modo que a diferença aritmética apurada foi igual a zero.

O procedimento foi documentado em papel de trabalho e reproduzido em R, permitindo verificar a consistência matemática entre o saldo inicial, as movimentações transcritas e o saldo final divulgado. O resultado confirma a concordância aritmética dos valores utilizados na reconciliação, dentro dos limites dos dados transcritos.

Entretanto, a reconciliação não constitui evidência suficiente, isoladamente, sobre a existência dos ativos, os direitos da entidade, a exatidão de sua mensuração, a adequada alocação dos valores provenientes de combinações de negócios ou sua recuperabilidade. Para examinar essas afirmações, seriam necessários procedimentos adicionais, como inspeção de documentos de suporte, análise dos critérios de reconhecimento e mensuração, avaliação das premissas utilizadas e verificação das divulgações pertinentes.

Como o trabalho acadêmico se baseia em informações públicas e não dispõe de acesso integral aos registros e documentos internos da companhia, tais verificações adicionais são apresentadas como procedimentos complementares propostos, não como procedimentos efetivamente executados.

## 7. Testes com base sintética

Para demonstrar a aplicação de procedimentos de detecção de exceções, foi utilizada uma base sintética com 500.000 registros, nos quais foram inseridos deliberadamente 250 erros simulados: 79 relacionados à vida útil dos ativos, 86 à ausência de indicadores de impairment e 85 a inconsistências de amortização.

Os testes sinalizaram 55 dos 79 erros simulados relacionados à vida útil, correspondendo a uma taxa de detecção de 69,62%. Em relação aos indicadores de impairment, foram identificados os 86 erros inseridos, resultando em taxa de detecção de 100%. Nos testes de amortização, foram sinalizados 57 dos 85 erros simulados, correspondendo a uma taxa de detecção de 67,06%.

Os resultados permitem avaliar o comportamento das regras de teste diante das situações deliberadamente inseridas na base sintética. As taxas observadas referem-se exclusivamente às condições simuladas e não devem ser interpretadas como medidas da eficácia de procedimentos aplicados aos registros reais da companhia.

A quantidade de registros sinalizados pela regra relacionada à ausência ou à falta de avaliação de indicadores de impairment foi superior à quantidade de erros deliberadamente inseridos. Essa diferença indica que a regra também sinalizou registros que exigiriam análise individual para determinar se representam exceções pertinentes ou falsos positivos. A sinalização automática não equivale à confirmação de erro contábil.

Os resultados são exclusivamente demonstrativos e não constituem evidência de distorções nas demonstrações financeiras da Frasle Mobility S.A. A aplicação dos procedimentos a dados reais exigiria acesso aos registros contábeis, aos documentos de suporte e às informações necessárias para investigar e validar cada exceção identificada.

## 8. Riscos e procedimentos adicionais

Os principais riscos de distorção relevante considerados estão relacionados à recuperabilidade dos ativos intangíveis, às taxas de desconto e premissas de crescimento utilizadas nos testes de impairment, à definição das vidas úteis, ao cálculo da amortização, à identificação e mensuração de ativos provenientes de combinações de negócios e à integridade da movimentação dos saldos contábeis.

Esses riscos justificam atenção especial às estimativas e aos julgamentos da administração, uma vez que alterações nas premissas utilizadas podem afetar significativamente os valores reconhecidos nas demonstrações financeiras. Também é relevante examinar se as movimentações dos ativos intangíveis estão adequadamente documentadas e se os saldos divulgados são consistentes com as informações apresentadas nas notas explicativas.

Como procedimentos complementares, foram considerados a inspeção dos modelos internos de avaliação, a análise das premissas utilizadas pela administração, a realização de testes de sensibilidade, a inspeção de documentos relativos às combinações de negócios, a verificação dos cálculos de amortização, a obtenção de confirmações externas quando aplicável e a solicitação de representações formais da administração.

Esses procedimentos dependem, em diferentes graus, de documentos, registros internos, acesso a terceiros ou outras evidências que não estão integralmente disponíveis neste trabalho acadêmico. Por essa razão, devem ser identificados como planejados, propostos ou pendentes, conforme o caso, e não como efetivamente executados.

A identificação dos riscos representa uma avaliação preliminar baseada nas informações públicas examinadas. A avaliação definitiva dos riscos e a determinação da natureza, época e extensão dos procedimentos dependeriam de evidências adicionais e da aplicação do julgamento profissional no contexto de um trabalho de auditoria independente.

## 9. Limitações

Este trabalho acadêmico foi desenvolvido com base em informações públicas da Frasle Mobility S.A., incluindo as demonstrações financeiras, as notas explicativas e o relatório do auditor independente referentes ao exercício de 2025. Também foram utilizados dados sintéticos para demonstrar a aplicação de procedimentos analíticos e regras de detecção de exceções em R.

Não houve acesso integral ao razão contábil, aos registros analíticos da companhia, aos documentos internos de suporte, aos modelos detalhados de avaliação elaborados pela administração, às confirmações externas ou às representações formais da administração. Dessa forma, os procedimentos executados ficaram restritos à análise documental pública, às reconciliações aritméticas dos valores transcritos e aos testes demonstrativos realizados com dados sintéticos.

Essas limitações impedem que os resultados sejam considerados evidência suficiente e apropriada para concluir, de forma independente, sobre a existência dos ativos, os direitos da entidade, a exatidão de sua mensuração, a adequação da amortização ou a recuperabilidade dos saldos divulgados. Os testes com dados sintéticos não permitem inferir a ocorrência de erros ou fraudes nos registros reais da companhia.

Os procedimentos que dependem de evidências não disponíveis foram identificados como complementares, propostos ou pendentes, conforme aplicável. Sua execução exigiria acesso às informações pertinentes e investigação das eventuais exceções identificadas.

Portanto, as conclusões deste dossiê devem ser interpretadas dentro dos limites de um estudo acadêmico baseado em informações públicas e testes demonstrativos. O trabalho não constitui auditoria independente das demonstrações financeiras da companhia nem substitui os procedimentos e as responsabilidades de um auditor independente habilitado.

## 10. Arquivos de suporte e organização do projeto

Os arquivos utilizados na elaboração deste dossiê estão organizados em diretórios, com o objetivo de facilitar a consulta às fontes, a reprodução das análises e a verificação dos procedimentos documentados.

- `01_fontes/`: demonstrações financeiras da companhia, documentos públicos consultados e registro das fontes, incluindo links e datas de acesso.
- `02_papeis_trabalho/`: papéis de trabalho, análises documentais, avaliação de riscos, procedimentos propostos e conclusões obtidas.
- `03_base_sintetica/`: base de dados sintética utilizada nos testes, dicionário de dados e registro dos erros inseridos deliberadamente.
- `04_codigo/`: scripts em R utilizados para estruturar, gerar, validar e analisar a base sintética, realizar reconciliações e produzir papéis de trabalho e matrizes.
- `05_resultados/`: arquivos com resultados analíticos, reconciliações, registros sinalizados, resumos de detecção e comparações entre erros inseridos e identificados.
- `06_matrizes/`: matriz de cobertura das normas de auditoria consideradas no escopo acadêmico.

A organização dos diretórios busca manter a rastreabilidade entre as fontes consultadas, os procedimentos documentados, os códigos utilizados e os resultados apresentados. A reprodução dos resultados depende da preservação dos arquivos de suporte e da execução dos scripts pertinentes na ordem adequada.

## 11. Relatório do auditor independente sobre as demonstrações financeiras

Conforme o relatório incluído nas demonstrações financeiras públicas consultadas, o auditor independente emitiu relatório sem ressalva sobre as demonstrações financeiras do exercício de 2025. O relatório é atribuído à KPMG e está datado de 11 de março de 2026, em Porto Alegre. Essa informação é relatada como conteúdo do documento público consultado e não representa opinião emitida por este trabalho acadêmico.

A leitura do relatório do auditor independente é parte do contexto documental do dossiê. O presente trabalho não reproduz nem substitui a opinião do auditor independente e não realizou procedimentos suficientes para emitir opinião própria sobre as demonstrações financeiras.

## 12. Cobertura das normas de auditoria

A matriz `06_matrizes/matriz_cobertura_normas.csv` registra 27 normas e a Estrutura Conceitual consideradas no escopo acadêmico, com campos de tema, status, evidência ou procedimento e limitação. Os status registrados indicam cobertura parcial, e não conformidade integral ou execução completa de todos os procedimentos previstos nas normas.

A cobertura parcial decorre, entre outros fatores, da natureza acadêmica do trabalho, do uso de informações públicas e dados sintéticos e da falta de acesso a registros internos, controles, documentos de suporte, confirmações externas e representações formais. A matriz deve ser lida em conjunto com os papéis de trabalho e as limitações descritas neste relatório.

A inclusão de uma norma na matriz não significa que todos os seus requisitos foram integralmente atendidos. A matriz deve ser interpretada como instrumento de organização e rastreabilidade da documentação acadêmica, permitindo identificar os temas abordados, os procedimentos documentados e as limitações de cada norma. A classificação parcial não representa conformidade integral com todos os requisitos normativos, tampouco comprova a execução de procedimentos que dependam de evidências não disponíveis. Sua leitura deve ser realizada em conjunto com os papéis de trabalho e com as limitações metodológicas deste dossiê.

## 13. Conclusão

O presente dossiê acadêmico teve como objetivo desenvolver e documentar procedimentos de auditoria sobre as demonstrações financeiras da Frasle Mobility S.A. referentes ao exercício de 2025, com informações comparativas de 2024, enfatizando a análise dos ativos intangíveis. A abordagem integrou a análise de informações financeiras públicas, a identificação preliminar de riscos de distorção relevante, a reconciliação aritmética de saldos, a aplicação demonstrativa de testes em R e a organização dos procedimentos em papéis de trabalho e matriz de cobertura das normas de auditoria consideradas no escopo.

Os procedimentos analíticos evidenciaram crescimento expressivo dos ativos intangíveis no exercício, cujo saldo de R$ 1.874.550 mil correspondeu a aproximadamente 25,95% do ativo total consolidado. Essa representatividade, associada à complexidade dos julgamentos relacionados à vida útil, à amortização, à mensuração de ativos provenientes de combinações de negócios e à avaliação de perdas por redução ao valor recuperável, justificou a priorização dessa conta para o desenvolvimento dos procedimentos acadêmicos.

A reconciliação aritmética da movimentação dos ativos intangíveis apresentou diferença igual a zero entre o saldo final calculado e o saldo divulgado. Esse resultado demonstra a consistência matemática dos valores utilizados no procedimento, mas não comprova, isoladamente, a existência, os direitos, a adequada mensuração ou a recuperabilidade dos ativos. Da mesma forma, os testes aplicados à base sintética permitiram demonstrar a implementação de regras de identificação de exceções e avaliar sua capacidade de detecção dentro das condições simuladas, sem produzir evidência sobre os registros contábeis reais da companhia.

O trabalho também permitiu relacionar os riscos identificados aos procedimentos adicionais que poderiam ser realizados em uma auditoria com acesso aos registros analíticos, documentos de suporte, controles internos, contratos e premissas utilizadas pela administração. A matriz de cobertura normativa contribui para organizar a documentação e identificar os temas abordados, devendo ser interpretada em conjunto com os papéis de trabalho e com as limitações metodológicas apresentadas.

Conclui-se, portanto, que os procedimentos desenvolvidos atenderam à finalidade acadêmica de demonstrar etapas de planejamento, avaliação preliminar de riscos, análise documental, reconciliação e aplicação de testes em R. Entretanto, em razão da utilização de informações públicas e de dados sintéticos, não é possível concluir sobre a ausência de distorções relevantes nas demonstrações financeiras da Frasle Mobility S.A., nem emitir opinião independente sobre sua adequação. As conclusões permanecem restritas aos procedimentos efetivamente documentados e às evidências disponíveis para este estudo.

## 14. Referências e fontes consultadas

F01 — Demonstrações financeiras de 2025 da Frasle Mobility S.A.

Comissão de Valores Mobiliários (CVM). Demonstrações Financeiras Padronizadas (DFP), exercício encerrado em 31/12/2025. Documento consultado: sequência 155265.

Link: https://www.rad.cvm.gov.br/ENET/frmGerenciaPaginaFRE.aspx?CodigoTipoInstituicao=1&NumeroSequencialDocumento=155265

Data de acesso registrada: 23/10/2026.

F02 — Relações com Investidores da Frasle Mobility S.A.

Frasle Mobility S.A. Página institucional de Relações com Investidores.

Link: https://ri.fraslemobility.com/

Data de acesso registrada: 23/10/2026.

F03 — Dados abertos de companhias abertas: DFP.

Comissão de Valores Mobiliários (CVM). Conjunto de dados de Demonstrações Financeiras Padronizadas.

Link: https://dados.cvm.gov.br/dataset/cia_aberta-doc-dfp

Data de acesso registrada: 23/10/2026.
