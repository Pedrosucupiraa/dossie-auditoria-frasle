# 04_codigo/48_gerar_xlsx.py — planilhas editáveis com fórmulas (materialidade, amostra, análises, reconciliação)
import csv
from openpyxl import Workbook
from openpyxl.styles import Font, PatternFill
wb = Workbook(); H = Font(bold=True); IN = PatternFill("solid", fgColor="FFF2CC")
ws = wb.active; ws.title = "Materialidade"
rows = [("Referencial","Base (R$ mil)","% aplicado","Valor (R$ mil)","Fonte"),
 ("Ativo total",7222660,0.01,"=B2*C2","DFP 2025 p.20-21"),
 ("Receita líquida",5490878,0.005,"=B3*C3","DFP 2025 p.23"),
 ("Lucro antes dos tributos",320897,0.05,"=B4*C4","DFP 2025 p.23 (EBIT 724.106 − resultado financeiro 403.209)"),
 ("Global adotada (referencial 1)","=D2","","=B5","Escolha do aluno: 1% do ativo"),
 ("Execução (75%)","=D5",0.75,"=B6*C6",""),
 ("Irrelevantes (5%)","=D5",0.05,"=B7*C7","")]
for r in rows: ws.append(r)
for c in ws[1]: c.font = H
for c in ("C2","C3","C4","C6","C7","B2","B3","B4"): ws[c].fill = IN
ws2 = wb.create_sheet("Amostra_MUS")
ws2.append(("Parâmetro","Valor","Observação"))
ws2.append(("V (saldo, R$ mil)",1874550,"Reconcilia ao balanço"))
ws2.append(("Materialidade de execução","=Materialidade!D6",""))
ws2.append(("Fator de confiança (95%, 0 erros)",3,""))
ws2.append(("J = ME / fator","=B3/B4",""))
ws2.append(("Seleções n = V / J","=ROUNDUP(B2/B5,0)",""))
ws2.append(("Semente",241003375,"set.seed"))
ws3 = wb.create_sheet("Reconciliacao")
ws3.append(("Item","R$ mil"))
ws3.append(("Saldo inicial 2024",586859)); ws3.append(("Movimentação",1287691))
ws3.append(("Saldo calculado","=B2+B3")); ws3.append(("Saldo divulgado 2025",1874550)); ws3.append(("Diferença","=B4-B5"))
ws4 = wb.create_sheet("Analiticos")
ws4.append(("Conta","2025","2024","Variação %"))
for nme,a,b in [("Receita líquida",5490878,3965776),("Intangível",1874550,586859),("Estoques",1443447,1054752),("Provisão p/ perdas estoques",89545,30861),("PCLD",22321,9330),("Provisão litígios",139790,110506),("Lucro líquido",283166,374703)]:
    r = ws4.max_row+1; ws4.append((nme,a,b,f"=B{r}/C{r}-1"))
ws5 = wb.create_sheet("Erros_inseridos_x_detectados")
for r in csv.reader(open("05_resultados/comparacao_erros_teste.csv",encoding="utf-8")): ws5.append(r)
for ws_ in wb: 
    for col in "ABCDE": ws_.column_dimensions[col].width = 34
wb.save("05_resultados/planilhas_editaveis_p2.xlsx"); print("xlsx ok")
