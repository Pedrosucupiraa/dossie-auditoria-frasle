
# ============================================================
# SCRIPT 42 - REVISAO DA COBERTURA DAS NORMAS DE AUDITORIA
# Empresa: Frasle Mobility S.A.
# Objetivo: conferir a matriz sem alterar o arquivo original
# ============================================================

arquivo <- "06_matrizes/matriz_cobertura_normas.csv"

matriz <- read.csv(
  arquivo,
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

# 1. Conferir a estrutura da matriz
cat("Total de normas:", nrow(matriz), "\n")
cat("Normas distintas:", length(unique(matriz$Norma)), "\n")

# 2. Identificar campos vazios
campos <- c(
  "Norma",
  "Tema",
  "Status",
  "Evidencia_ou_procedimento",
  "Limitacao",
  "Data_elaboracao"
)

cat("\nCampos vazios por coluna:\n")

for (campo in campos) {
  valores <- matriz[[campo]]
  vazios <- is.na(valores) | trimws(valores) == ""
  cat(campo, ":", sum(vazios), "\n")
}

# 3. Identificar normas com evidência ou limitação vazia
cat("\nNormas sem evidencia/procedimento:\n")
print(
  matriz$Norma[
    is.na(matriz$Evidencia_ou_procedimento) |
      trimws(matriz$Evidencia_ou_procedimento) == ""
  ]
)

cat("\nNormas sem limitacao registrada:\n")
print(
  matriz$Norma[
    is.na(matriz$Limitacao) |
      trimws(matriz$Limitacao) == ""
  ]
)

# 4. Exibir a matriz para revisão
View(matriz)
