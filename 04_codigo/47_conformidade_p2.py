# 04_codigo/47_conformidade_p2.py
# Gera, a partir da DFP 2025 da Frasle Mobility S.A. e dos resultados já existentes em 05_resultados/,
# os itens exigidos pelas instruções do P2:
#   - 02_papeis_trabalho/roteiro/PT-<codigo>.md  (27 PTs: EC, 200 ... 600) + roteiro_pts_consolidado.csv
#   - 01_fontes/registro_fontes.csv (endereço, data de acesso, documento, página, exercício)
#   - 06_matrizes/matriz_cobertura_normas.csv (27 linhas, versões das normas, natureza oficial)
#   - 06_matrizes/matrizes_risco_resposta_distorcao_deficiencia.csv
#   - 07_programas_auditoria/ (6 programas) e 08_minutas/ (4 minutas, nenhuma enviada)
#   - 09_conclusao_integrada.md (sem opinião)
#   - remapeia a coluna Natureza dos PTs legados para as 3 classes oficiais (com log; original preservado)
# Uso (a partir da raiz do repositório):  python3 04_codigo/47_conformidade_p2.py
import csv, os, glob, re

MAT = "241003375"
DATA = "2026-11-13"
REV = "Pendente de revisão — não assinado; campo reservado ao revisor (sem simulação de assinatura)"
RLZ, PLN, SIM = ("Realizado com evidência pública", "Planejado por falta de acesso", "Simulado para fins didáticos")
DFP = "01_fontes/155265_006211_20102026101023.pdf"
LIM = ("Trabalho acadêmico baseado em informações públicas e em base sintética; sem acesso à companhia, "
       "sem contato com terceiros e sem opinião de auditoria.")

def w(path, txt):
    if os.path.dirname(path): os.makedirs(os.path.dirname(path), exist_ok=True)
    open(path, "w", encoding="utf-8").write(txt)

def wcsv(path, header, rows):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8", newline="") as f:
        cw = csv.writer(f, quoting=csv.QUOTE_NONNUMERIC)
        cw.writerow(header); cw.writerows(rows)

# ------------------------------------------------------------------ fontes
FONTES = [
 ("F01","DFP 2025 — Demonstrações Financeiras Padronizadas, Frasle Mobility S.A. (PDF, 137 páginas)",
  "https://www.rad.cvm.gov.br/ENET/frmGerenciaPaginaFRE.aspx?CodigoTipoInstituicao=1&NumeroSequencialDocumento=155265",
  "23/10/2026","Balanço p.20-21; DRE p.23; Nota 1 p.66; Nota 10 p.76; Nota 11 p.78; Nota 13 p.80; Nota 17 p.91; Nota 18 p.95-98; Nota 21-22 p.103-104; Nota 23 e covenants p.106-107; relatório do auditor p.131-134",
  "2025 (comparativo 2024)","Fatos e saldos consolidados de todos os PTs","Arquivo local: "+DFP+" (nome do arquivo apenas)"),
 ("F02","Relações com Investidores — Frasle Mobility","https://ri.fraslemobility.com/","23/10/2026","página inicial","2025","Confirmação do canal oficial de divulgação","Não foi usada como fonte de números"),
 ("F03","Dados abertos CVM — DFP de companhias abertas","https://dados.cvm.gov.br/dataset/cia_aberta-doc-dfp","23/10/2026","conjunto de dados","2025","Conferência da existência e do protocolo da DFP","Não foi usada como fonte de números"),
 ("F04","NBC TA e Estrutura Conceitual — lista de normas e versões (CFC)","https://cfc.org.br/tecnica/normas-brasileiras-de-contabilidade/nbc-ta-de-auditoria-independente/",
  "11/11/2026","página única","vigentes em 2026","Versões das normas na matriz de cobertura","Consulta da lista de normas; texto integral de cada norma não foi reproduzido"),
 ("F05","Relatório do auditor independente (KPMG Auditores Independentes S.S.) — parte da DFP","https://www.rad.cvm.gov.br/ENET/frmGerenciaPaginaFRE.aspx?CodigoTipoInstituicao=1&NumeroSequencialDocumento=155265",
  "23/10/2026","p.131-134","2025","Opinião do auditor da companhia, PAA/KAM (combinação de negócios Dacomsa), data do relatório 11/03/2026","Opinião da KPMG sobre a companhia; NÃO é opinião deste trabalho"),
]
wcsv("01_fontes/registro_fontes.csv",
     ["id_fonte","documento","endereco_eletronico","data_acesso","pagina","exercicio","uso","observacao"], FONTES)

# ------------------------------------------------------------------ fatos DFP (R$ mil, consolidado)
F = dict(ativo=7222660, intang25=1874550, intang24=586859, imob=1450996, est25=1443447, est24=1054752,
         caixa=1316248, cr=498441, rol25=5490878, rol24=3965776, ll25=283166, ll24=374703,
         pest25=89545, pest24=30861, pcld25=22321, pcld24=9330, lit25=139790, lit24=110506,
         dv=2495961, ebitda_lim="3,50x")
def pct(a,b): return f"{(a/b-1)*100:+.1f}%".replace(".",",")
def n(x): return f"{x:,.0f}".replace(",",".")

# ------------------------------------------------------------------ PTs do roteiro
# (cod, titulo, norma+versão, itens, natureza, objetivo, conta, afirmacoes, populacao/fontes/criterios,
#  procedimentos, evidencias, resultados, excecoes, conclusao, limitacoes, apoio)
P = []
def pt(**k): P.append(k)

pt(cod="EC", titulo="Estrutura Conceitual para Trabalhos de Asseguração", norma="Estrutura Conceitual (Res. CFC 1.202/09, DOU 25/11/2015)", versao="DOU 25/11/2015",
   itens="Elementos do trabalho de asseguração; asseguração razoável × limitada", natureza=RLZ,
   objetivo="Caracterizar o trabalho como asseguração: usuários, objeto, critérios, responsabilidades e nível de asseguração, sem emitir opinião.",
   conta="Demonstrações financeiras consolidadas e individuais da Frasle Mobility S.A. em 31/12/2025.",
   afir="Não se aplica por afirmação; riscos de enquadramento: confundir o trabalho acadêmico com asseguração real.",
   fontes="F01 (Nota 2 – base de elaboração; Nota 1 – entidade, p.66); F05. Critério: práticas contábeis adotadas no Brasil e IFRS (conforme DFP).",
   proc=["Identificar as partes (responsável: administração; profissional: auditor da companhia, KPMG; usuários: acionistas, B3, credores).",
         "Identificar objeto e critério aplicáveis (DFP 2025; CPC/IFRS).","Registrar que o presente trabalho NÃO é asseguração: sem contratação, sem acesso, sem opinião."],
   evid=["F01 p.66 (Nota 1) e Nota 2","F05 p.131-134","Legado: 02_papeis_trabalho/PT22_estrutura_conceitual.csv"],
   result="Elementos da asseguração mapeados; a asseguração razoável é a da KPMG sobre a companhia, não a deste dossiê.",
   exc="Nenhuma.", concl="Enquadramento documentado. Nenhuma opinião é emitida neste dossiê.", apoio=["PT22_estrutura_conceitual.csv"])

pt(cod="200", titulo="Objetivos gerais do auditor e condução conforme normas", norma="NBC TA 200 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 5–11 (ética, ceticismo, julgamento); §§ 17–20 (segurança razoável); §§ A1–A56", natureza=RLZ,
   objetivo="Registrar como ética, independência, ceticismo e julgamento orientam o dossiê e delimitar a segurança razoável.",
   conta="Trabalho como um todo; relatório do auditor da companhia como referência.",
   afir="Riscos: conclusão sem ceticismo; uso de dado sintético como se fosse evidência da companhia.",
   fontes="F01 p.131-134 (responsabilidades do auditor); F04 (versões).",
   proc=["Ler as responsabilidades do auditor no relatório KPMG como referência de linguagem.","Declarar independência: o estudante não tem vínculo com a companhia (declaração do próprio aluno, sem verificação externa).",
         "Marcar toda saída sintética como 'SINTÉTICO' e toda evidência pública com fonte e página."],
   evid=["F05 p.131-134","Legado: PT18_objetivos_auditor.csv","03_base_sintetica/ coluna origem_dado"],
   result="Ceticismo aplicado na separação entre evidência pública, planejado e simulado (coluna Natureza).",
   exc="Nenhuma.", concl="Condução acadêmica compatível com a finalidade; sem segurança razoável real.", apoio=["PT18_objetivos_auditor.csv"])

pt(cod="210", titulo="Concordância com os termos do trabalho", norma="NBC TA 210 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 9–12 (acordo); § 10 (carta de contratação)", natureza=PLN,
   objetivo="Preparar a minuta de carta de contratação como exercício; não há cliente nem assinatura.",
   conta="Termos do trabalho (escopo, responsabilidades, estrutura).",
   afir="Riscos: pré-condições não satisfeitas; mal-entendido sobre responsabilidades.",
   fontes="Sem acesso à administração. Critério: NBC TA 210 §§ 6–12.",
   proc=["Redigir minuta de carta (08_minutas/minuta_carta_contratacao.md), marcada 'NÃO ENVIADA'.","Checar pré-condições (estrutura de relatório financeiro aceitável, responsabilidades da administração) com base na DFP."],
   evid=["08_minutas/minuta_carta_contratacao.md","Legado: PT19_termos_trabalho.csv"],
   result="Minuta pronta; nenhuma carta foi enviada ou assinada.", exc="Não aplicável.", concl="Planejado: execução depende de cliente e de contratação.", apoio=["PT19_termos_trabalho.csv"])

pt(cod="220", titulo="Gestão da qualidade da auditoria", norma="NBC TA 220 (R3)", versao="R3 — 09/12/2021",
   itens="§§ 13–25 (responsabilidades do sócio e da equipe)", natureza=PLN,
   objetivo="Descrever como a qualidade seria gerida; não há firma, equipe ou revisor.",
   conta="Trabalho como um todo.", afir="Riscos: ausência de revisão independente; trabalho individual.",
   fontes="Sem acesso a sistema de gestão da qualidade. Critério: NBC TA 220 (R3) e NBC PA 01.",
   proc=["Registrar que o trabalho é individual e que o campo de revisão permanece 'pendente'.","Planejar revisão por pares/orientador como controle compensatório."],
   evid=["Legado: PT23_gestao_qualidade.csv"], result="Sem revisão executada.", exc="Não aplicável.",
   concl="Planejado; revisão fica a cargo do docente.", apoio=["PT23_gestao_qualidade.csv"])

pt(cod="230", titulo="Documentação de auditoria", norma="NBC TA 230 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 7–12 (forma, conteúdo e extensão); § 14 (dossiê final)", natureza=RLZ,
   objetivo="Demonstrar que a documentação permite a outro auditor reperformar e entender o trabalho (código, fontes, base, log).",
   conta="Repositório do trabalho.", afir="Riscos: resultados não reproduzíveis; evidência sem fonte.",
   fontes="Repositório (01_fontes … 09_conclusao_integrada.md); registro_fontes.csv.",
   proc=["Verificar que cada PT cita fonte e página.","Conferir a existência dos arquivos citados (04_codigo/48_verificacao_p2.py).","Manter a identificação do preparador (matrícula) e data."],
   evid=["06_matrizes/indice_papeis_trabalho.csv","04_codigo/48_verificacao_p2.py","Legado: PT_230.csv"],
   result="Verificação automática registra OK/FALTA por item.", exc="Ver resultado de 48_verificacao_p2.py.", concl="Documentação rastreável; limitações declaradas.", apoio=["PT_230.csv"])

pt(cod="240", titulo="Responsabilidades do auditor em relação a fraude", norma="NBC TA 240 (R1) — versão aplicável ao exercício de 2025", versao="R1 (aplicada a 2025). A R2, DOU 25/09/2026, só vale para períodos iniciados em ou após 01/01/2027",
   itens="§§ 25–27 (discussão da equipe e riscos de fraude); §§ 31–33 (lançamentos manuais, estimativas)", natureza=SIM,
   objetivo="Avaliar fatores de risco de fraude e simular testes de lançamentos atípicos sobre a base sintética do intangível.",
   conta="Intangível (R$ "+n(F['intang25'])+" mil) — maior conta do ativo não circulante com estimativas.",
   afir="Existência, valorização e alocação; riscos: capitalização indevida, vida útil/impairment manipulados, ágio sem suporte.",
   fontes="DFP Nota 18 (p.95-98); base sintética (500.000 registros, origem_dado='SINTETICO - NAO E DADO REAL DA FRASLE'); log_erros_inseridos.csv.",
   proc=["Mapear fatores de risco de fraude (incentivo: covenant dívida líquida/EBITDA ≤ 3,50x; oportunidade: estimativas de impairment e vida útil).","Rodar testes T-vida útil, T-amortização e T-impairment na base sintética.","Comparar erros inseridos × detectados."],
   evid=["05_resultados/comparacao_erros_teste.csv","03_base_sintetica/log_erros_inseridos.csv","Legado: PT07_riscos_fraude.csv"],
   result="250 erros inseridos; vida útil 55/79, impairment 86/86, amortização 57/85 detectados (ver PT 530).", exc="52 erros indetectáveis pelo desenho dos testes (todos em Goodwill).",
   concl="Teste válido apenas para a simulação; não há conclusão sobre fraude na companhia. Cuidado: testes desenhados a partir dos erros inseridos são circulares.", apoio=["PT07_riscos_fraude.csv"])

pt(cod="250", titulo="Leis e regulamentos", norma="NBC TA 250 (R1)", versao="R1 — 14/02/2019",
   itens="§§ 13–18 (procedimentos); §§ 19–22 (comunicação)", natureza=RLZ,
   objetivo="Identificar a exposição a leis e regulamentos com efeito direto/indireto nas demonstrações a partir da Nota 22.",
   conta="Provisão para litígios (consolidado R$ "+n(F['lit25'])+" mil; 2024: R$ "+n(F['lit24'])+" mil, "+pct(F['lit25'],F['lit24'])+").",
   afir="Completude e apresentação de provisões; riscos: litígios trabalhistas e tributários subavaliados.",
   fontes="F01 Nota 22 p.103-104: trabalhistas 87.750; tributárias 46.700; cíveis 5.340; ações rescisórias Sorocaba 7.580 e Nakata 37.146.",
   proc=["Ler a Nota 22 e identificar categorias e processos relevantes.","Comparar 2025 × 2024 por categoria.","Planejar: carta de advogados e atas (não solicitadas)."],
   evid=["F01 p.103-104","Legado: PT11_leis_regulamentos.csv"],
   result="Provisão cresceu "+pct(F['lit25'],F['lit24'])+"; as ações rescisórias de Nakata (R$ 37.146 mil) concentram a provisão tributária.",
   exc="Sem acesso a processos; não foi possível avaliar probabilidade de perda.", concl="Exposição identificada; avaliação da completude depende de acesso (planejado).", apoio=["PT11_leis_regulamentos.csv"])

pt(cod="260", titulo="Comunicação com os responsáveis pela governança", norma="NBC TA 260 (R2)", versao="R2 — DOU 04/07/2016",
   itens="§§ 14–17 (assuntos a comunicar); § 20 (processo)", natureza=PLN,
   objetivo="Preparar minuta de comunicação à governança (nada enviado).",
   conta="Governança (Conselho de Administração; Nível 1 da B3 — Nota 1, p.66).",
   afir="Riscos: assuntos significativos não comunicados.", fontes="F01 Nota 1; sem acesso a comitê de auditoria.",
   proc=["Redigir minuta com assuntos: escopo, riscos significativos, deficiências, independência (08_minutas/minuta_comunicacao_governanca.md)."],
   evid=["08_minutas/minuta_comunicacao_governanca.md","Legado: PT12_comunicacao_governanca.csv"],
   result="Minuta pronta; nada foi enviado.", exc="Não aplicável.", concl="Planejado.", apoio=["PT12_comunicacao_governanca.csv"])

pt(cod="265", titulo="Comunicação de deficiências de controle interno", norma="NBC TA 265", versao="Res. CFC 1.210/09",
   itens="§§ 8–10 (deficiência significativa); § 11 (comunicação por escrito)", natureza=SIM,
   objetivo="Montar a matriz de deficiências hipotéticas decorrentes dos testes na base sintética.",
   conta="Processo de contabilização do intangível.", afir="Riscos: controle de amortização/vida útil falho.",
   fontes="Base sintética e 06_matrizes/matrizes_risco_resposta_distorcao_deficiencia.csv (bloco 'deficiencia').",
   proc=["Classificar padrões de erro (vida útil, amortização, impairment) como deficiências hipotéticas.","Avaliar gravidade apenas como exercício."],
   evid=["06_matrizes/matrizes_risco_resposta_distorcao_deficiencia.csv","Legado: PT13_deficiencias_controles.csv"],
   result="3 deficiências hipotéticas registradas; nenhuma é afirmação sobre os controles reais da Frasle.", exc="Controles reais não foram testados.",
   concl="Simulado; não comunicar à companhia.", apoio=["PT13_deficiencias_controles.csv"])

pt(cod="300", titulo="Planejamento da auditoria", norma="NBC TA 300 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 7–11 (atividades); § 12 (estratégia); § 13 (plano)", natureza=RLZ,
   objetivo="Definir estratégia: escopo (consolidado 2025), conta-alvo (Intangível), riscos, materialidade e cronograma.",
   conta="Demonstrações consolidadas 2025.", afir="Todas, com ênfase em valorização/alocação do intangível.",
   fontes="F01 balanço p.20-21; KAM p.132; Nota 18.",
   proc=["Escolher a maior conta do ativo: Intangível R$ "+n(F['intang25'])+" mil > Imobilizado "+n(F['imob'])+" > Estoques "+n(F['est25'])+" (justificativa também em PT 320).","Registrar crescimento de "+pct(F['intang25'],F['intang24'])+" (combinações Dacomsa, TF Victor, Moresa).","Montar cronograma e ligar riscos às respostas (PT 315 → PT 330)."],
   evid=["05_resultados/comparacao_intangivel_2024_2025.csv","Legado: PT_300.csv, PT06_auditoria_intangivel.csv"],
   result="Plano e escolha da conta justificados.", exc="Nenhuma.", concl="Estratégia documentada.", apoio=["PT_300.csv","PT06_auditoria_intangivel.csv"])

pt(cod="315", titulo="Identificação e avaliação dos riscos de distorção relevante", norma="NBC TA 315 (R2)", versao="R2 — 02/09/2021",
   itens="§§ 19–27 (entendimento); §§ 28–35 (avaliação de riscos)", natureza=RLZ,
   objetivo="Montar a matriz de riscos por conta e afirmação com base na DFP.",
   conta="Intangível, Estoques, Contas a receber, Provisões, Empréstimos.",
   afir="Ver matriz (bloco 'risco'). Risco significativo: valorização do intangível adquirido (KAM da KPMG).",
   fontes="F01 Notas 6, 10, 11, 18, 22, 23; KAM p.132.",
   proc=["Entender entidade, ambiente e estrutura contábil a partir da DFP.","Avaliar risco inerente por conta (alto/médio/baixo) sem avaliar controles (sem acesso).","Registrar riscos significativos."],
   evid=["06_matrizes/matrizes_risco_resposta_distorcao_deficiencia.csv","Legado: PT_315.csv"],
   result="Riscos significativos: (1) valor justo de intangíveis adquiridos; (2) impairment de ágio; (3) provisão para perdas com estoques ("+pct(F['pest25'],F['pest24'])+" de variação).", exc="Controles e TI não avaliados.",
   concl="Matriz de risco inerente concluída; risco de controle não avaliado.", apoio=["PT_315.csv"])

pt(cod="320", titulo="Materialidade no planejamento e na execução", norma="NBC TA 320 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 10–11 (determinação); § 11 (execução); § A3–A12 (referenciais)", natureza=RLZ,
   objetivo="Determinar materialidade global, de execução e limite de distorções irrelevantes, com triangulação.",
   conta="Demonstrações consolidadas.", afir="Não se aplica.",
   fontes="F01: ativo total R$ "+n(F['ativo'])+" mil; receita líquida R$ "+n(F['rol25'])+" mil; lucro antes dos tributos R$ 320.897 mil.",
   proc=["Global = 1,0% do ativo total = R$ 72.227 mil (escolha original do aluno).","Triangulação: 0,5% da ROL = R$ "+n(F['rol25']*0.005)+" mil; 5% do lucro antes dos tributos = R$ 16.045 mil.","Execução = 75% da global; limite de irrelevantes = 5% da global.","Conta-alvo: Intangível, por ser a maior conta do ativo não circulante."],
   evid=["05_resultados/calculo_materialidade.csv","05_resultados/comparacao_referenciais_materialidade.csv","05_resultados/planilhas_editaveis_p2.xlsx (fórmulas editáveis)","Legado: PT32_materialidade.csv"],
   result="Global R$ 72.227 mil; execução R$ 54.170 mil; irrelevantes R$ 3.611 mil.", exc="A global adotada (1% do ativo = R$ 72.227 mil) é 2,6x a de 0,5% da ROL (R$ 27.454 mil) e 4,5x a de 5% do lucro antes dos tributos (R$ 16.045 mil): é a mais alta da triangulação, logo a menos sensível a distorções — ponto para revisão do docente.",
   concl="Decisão (13/11/2026): mantido 1% do ativo total como materialidade global, com a limitação acima registrada. Materialidade fixada por julgamento acadêmico e sensível ao referencial; revisão pendente.", apoio=["PT32_materialidade.csv"])

pt(cod="330", titulo="Respostas do auditor aos riscos avaliados", norma="NBC TA 330 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 5–6 (respostas gerais); §§ 6–21 (procedimentos adicionais)", natureza=SIM,
   objetivo="Ligar cada risco da matriz a um procedimento; executar os executáveis sobre a base sintética.",
   conta="Intangível (base sintética) e demais contas (planejado).", afir="Valorização, existência, alocação.",
   fontes="Base sintética; DFP.", proc=["Para cada risco da PT 315, definir resposta (matriz bloco 'resposta').","Executar testes de detalhe (MUS) e analíticos sobre a base sintética.","Documentar o que ficou planejado."],
   evid=["06_matrizes/matrizes_risco_resposta_distorcao_deficiencia.csv","05_resultados/mus_amostra_selecionada.csv","Legado: PT_330.csv"],
   result="Respostas executadas na simulação; demais planejadas.", exc="Ver PT 450.", concl="Simulado.", apoio=["PT_330.csv","PT15_itens_selecionados.csv"])

pt(cod="402", titulo="Entidade que utiliza organização prestadora de serviços", norma="NBC TA 402", versao="Res. CFC 1.215/09",
   itens="§§ 9–14 (entendimento e avaliação); relatórios tipo 1 e 2", natureza=PLN,
   objetivo="Avaliar se há terceirização relevante e planejar a obtenção de relatórios SOC.",
   conta="Processos terceirizados (ex.: operações de risco sacado – Nota 21, R$ 7.532 mil consolidado).", afir="Riscos: controles do prestador fora do alcance.",
   fontes="F01 Nota 21 p.103; sem acesso a contratos.", proc=["Identificar terceirizações a partir da DFP.","Planejar solicitação de relatórios do prestador (não enviada)."],
   evid=["F01 p.103","Legado: PT20_organizacoes_servicos.csv"], result="Sem informação pública suficiente.", exc="Não aplicável.", concl="Planejado.", apoio=["PT20_organizacoes_servicos.csv"])

pt(cod="450", titulo="Avaliação das distorções identificadas", norma="NBC TA 450 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 5–11 (acumulação, comunicação, avaliação)", natureza=SIM,
   objetivo="Acumular distorções da simulação (MUS) e compará-las à materialidade.",
   conta="Intangível (base sintética).", afir="Valorização e alocação.",
   fontes="05_resultados/amostragem_mus_projecao.csv; materialidade PT 320.", proc=["Somar distorções da amostra MUS e projetar (Stringer).","Comparar com materialidade de execução.","Registrar o mapa de distorções (matriz bloco 'distorcao')."],
   evid=["05_resultados/amostragem_mus_projecao.csv","06_matrizes/matrizes_risco_resposta_distorcao_deficiencia.csv","Legado: PT_450.csv"],
   result="MUS: 0 erros na amostra de 104 seleções; limite superior de Stringer R$ 54.092,89 mil, abaixo da materialidade de execução (R$ 54.169,95 mil) por margem mínima.", exc="Mesmo com 250 erros inseridos na base, a amostra não os encontrou: o MUS não é sensível a erros dispersos e de baixo valor; 52 erros são indetectáveis por desenho (Goodwill).", concl="Simulado.", apoio=["PT_450.csv"])

pt(cod="500", titulo="Evidência de auditoria", norma="NBC TA 500 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 6–11 (suficiência e adequação); § A31 (confiabilidade)", natureza=RLZ,
   objetivo="Avaliar a qualidade das evidências usadas (DFP × sintética).",
   conta="Todas as evidências do dossiê.", afir="Não se aplica.", fontes="F01; base sintética.",
   proc=["Classificar cada evidência: externa (CVM/KPMG), interna da companhia (ausente), gerada pelo aluno (sintética).","Avaliar relevância e confiabilidade."],
   evid=["06_matrizes/matrizes_risco_resposta_distorcao_deficiencia.csv (bloco 'evidencia')","Legado: PT_500.csv"],
   result="DFP auditada pela KPMG = alta confiabilidade; base sintética = nenhuma como evidência da companhia.", exc="Nenhuma.", concl="Evidências adequadas somente ao propósito acadêmico.", apoio=["PT_500.csv"])

pt(cod="501", titulo="Evidência para itens específicos (estoques, litígios, segmentos)", norma="NBC TA 501", versao="Res. CFC 1.218/09",
   itens="§§ 4–8 (inventário físico); §§ 9–12 (litígios); § 13 (segmentos)", natureza=RLZ,
   objetivo="Analisar estoques (Nota 11), litígios (Nota 22) e segmentos (Nota 7) a partir da DFP.",
   conta="Estoques R$ "+n(F['est25'])+" mil; provisão para perdas R$ "+n(F['pest25'])+" mil; litígios R$ "+n(F['lit25'])+" mil.",
   afir="Existência e valorização (estoques); completude (litígios).", fontes="F01 Nota 11 p.78; Nota 22 p.103-104; Nota 7 p.74.",
   proc=["Provisão/bruto: 2025 = "+f"{F['pest25']/(F['est25']+F['pest25'])*100:.2f}".replace(".",",")+"%; 2024 = "+f"{F['pest24']/(F['est24']+F['pest24'])*100:.2f}".replace(".",",")+"%.","Estoques "+pct(F['est25'],F['est24'])+"; provisão "+pct(F['pest25'],F['pest24'])+".","Planejar acompanhamento de inventário e carta de advogados (não executados)."],
   evid=["F01 p.78","F01 p.103-104","programa 07_programas_auditoria/programa_estoques.md"],
   result="Provisão quase triplicou; metodologia por rotatividade de 12 meses (Nota 11).", exc="Inventário físico não acompanhado; sem carta de advogados.", concl="Análise documental; testes físicos ficam planejados.", apoio=[])

pt(cod="505", titulo="Confirmações externas", norma="NBC TA 505", versao="Res. CFC 1.219/09",
   itens="§§ 7–14 (procedimentos); § 15 (não resposta)", natureza=PLN,
   objetivo="Preparar modelo e controle de confirmações; NENHUMA foi enviada.",
   conta="Contas a receber R$ "+n(F['cr'])+" mil; empréstimos; caixa R$ "+n(F['caixa'])+" mil.", afir="Existência; direitos e obrigações.",
   fontes="F01 Nota 10 p.76; Nota 23 p.106; sem acesso a clientes/bancos.", proc=["Redigir modelo (08_minutas/modelo_confirmacao_externa.md).","Montar o controle de circularização com status 'NÃO ENVIADA'."],
   evid=["08_minutas/modelo_confirmacao_externa.md","Legado: PT16_confirmacoes_externas.csv"], result="Controle: 0 enviadas, 0 recebidas.", exc="Não aplicável.", concl="Planejado; não contatar terceiros.", apoio=["PT16_confirmacoes_externas.csv"])

pt(cod="510", titulo="Trabalho inicial — saldos de abertura", norma="NBC TA 510 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 6–9 (saldos iniciais)", natureza=RLZ,
   objetivo="Verificar a coerência entre saldo de abertura 2025 e comparativo 2024 do intangível.",
   conta="Intangível — saldo inicial R$ "+n(F['intang24'])+" mil.", afir="Existência, valorização.", fontes="F01 balanço p.20-21; Nota 18.",
   proc=["Reconciliar saldo inicial + movimentação = saldo final (586.859 + 1.287.691 = 1.874.550; diferença 0).","Não foi verificado nesta etapa quem auditou o comparativo 2024 nem se houve ressalva."],
   evid=["05_resultados/reconciliacao_intangivel_revisada.csv","Legado: PT14_saldos_iniciais.csv"], result="Reconciliação fecha em zero.", exc="Nenhuma.", concl="Saldo de abertura coerente com o comparativo publicado.", apoio=["PT14_saldos_iniciais.csv"])

pt(cod="520", titulo="Procedimentos analíticos", norma="NBC TA 520", versao="Res. CFC 1.221/09",
   itens="§§ 5–7 (substantivos); § 6 (investigação); § 7 (final)", natureza=RLZ,
   objetivo="Calcular variações 2025 × 2024 e investigar as relevantes.",
   conta="Demonstrações consolidadas.", afir="Valorização, completude.", fontes="F01 p.20-23, Notas 10, 11, 18, 22.",
   proc=["Receita líquida "+pct(F['rol25'],F['rol24'])+"; intangível "+pct(F['intang25'],F['intang24'])+"; estoques "+pct(F['est25'],F['est24'])+"; PCLD "+pct(F['pcld25'],F['pcld24'])+"; litígios "+pct(F['lit25'],F['lit24'])+"; lucro líquido "+pct(F['ll25'],F['ll24'])+".","Investigar: crescimento por aquisições (Dacomsa etc.) explica receita e intangível; queda do lucro frente à receita exige análise de despesas."],
   evid=["05_resultados/analise_procedimentos_analiticos.csv","05_resultados/comparacao_intangivel_2024_2025.csv","Legado: PT17_procedimentos_analiticos.csv"],
   result="Variações altas coerentes com combinações de negócios, mas não demonstradas sem acesso aos contratos.", exc="Explicação do lucro não verificada.", concl="Indícios, não conclusão.", apoio=["PT17_procedimentos_analiticos.csv"])

pt(cod="530", titulo="Amostragem em auditoria", norma="NBC TA 530", versao="Res. CFC 1.222/09",
   itens="§§ 6–8 (planejamento); §§ 14–15 (projeção); §§ 12–13 (distorções)", natureza=SIM,
   objetivo="Aplicar MUS na base sintética de 500.000 registros e comparar erros inseridos × detectados.",
   conta="Intangível sintético (reconciliado a R$ "+n(F['intang25'])+" mil).", afir="Valorização, existência.",
   fontes="03_base_sintetica/base_sintetica_intangivel.csv; semente 241003375.", proc=["MUS com 104 seleções (J = R$ 18.056,65 mil); limite superior de Stringer.","Comparar com o log de erros inseridos (250) — os testes de razoabilidade (não o MUS) detectaram 198."],
   evid=["05_resultados/amostragem_mus_projecao.csv","05_resultados/comparacao_erros_teste.csv","05_resultados/sensibilidade_mus_editavel.xlsx","Legado: PT_530.csv"],
   result="Detecção por tipo: vida útil 55/79; impairment 86/86; amortização 57/85.", exc="52 erros indetectados (Goodwill): erros coerentes entre si não são vistos por teste de razoabilidade.",
   concl="Simulado; a circularidade (testes desenhados para os erros inseridos) limita a generalização.", apoio=["PT_530.csv"])

pt(cod="540", titulo="Estimativas contábeis e divulgações relacionadas", norma="NBC TA 540 (R2)", versao="R2 — 23/10/2019",
   itens="§§ 13–15 (riscos); §§ 18–20 (respostas); § 23 (indicadores de viés)", natureza=SIM,
   objetivo="Avaliar estimativas relevantes: impairment de ágio/intangíveis, provisão de estoques, PCLD, litígios e valor justo (Dacomsa).",
   conta="Intangível, estoques, contas a receber, litígios.", afir="Valorização.", fontes="F01 Notas 11, 18, 22; KAM p.132; DCF hipotético (premissas FC 250.000, WACC 11,5%, g 3%) — SIMULADO.",
   proc=["Listar estimativas e grau de incerteza.","Sensibilidade do impairment (DCF hipotético) — premissas do aluno, não da companhia.","Comparar provisões 2025 × 2024 (indicador de viés)."],
   evid=["05_resultados/analise_sensibilidade_impairment.csv","05_resultados/analise_sensibilidade_ponto_ruptura.csv","Legado: PT02_nota16_impairment.csv"],
   result="Provisão de estoques e PCLD mais que dobraram/triplicaram; ponto de ruptura do DCF calculado só com premissas hipotéticas.", exc="Premissas reais não obtidas.", concl="Simulado; sem conclusão sobre as estimativas da Frasle.", apoio=["PT02_nota16_impairment.csv","PT03_nota18_intangivel.csv"])

pt(cod="550", titulo="Partes relacionadas", norma="NBC TA 550", versao="Res. CFC 1.224/09",
   itens="§§ 13–17 (identificação); §§ 20–24 (transações)", natureza=RLZ,
   objetivo="Identificar partes relacionadas e saldos (Nota 13).", conta="Contas a receber de partes relacionadas (controladora R$ 157.797 mil: 7.780 país + 150.017 exterior); mútuos.",
   afir="Apresentação e divulgação; completude.", fontes="F01 Nota 13 p.80; Nota 10 p.76; controladora direta Randoncorp S.A. (Nota 1).",
   proc=["Listar controladas com saldos (ex.: Frasle North America R$ 83.105 mil a receber; Frasle Argentina mútuo R$ 55.082 mil).","Verificar divulgação de condições (taxas CDI, prazos)."],
   evid=["F01 p.76, p.80","Legado: PT10_partes_relacionadas.csv"], result="Saldos intragrupo relevantes na controladora; eliminam-se no consolidado.", exc="Sem teste de preços de transferência.", concl="Identificação documental concluída.", apoio=["PT10_partes_relacionadas.csv"])

pt(cod="560", titulo="Eventos subsequentes", norma="NBC TA 560 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 6–9 (até a data do relatório); §§ 10–17 (após)", natureza=RLZ,
   objetivo="Registrar o corte: relatório do auditor e aprovação em 11/03/2026.", conta="Demonstrações em 31/12/2025.",
   afir="Corte; divulgação.", fontes="F01 p.66 (aprovação pelo Conselho em 11/03/2026); p.134 (relatório KPMG, Porto Alegre, 11/03/2026).",
   proc=["Registrar período de eventos subsequentes: 01/01/2026 a 11/03/2026.","Não foram buscadas notícias após essa data nesta etapa (planejado)."],
   evid=["F01 p.66, p.134","Legado: PT09_eventos_subsequentes.csv"], result="Data-limite documentada.", exc="Eventos após a emissão não pesquisados.", concl="Corte documentado.", apoio=["PT09_eventos_subsequentes.csv"])

pt(cod="570", titulo="Continuidade operacional", norma="NBC TA 570 (versão anterior à R1) — aplicável ao exercício de 2025", versao="Versão anterior à R1 (aplicada a 2025; número da resolução a conferir no CFC). A R1, DOU 25/09/2026, só vale para períodos iniciados em ou após 01/01/2027",
   itens="§§ 10–16 (avaliação da administração); § 18 (incerteza relevante)", natureza=RLZ,
   objetivo="Avaliar indicadores de continuidade a partir da DFP.", conta="Passivos financeiros: R$ "+n(F['dv'])+" mil sujeitos a covenants.",
   afir="Apresentação; avaliação da base contábil.", fontes="F01 Nota 23 p.106-107: covenant dívida líquida/EBITDA ≤ 3,50x, atendido em 31/12/2025; relatório KPMG p.132 (sem incerteza relevante apontada).",
   proc=["Ler o covenant e sua conclusão.","Verificar que o relatório do auditor não aponta incerteza relevante.","Calcular indicador de liquidez (não calculado: depende de dados adicionais)."],
   evid=["F01 p.106-107, p.132","Legado: PT08_continuidade_operacional.csv"], result="Covenants atendidos; sem indicação de incerteza.", exc="Folga do covenant não calculável publicamente sem EBITDA ajustado.", concl="Sem evidência pública de dúvida; análise limitada.", apoio=["PT08_continuidade_operacional.csv"])

pt(cod="580", titulo="Representações formais", norma="NBC TA 580 (R1)", versao="R1 — DOU 05/09/2016",
   itens="§§ 9–10 (obrigatórias); § 14 (data)", natureza=PLN,
   objetivo="Preparar minuta de carta de representação (não solicitada nem assinada).", conta="Administração.", afir="Todas.", fontes="Sem acesso à administração.",
   proc=["Redigir minuta (08_minutas/minuta_carta_representacao.md)."], evid=["08_minutas/minuta_carta_representacao.md","Legado: PT21_representacoes_formais.csv"],
   result="Minuta pronta; nada solicitado.", exc="Não aplicável.", concl="Planejado.", apoio=["PT21_representacoes_formais.csv"])

pt(cod="600", titulo="Auditoria de demonstrações de grupo (componentes)", norma="NBC TA 600 (R2)", versao="R2 — 06/12/2023",
   itens="§§ 17–22 (entendimento do grupo); §§ 30–35 (componentes)", natureza=RLZ,
   objetivo="Mapear componentes significativos do grupo.", conta="Consolidado: controladas no Brasil e exterior (México — Dacomsa; América do Norte; Argentina; Europa; China).",
   afir="Apresentação e valorização.", fontes="F01 Notas 1, 6, 13; KAM Dacomsa p.132.",
   proc=["Identificar componentes por saldos (Nota 13) e por aquisições (Nota 6).","Classificar significância por relevância financeira e risco (KAM Dacomsa)."],
   evid=["F01 p.67-69, p.80","Legado: PT24_auditoria_grupo.csv"], result="Frasle North America e Argentina são os maiores saldos intragrupo; Dacomsa é componente de risco significativo.", exc="Sem acesso a auditores de componentes.", concl="Escopo de componentes identificado; execução planejada.", apoio=["PT24_auditoria_grupo.csv"])

assert len(P) == 27, len(P)

# ------------------------------------------------------------------ .md dos PTs
os.makedirs("02_papeis_trabalho/roteiro", exist_ok=True)
for p in P:
    nome = "Estrutura Conceitual" if p["cod"] == "EC" else "NBC TA " + p["cod"]
    md = f"""# PT {p['cod']} — {p['titulo']}

| Campo | Conteúdo |
|---|---|
| Código | PT {p['cod']} |
| Norma e itens | {p['norma']} — {p['itens']} |
| Versão da norma | {p['versao']} |
| Natureza | **{p['natureza']}** |
| Companhia / exercício | Frasle Mobility S.A. (antes Frasle S.A.; ticker FRAS3) — 31/12/2025 |

## 1. Objetivo e conta/processo/divulgação
{p['objetivo']}

Conta/processo/divulgação: {p['conta']}

## 2. Afirmações e riscos
{p['afir']}

## 3. População, fontes e critérios
{p['fontes']}

## 4. Procedimentos
""" + "\n".join(f"{i+1}. {x}" for i, x in enumerate(p["proc"])) + f"""

## 5. Evidências e referências cruzadas
""" + "\n".join(f"- {x}" for x in p["evid"]) + f"""
- Fontes: 01_fontes/registro_fontes.csv — Matriz: 06_matrizes/matriz_cobertura_normas.csv

## 6. Resultados, exceções, conclusão e limitações
- **Resultados:** {p['result']}
- **Exceções:** {p['exc']}
- **Conclusão:** {p['concl']}
- **Limitações:** {LIM}

## 7. Responsáveis
- Preparador: matrícula {MAT} — {DATA}
- Revisão: {REV}
"""
    w(f"02_papeis_trabalho/roteiro/PT-{p['cod']}.md", md)

wcsv("02_papeis_trabalho/roteiro/roteiro_pts_consolidado.csv",
     ["pt","titulo","norma","versao_norma","natureza","objetivo","resultados","excecoes","conclusao","preparador_matricula","data","revisao"],
     [[p["cod"],p["titulo"],p["norma"],p["versao"],p["natureza"],p["objetivo"],p["result"],p["exc"],p["concl"],MAT,DATA,"Pendente"] for p in P])

# ------------------------------------------------------------------ matriz de cobertura
wcsv("06_matrizes/matriz_cobertura_normas.csv",
     ["pt","norma","versao_norma","natureza","procedimento_executado","evidencia_vinculada","resultado_conclusao","status_cobertura","limitacao","data_elaboracao"],
     [[p["cod"],p["norma"],p["versao"],p["natureza"],"; ".join(p["proc"])[:300],f"02_papeis_trabalho/roteiro/PT-{p['cod']}.md",p["concl"],
       {RLZ:"Executado com evidência pública",PLN:"Planejado — sem acesso",SIM:"Simulado — didático"}[p["natureza"]],LIM,DATA] for p in P])

# índice de PTs
wcsv("06_matrizes/indice_papeis_trabalho.csv",
     ["arquivo","titulo","norma","natureza","preparador","data_elaboracao","revisao"],
     [[f"02_papeis_trabalho/roteiro/PT-{p['cod']}.md",p["titulo"],p["norma"],p["natureza"],MAT,DATA,"Pendente"] for p in P])

# ------------------------------------------------------------------ matrizes (risco, resposta, distorção, deficiência, evidência)
M = []
def m(b,*r): M.append([b,*r])
for r in [
 ("Intangível adquirido (Dacomsa/TF Victor/Moresa)","Valorização","Alto (significativo — KAM KPMG)","Valor justo de carteira de clientes e marcas depende de premissas","PT 315"),
 ("Ágio e intangíveis — impairment","Valorização","Alto","Premissas de DCF; indicador ausente","PT 315/540"),
 ("Amortização do intangível","Valorização","Médio","Vida útil e taxa","PT 315"),
 ("Estoques — provisão para perdas","Valorização","Médio-alto","Provisão "+pct(F['pest25'],F['pest24'])+" no ano","PT 315/501"),
 ("Contas a receber — PCLD","Valorização","Médio","PCLD "+pct(F['pcld25'],F['pcld24']),"PT 315"),
 ("Provisão para litígios","Completude","Médio-alto","Crescimento "+pct(F['lit25'],F['lit24']),"PT 315/250"),
 ("Empréstimos — covenants","Apresentação","Médio","Dívida sujeita a covenants R$ 2.495.961 mil","PT 315/570")]:
    m("risco",*r)
for r in [
 ("Intangível adquirido","Reperformar PPA com especialista (planejado)","Planejado","PT 330"),
 ("Intangível (base)","MUS + testes de razoabilidade na base sintética","Simulado","PT 530"),
 ("Estoques","Acompanhar inventário; testar NRV (planejado)","Planejado","PT 501"),
 ("Litígios","Carta de advogados (planejado)","Planejado","PT 501/505"),
 ("Contas a receber","Circularização (modelo; não enviada)","Planejado","PT 505")]:
    m("resposta",*r)
for r in [
 ("Vida útil inadequada","79 inseridos / 55 detectados","24 não detectados","PT 450"),
 ("Indicador de impairment ausente","86 / 86","0","PT 450"),
 ("Amortização inconsistente","85 / 57","28 não detectados","PT 450"),
 ("Total","250 / 198","52 (todos Goodwill)","PT 450")]:
    m("distorcao",*r)
for r in [
 ("Cálculo de amortização sem controle de teto","Deficiência hipotética","Simulado","PT 265"),
 ("Revisão de vida útil sem evidência","Deficiência hipotética","Simulado","PT 265"),
 ("Indicadores de impairment sem alerta","Deficiência hipotética","Simulado","PT 265")]:
    m("deficiencia",*r)
for r in [
 ("DFP auditada (KPMG)","Externa, pública","Alta","Realizado"),
 ("Base sintética","Gerada pelo aluno","Nenhuma como evidência da Frasle","Simulado"),
 ("Cartas, confirmações, atas","Não obtidas","N/A","Planejado")]:
    m("evidencia",*r)
wcsv("06_matrizes/matrizes_risco_resposta_distorcao_deficiencia.csv",["bloco","item","coluna_2","coluna_3","coluna_4","coluna_5"],
     [x+[""]*(6-len(x)) for x in M])

# ------------------------------------------------------------------ programas de auditoria
PROG = {
 "receitas": ("Receitas","Receita líquida consolidada R$ 5.490.878 mil (2024: 3.965.776; +38,5%) — F01 p.23","Ocorrência, corte, mensuração","Reconhecimento fora do período; contratos com múltiplas obrigações; vendas intragrupo","Analítico por segmento (Nota 7); teste de corte; amostra de notas fiscais; conciliação com contas a receber"),
 "disponibilidades": ("Disponibilidades","Caixa e equivalentes R$ 1.316.248 mil — F01 p.72","Existência, direitos","Aplicações classificadas incorretamente; saldos no exterior","Circularização bancária (modelo, não enviada); conciliação bancária; teste de corte"),
 "estoques": ("Estoques","Estoques R$ 1.443.447 mil; provisão R$ 89.545 mil — F01 Nota 11 p.78","Existência, valorização","Obsolescência; custo médio; importações em andamento","Acompanhamento de inventário; teste de VRL; recálculo da provisão por rotatividade"),
 "imobilizado": ("Imobilizado","Imobilizado R$ 1.450.996 mil — F01 Nota 17 p.91","Existência, valorização","Capitalização indevida; vida útil; ativos adquiridos em combinações","Inspeção física; teste de adições; recálculo de depreciação"),
 "passivos": ("Passivos","Empréstimos sujeitos a covenants R$ 2.495.961 mil (F01 p.107); litígios R$ 139.790 mil (p.103); risco sacado R$ 7.532 mil (p.103)","Completude, apresentação","Passivos omitidos; classificação circulante/não circulante; covenants","Circularização; carta de advogados; recálculo de covenants; busca de passivos não registrados"),
 "estimativas": ("Estimativas contábeis","Impairment, valor justo Dacomsa (KAM p.132), PCLD R$ 22.321 mil, provisão de estoques, litígios","Valorização","Viés da administração; premissas","Avaliação de premissas; retrospectiva de estimativas anteriores; especialista (planejado)"),
}
for k,(nm,base,afir,riscos,procs) in PROG.items():
    w(f"07_programas_auditoria/programa_{k}.md", f"""# Programa de auditoria — {nm}

- Natureza: **{PLN}** (programa; execução depende de acesso à companhia). Partes com dado da DFP estão marcadas no PT correspondente.
- Base (R$ mil, consolidado 2025): {base}
- Afirmações: {afir}
- Riscos: {riscos}
- Procedimentos planejados: {procs}
- Execução: nenhum procedimento foi executado junto à companhia; nenhum terceiro foi contatado.
- Preparador: matrícula {MAT} — {DATA} · Revisão: {REV}
- Referências cruzadas: PT 315, PT 330, PT 500, matriz de cobertura.
""")

# ------------------------------------------------------------------ minutas (nenhuma enviada)
AV = "> MINUTA DIDÁTICA — NÃO ENVIADA, NÃO ASSINADA. Nenhum terceiro foi contatado.\n\n"
w("08_minutas/minuta_carta_contratacao.md", AV+"# Minuta de carta de contratação (NBC TA 210)\n\nDestinatário: [administração da companhia — fictício]\nEscopo: auditoria das demonstrações consolidadas de 31/12/2025 conforme NBC TA.\nResponsabilidades: da administração (elaboração e controles internos) e do auditor (opinião).\nAssinaturas: [reservadas — não assinar]\n")
w("08_minutas/minuta_comunicacao_governanca.md", AV+"# Minuta de comunicação à governança (NBC TA 260)\n\nAssuntos: escopo e época; riscos significativos (valor justo de intangíveis adquiridos; impairment); deficiências; independência.\nDestinatário: [Conselho de Administração — fictício]\n")
w("08_minutas/modelo_confirmacao_externa.md", AV+"# Modelo de confirmação externa (NBC TA 505)\n\nSolicitação de confirmação de saldo em [data]. Controle: status 'NÃO ENVIADA'; 0 recebidas.\n")
w("08_minutas/minuta_carta_representacao.md", AV+"# Minuta de carta de representação (NBC TA 580)\n\nA administração confirma, entre outros, responsabilidade pelas demonstrações, completude de informações e divulgação de partes relacionadas e eventos subsequentes. Assinatura: [reservada].\n")

# ------------------------------------------------------------------ conclusão integrada
w("09_conclusao_integrada.md", f"""# Conclusão integrada (sem opinião de auditoria)

Este dossiê integra os 27 papéis de trabalho do roteiro (EC e NBC TA 200–600) sobre a Frasle Mobility S.A. (exercício 2025). **Nenhuma opinião é emitida** nem sugerida.

- Com evidência pública (DFP/CVM, F01): {sum(1 for p in P if p['natureza']==RLZ)} PTs.
- Planejados por falta de acesso: {sum(1 for p in P if p['natureza']==PLN)} PTs.
- Simulados para fins didáticos (base sintética de 500.000 registros): {sum(1 for p in P if p['natureza']==SIM)} PTs.

Principais pontos: crescimento de {pct(F['intang25'],F['intang24'])} do intangível (aquisições); aumento da provisão para perdas com estoques ({pct(F['pest25'],F['pest24'])}); litígios {pct(F['lit25'],F['lit24'])}; covenants atendidos (≤ 3,50x). Testes sobre a base sintética valem apenas para a simulação; 52 erros inseridos não foram detectáveis.

Limitações: sem acesso à companhia; sem confirmações; materialidade sujeita a revisão (PT 320); revisão dos PTs pendente.
Preparador: matrícula {MAT} — {DATA}.
""")

# ------------------------------------------------------------------ Natureza legada → 3 classes oficiais (com log)
MAP = {"evidência pública":RLZ,"realizado":RLZ,"simulação":SIM,"simulado":SIM}
def novo(v):
    t = v.strip().lower()
    if t in (RLZ.lower(),PLN.lower(),SIM.lower()): return v
    if t.startswith("evidência pública"): return RLZ
    if t.startswith("simula"): return SIM
    return PLN  # planejado, conceitual/preliminar → planejado por falta de acesso
logrows = []
for f in sorted(glob.glob("02_papeis_trabalho/*.csv")):
    rows = list(csv.reader(open(f, encoding="utf-8")))
    if not rows or "Natureza" not in rows[0]: continue
    i = rows[0].index("Natureza")
    for r in rows[1:]:
        if len(r) > i:
            nv = novo(r[i])
            if nv != r[i]: logrows.append([os.path.basename(f), r[0], r[i], nv])
            r[i] = nv
    with open(f, "w", encoding="utf-8", newline="") as o:
        csv.writer(o, quoting=csv.QUOTE_NONNUMERIC).writerows(rows)
if logrows or not os.path.exists("06_matrizes/log_padronizacao_natureza_v2.csv"):  # idempotente: não apaga o log numa reexecução
    wcsv("06_matrizes/log_padronizacao_natureza_v2.csv", ["arquivo","Codigo","original","novo"], logrows)
print("OK:", len(P), "PTs;", len(logrows), "rótulos remapeados")
