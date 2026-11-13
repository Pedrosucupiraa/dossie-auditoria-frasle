# 04_codigo/50_gerar_dossie_pdf.py — monta dossie_auditoria_frasle_P2.pdf (md -> html via pandoc -> PDF via Chromium/Playwright)
import re, glob, csv, subprocess, os
cods = ["EC"]+[str(x) for x in (200,210,220,230,240,250,260,265,300,315,320,330,402,450,500,501,505,510,520,530,540,550,560,570,580,600)]
def link(t):  # "PT 315" -> link interno
    return re.sub(r"\bPT (EC|\d{3})\b", lambda m: f"[PT {m.group(1)}](#pt-{m.group(1).lower()})", t)
out = ["---\ntitle: \"Dossiê de Auditoria — Frasle Mobility S.A. (exercício 2025)\"\nsubtitle: \"UnB · Auditoria 1 (CCA0024) · Turma 02 · 2026.2 — P2 individual\"\nauthor: \"Pedro Henrique De Oliveira Sucupira — matrícula 241003375\"\ndate: \"13/11/2026\"\n---\n",
 "# Aviso\n\nTrabalho acadêmico com base em informações públicas (DFP 2025, CVM) e em base sintética de 500.000 registros. **Não é auditoria, não há opinião e nenhum terceiro foi contatado.** A companhia chamava-se Frasle S.A. até 31/12/2025 (Nota 1, p.66; ticker FRAS3). Natureza de cada PT: *Realizado com evidência pública*, *Planejado por falta de acesso* ou *Simulado para fins didáticos*. Entrega original: 25/10/2026; esta versão é posterior ao prazo.\n\n"]
out.append("# Papéis de trabalho do roteiro\n")
for c in cods:
    t = open(f"02_papeis_trabalho/roteiro/PT-{c}.md",encoding="utf-8").read()
    t = t.replace(f"# PT {c} —", f"## PT {c} —",1)
    t = re.sub(r"^## (\d\.)", r"#### \1", t, flags=re.M)
    t = t.replace(f"## PT {c} —", f"## PT {c} — ",1)
    t = re.sub(rf"^(## PT {c} — .*)$", rf"\1 {{#pt-{c.lower()}}}", t, count=1, flags=re.M)
    out.append(link(t)+"\n\\newpage\n")
def tab(f, titulo):
    r = list(csv.reader(open(f,encoding="utf-8")))
    s = f"# {titulo}\n\n| "+" | ".join(r[0])+" |\n|"+"---|"*len(r[0])+"\n"
    for x in r[1:]: s += "| "+" | ".join(c.replace("|","/").replace("\n"," ")[:160] for c in x)+" |\n"
    return s+"\n"
out.append(tab("06_matrizes/matrizes_risco_resposta_distorcao_deficiencia.csv","Matrizes de risco, resposta, distorção, deficiência e evidência"))
out.append(tab("01_fontes/registro_fontes.csv","Fontes"))
out.append("# Programas, minutas e conclusão\n\n"+"\n".join(f"- {os.path.basename(f)}" for f in sorted(glob.glob("07_programas_auditoria/*.md")+glob.glob("08_minutas/*.md")))+"\n\n"+open("09_conclusao_integrada.md",encoding="utf-8").read().replace("# Conclusão integrada","## Conclusão integrada"))
open("dossie_auditoria_frasle_P2.md","w",encoding="utf-8").write("\n".join(out))
css = "body{font-family:Georgia,serif;font-size:10.5pt;max-width:none;margin:0 1cm}table{border-collapse:collapse;font-size:8pt;width:100%}td,th{border:1px solid #999;padding:3px;vertical-align:top}h1{page-break-before:always}h2{margin-top:1.2em}a{color:#0b4f8a}"
open("/tmp/dossie.css","w").write(css)
subprocess.run(["pandoc","dossie_auditoria_frasle_P2.md","-s","--toc","--toc-depth=2","-c","/tmp/dossie.css","--embed-resources","-o","/tmp/dossie.html"],check=True)
from playwright.sync_api import sync_playwright
with sync_playwright() as p:
    b = p.chromium.launch(); pg = b.new_page(); pg.goto("file:///tmp/dossie.html")
    pg.pdf(path="dossie_auditoria_frasle_P2.pdf", format="A4", margin={"top":"1.5cm","bottom":"1.5cm","left":"1.5cm","right":"1.5cm"}, print_background=True); b.close()
print("pdf ok")
