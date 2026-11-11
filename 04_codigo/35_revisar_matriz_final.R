
arquivo <- "06_matrizes/matriz_cobertura_normas.csv"

matriz <- read.csv(
  arquivo,
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

cat("Total de linhas:", nrow(matriz), "\n")
cat("Normas distintas:", length(unique(matriz$Norma)), "\n")

cat("\nDistribuicao dos status:\n")
print(table(matriz$Status, useNA = "ifany"))

cat("\nNormas ainda marcadas como A desenvolver:\n")
print(matriz$Norma[matriz$Status == "A desenvolver"])

cat("\nNormas sem status:\n")
print(matriz$Norma[
  is.na(matriz$Status) | trimws(matriz$Status) == ""
])

cat("\nNormas duplicadas:\n")
print(unique(matriz$Norma[duplicated(matriz$Norma)]))

cat("\nStatus dos quatro papeis adicionais:\n")
print(matriz[
  matriz$Norma %in% c(
    "NBC TA 200",
    "NBC TA 210",
    "NBC TA 402",
    "NBC TA 580"
  ),
  c("Norma", "Status")
])
