# 04_codigo/49_verificacao_p2.py — checklist OK/FALTA contra as instruções do P2 (rodar na raiz do repositório)
import os, csv, glob, re
R = []
def chk(nome, cond): R.append((nome, bool(cond)))
cods = ["EC"]+[str(x) for x in (200,210,220,230,240,250,260,265,300,315,320,330,402,450,500,501,505,510,520,530,540,550,560,570,580,600)]
for c in cods:
    f = f"02_papeis_trabalho/roteiro/PT-{c}.md"; t = open(f,encoding="utf-8").read() if os.path.exists(f) else ""
    chk(f"PT {c}: 7 seções + preparador + revisão pendente", all(k in t for k in ("## 1.","## 2.","## 3.","## 4.","## 5.","## 6.","## 7.")) and "241003375" in t and "Pendente de revisão" in t)
    chk(f"PT {c}: natureza oficial", any(x in t for x in ("**Realizado com evidência pública**","**Planejado por falta de acesso**","**Simulado para fins didáticos**")))
m = list(csv.DictReader(open("06_matrizes/matriz_cobertura_normas.csv",encoding="utf-8")))
chk("Matriz de cobertura com 27 linhas e versões", len(m)==27 and all(r["versao_norma"] for r in m))
chk("Matriz: evidência vinculada existe", all(os.path.exists(r["evidencia_vinculada"]) for r in m))
fs = list(csv.DictReader(open("01_fontes/registro_fontes.csv",encoding="utf-8")))
chk("Fontes: endereço, data, página, exercício", all(r["endereco_eletronico"] and r["data_acesso"] and r["pagina"] and r["exercicio"] for r in fs))
chk("DFP em 01_fontes", os.path.exists("01_fontes/155265_006211_20102026101023.pdf"))
b = "03_base_sintetica/base_sintetica_intangivel.csv"
n = sum(1 for _ in open(b,encoding="utf-8"))-1 if os.path.exists(b) else 0
chk("Base sintética ≥ 500.000 linhas", n>=500000)
chk("Base marcada como sintética", "SINTETICO" in open(b,encoding="utf-8").read(2000))
for f in ("dicionario_base_intangivel.csv","log_erros_inseridos.csv","planejamento_base_intangivel.csv"):
    chk("03_base_sintetica/"+f, os.path.exists("03_base_sintetica/"+f))
chk("Reconciliação da base ao saldo", "TRUE" in open("05_resultados/reconciliacao_intangivel_revisada.csv",encoding="utf-8").read())
chk("Comparação inseridos × detectados", os.path.exists("05_resultados/comparacao_erros_teste.csv"))
chk("Planilhas editáveis", os.path.exists("05_resultados/planilhas_editaveis_p2.xlsx"))
for k in ("receitas","disponibilidades","estoques","imobilizado","passivos","estimativas"):
    chk(f"Programa de {k}", os.path.exists(f"07_programas_auditoria/programa_{k}.md"))
chk("4 minutas", len(glob.glob("08_minutas/*.md"))>=4)
chk("Conclusão integrada sem opinião", "Nenhuma opinião" in open("09_conclusao_integrada.md",encoding="utf-8").read())
leg = 0
for f in glob.glob("02_papeis_trabalho/*.csv"):
    rows = list(csv.reader(open(f,encoding="utf-8")))
    if "Natureza" in rows[0]:
        i = rows[0].index("Natureza"); leg += sum(1 for r in rows[1:] if r[i] not in ("Realizado com evidência pública","Planejado por falta de acesso","Simulado para fins didáticos"))
chk("Natureza legada só com 3 classes", leg==0)
rd = open("README.md",encoding="utf-8").read()
chk("README com matrícula, mudança de nome e data", "241003375" in rd and "Fras" in rd and "25/10/2026" in rd)
chk("Dossiê PDF", os.path.exists("dossie_auditoria_frasle_P2.pdf"))
ok = sum(v for _,v in R)
for nme,v in R:
    if not v: print("FALTA:", nme)
print(f"{ok}/{len(R)} itens OK")
