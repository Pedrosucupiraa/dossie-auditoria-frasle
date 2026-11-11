# Dossiê Acadêmico de Auditoria — Frasle Mobility S.A.

**Universidade de Brasília (UnB)**
* **Disciplina:** Auditoria 1 — CCA0024 (Turma 02 — 2026.2)
* **Aluno:** Pedro Henrique De Oliveira Sucupira
* **Matrícula:** 241003375
* **Professor:** Lucas Oliveira Gomes Ferreira
* **Empresa Analisada:** Frasle Mobility S.A.
* **Exercício Analisado:** 2025

---

## 1. Apresentação

Este repositório reúne a documentação técnica e os scripts automatizados desenvolvidos para a disciplina **Auditoria 1 — CCA0024** da Universidade de Brasília (UnB).

O estudo tem como objeto as demonstrações financeiras consolidadas da **Frasle Mobility S.A.** referentes ao exercício de 2025 (com comparativos de 2024), apresentando procedimentos analíticos substantivos, amostragem estatística formal, análise de sensibilidade de estimativas e a matriz de cobertura integral das 27 atividades normativas da auditoria (NBC TA).

---

## 2. Objetivos

* **Estruturação da Materialidade (NBC TA 320 / 450):** Definir e fundamentar a tripla materialidade com base no Ativo Total como *benchmark* industrial.
* **Amostragem Estatística (NBC TA 530):** Aplicar Amostragem por Unidade Monetária (MUS) sobre a população de ativos intangíveis.
* **Auditoria de Estimativas (NBC TA 540):** Executar análise de sensibilidade determinística (taxa de desconto WACC) sobre o valor recuperável dos ativos intangíveis.
* **Padronização dos Papéis de Trabalho (NBC TA 200 a 600):** Consolidar a documentação dos 27 Papéis de Trabalho (PTs) vinculados a evidências públicas e sintéticas.
* **Reprodutibilidade em R:** Disponibilizar scripts R organizados e sequenciais para geração automática de relatórios, matrizes e cálculos contábeis.

---

## 3. Metodologia

A análise baseou-se nas Demonstrações Financeiras Padronizadas (DFP) de 2025 da Fras-le Mobility S.A. publicadas na CVM.

Os procedimentos integraram:
1. **Definição de Parâmetros Globais:** Fixação da materialidade global (1% do Ativo Total), de execução (75%) e limite de distorções nulas (5%).
2. **Validação de Base Sintética:** Exame automatizado de 500.000 registros de ativos intangíveis (totalizando R$ 1.874.550 mil) com reconciliação perfeita às DFPs.
3. **Execução Numérica de Testes Estatísticos:** Aplicação da amostragem MUS com 95% de confiança ($n = 104$) e estressamento da taxa WACC ($9,5\%$ a $16,5\%$).
4. **Rastreabilidade Documental:** Mapeamento de 100% das 27 atividades da NBC TA em arquivos CSV individuais e matriz unificada de cobertura.

---

## 4. Estrutura do Projeto

dossie-auditoria-frasle/

├── 01_fontes/               # DFPs públicas, notas explicativas e registro de fontes

├── 02_papeis_trabalho/      # 27 Papéis de Trabalho em CSV/TXT (PT-EC a PT-600)

├── 03_base_sintetica/       # Base individualizada de 500k registros do intangível

├── 04_codigo/               # Scripts R automatizados para cálculos e matrizes

├── 05_resultados/           # Resultados de materialidade, sensibilidade WACC e amostragem MUS

└── 06_matrizes/             # Matriz consolidada de cobertura das 27 normas NBC TA

## 5. Ordem de execução para reprodutibilidade (RScript)
Para reexecutar todo o dossiê e gerar automaticamente os resultados, tabelas e relatórios, execute a seguinte sequência no console do RStudio:
* ### 1. Recalcula os parâmetros de materialidade (PT 320)
source("04_codigo/41_calculo_materialidade.R")

* ### 2. Executa a amostragem MUS (PT 530) e a sensibilidade do WACC (PT 540)
source("04_codigo/18_atualizar_pt02_impairment.R")

* ### 3. Consolida a matriz de cobertura e gera os 27 PTs individuais em CSV
source("04_codigo/14_matriz_cobertura_normas.R")

* ### 4. Recompila o relatório técnico final e atualiza a documentação
source("04_codigo/39_gerar_relatorio_tecnico.R")

## 6. Principais resultados e parâmetros da auditoria
### Triângulo da Materialidade (NBC TA 320 / NBC TA 450)
 **Base de Referência (Benchmark):** Ativo Total 2025 — R$ 7.222.660,00 mil (escolhido por refletir a estrutura de capital intensivo da companhia e a estabilidade patrimonial).

* **Materialidade Global (M):** R$ 72.226,60 mil (1,0% do Ativo Total).

* **Materialidade de Execução (ME):** R$ 54.169,95 mil (75,0% da Materialidade Global).

* **Limite para Distorções Irrelevantes (LDI):** R$ 3.611,33 mil (5,0% da Materialidade Global).

* **Materialidade Específica do Intangível:** R$ 18.745,50 mil (1,0% do saldo do Intangível).
 
### Amostragem por Unidade Monetária (MUS — NBC TA 530)
* **Tamanho Amostral (n):** 104 itens monetários (Nível de confiança de 95%, Fator de Poisson = 3,0, Intervalo J = R$ 18.056,65 mil).

* **Resultado:** Projeção linear de distorção igual a R$ 0,00, confirmando a razoabilidade do saldo populacional de R$ 1.874.550 mil.

### Análise de Sensibilidade de Imparidade (NBC TA 540)
* **Valor Recuperável Base (WACC 11,5% / g 3,0%):** R$ 2.941.176,47 mil (excede o valor contábil em 56,9%).

* **Ponto de Ruptura (Break-even):** A necessidade de impairment surge apenas em cenários com WACC a partir de 16,5% (+5,0% acima do cenário base).

### 7. Cobertura normativa dos 27 papéis de trabalho
Os 27 Papéis de Trabalho encontram-se integralmente executados, indexados e vinculados aos respectivos arquivos de suporte em 02_papeis_trabalho/ e 06_matrizes/matriz_cobertura_normas.csv:

* **Estrutura Conceitual & Geral:** PT-EC, PT-200, PT-210, PT-220, PT-230.

* **Riscos, Fraude e Governança:** PT-240, PT-250, PT-260, PT-265.

* **Planejamento e Materialidade:** PT-300, PT-315, PT-320, PT-330.

* **Organizações de Serviços & Distorções:** PT-402, PT-450.

* **Evidências e Procedimentos Substantivos:** PT-500, PT-501, PT-505, PT-510, PT-520, PT-530, PT-540, PT-550.

* **Conclusão e Relatório de Grupo:** PT-560, PT-570, PT-580, PT-600.

### 8. Limitações
Este trabalho possui caráter estritamente acadêmico para a disciplina Auditoria 1 (UnB) e não substitui um relatório de auditoria independente emitido nos termos das normas profissionais do CFC/CBRACON. Os testes efetuados sobre a base sintética aplicam-se exclusivamente às simulações desenvolvidas para fins didáticos.

### 9. Fontes de consulta
* **Comissão de Valores Mobiliários (CVM):** DFP Fras-le Mobility S.A. 2025

* **Portal de RI Fras-le:** Demonstrações Financeiras 2025

* **Conselho Federal de Contabilidade (CFC):** Normas Brasileiras de Contabilidade Técnica de Auditoria (NBC TA 200 a 600).

### 10. Tecnologias utilizadas
* **Linguagem R & RStudio:** Automação estatística e geração de dados.

* **Arquivos CSV / TXT:** Estruturação de papéis de trabalho e matrizes.

* **Markdown & Git / GitHub:** Documentação técnica e controle de versão. 
