# Dossiê Acadêmico de Auditoria — Frasle Mobility S.A.

**Universidade de Brasília (UnB)**
- **Disciplina:** Auditoria 1 — CCA0024
- **Aluno:** Pedro Henrique De Oliveira Sucupira
- **Matrícula:** 241003375
- **Professor:** Lucas Oliveira Gomes Ferreira
- **Empresa analisada:** Frasle Mobility S.A.
- **Exercício analisado:** 2025

## 1. Apresentação

Este repositório reúne a documentação do trabalho acadêmico desenvolvido para a disciplina Auditoria 1 — CCA0024 — Turma 02 — 2026.2, da Universidade de Brasília (UnB).

O estudo tem como objeto as demonstrações financeiras da Frasle Mobility S.A., referentes ao exercício de 2025, com informações comparativas de 2024. O trabalho apresenta procedimentos analíticos, avaliação preliminar de riscos, reconciliação de saldos e testes demonstrativos desenvolvidos na linguagem R.

## 2. Objetivos

O trabalho busca demonstrar a aplicação de conceitos e procedimentos de auditoria independente, com ênfase em:

- Análise comparativa das demonstrações financeiras;
- Identificação preliminar de riscos de distorção relevante;
- Seleção e análise da conta de ativos intangíveis;
- Reconciliação aritmética da movimentação dos ativos intangíveis;
- Desenvolvimento de testes demonstrativos em R;
- Documentação dos procedimentos em papéis de trabalho;
- Organização da cobertura da Estrutura Conceitual e das NBC TA 200 a 600 consideradas no escopo acadêmico.

## 3. Metodologia

A análise foi desenvolvida com base em informações públicas da companhia, incluindo demonstrações financeiras, notas explicativas e relatório do auditor independente.

Os procedimentos envolveram a comparação de saldos entre os exercícios de 2024 e 2025, a análise de variações patrimoniais, a reconciliação aritmética dos ativos intangíveis e a implementação de regras de identificação de possíveis inconsistências em R.

Também foi elaborada uma base sintética com 500.000 registros e 250 erros inseridos deliberadamente, destinada à demonstração de testes relacionados à vida útil dos ativos, à recuperabilidade e à amortização.

## 4. Estrutura do projeto

O projeto está organizado nas seguintes pastas:

| Pasta | Conteúdo |
|---|---|
| `01_fontes/` | Fontes consultadas e registro de referências |
| `02_papeis_trabalho/` | Relatório técnico e documentação dos procedimentos |
| `03_base_sintetica/` | Base sintética, dicionário de dados e registros dos testes |
| `04_codigo/` | Scripts desenvolvidos em R |
| `05_resultados/` | Tabelas, cálculos e resultados das análises |
| `06_matrizes/` | Matriz de cobertura das normas de auditoria |

O arquivo `README.md` apresenta uma visão geral do projeto e orienta a consulta aos seus principais componentes.

## 5. Principais resultados

A análise identificou crescimento expressivo dos ativos intangíveis em 2025, cujo saldo divulgado foi de R$ 1.874.550 mil. Essa conta representou aproximadamente 25,95% do ativo total consolidado, justificando sua priorização no estudo acadêmico.

A reconciliação aritmética da movimentação dos ativos intangíveis apresentou diferença igual a zero entre o saldo final calculado e o saldo divulgado nas demonstrações financeiras.

Na base sintética, os testes demonstrativos avaliaram regras de detecção de possíveis inconsistências relativas à vida útil, à recuperabilidade e à amortização. Esses resultados se aplicam exclusivamente aos dados simulados e às regras implementadas, não representando conclusões sobre os registros contábeis reais da companhia.

## 6. Limitações

Este projeto possui caráter exclusivamente acadêmico e não constitui uma auditoria independente contratada.

A análise é limitada às informações públicas consultadas e aos procedimentos efetivamente documentados. A base sintética não representa os registros contábeis reais da companhia, e seus resultados não permitem concluir pela existência ou ausência de distorções nas demonstrações financeiras.

Os procedimentos que dependem de documentos internos, confirmações externas, inspeção de contratos ou avaliação aprofundada das estimativas da administração são apresentados como procedimentos complementares propostos, quando aplicáveis.

A matriz normativa tem finalidade de organização e rastreabilidade acadêmica, não representando uma declaração de conformidade integral com todas as exigências das normas de auditoria.

## 7. Fontes de consulta

As principais fontes institucionais utilizadas incluem:

- **Comissão de Valores Mobiliários (CVM):** [Consulta de documentos da companhia](https://www.rad.cvm.gov.br/ENET/frmGerenciaPaginaFRE.aspx?CodigoTipoInstituicao=1&NumeroSequencialDocumento=155265).
- **Relações com Investidores da Frasle Mobility:** [Portal de RI](https://ri.fraslemobility.com/).
- **Dados abertos da CVM:** [Demonstrações Financeiras Padronizadas (DFP)](https://dados.cvm.gov.br/dataset/cia_aberta-doc-dfp).

As datas de acesso e os detalhes das fontes consultadas estão registrados nos arquivos correspondentes do projeto.

## 8. Tecnologias utilizadas

- Linguagem R;
- RStudio;
- Arquivos CSV para organização e análise de dados;
- Markdown para documentação;
- GitHub para versionamento e disponibilização do projeto.

