# Conferencia inicial dos papeis de trabalho
# Este script apenas le os arquivos; nao altera nenhum documento.

arquivos <- list.files(
  "02_papeis_trabalho",
  pattern = "\\.csv$",
  full.names = TRUE
)

for (arquivo in arquivos) {
  cat("\n====================================\n")
  cat("ARQUIVO:", basename(arquivo), "\n")
  cat("====================================\n")
  
  dados <- tryCatch(
    read.csv(
      arquivo,
      stringsAsFactors = FALSE,
      check.names = FALSE,
      fileEncoding = "UTF-8"
    ),
    error = function(e) NULL
  )
  
  if (is.null(dados)) {
    cat("Nao foi possivel ler este arquivo.\n")
  } else {
    cat("Quantidade de linhas:", nrow(dados), "\n")
    cat("Colunas:\n")
    print(names(dados))
    
    cat("\nPrimeiras duas linhas:\n")
    print(head(dados, 2))
  }
}