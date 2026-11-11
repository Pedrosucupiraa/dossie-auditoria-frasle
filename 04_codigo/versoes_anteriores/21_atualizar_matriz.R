
# Atualizacao da matriz de cobertura das normas


# Atualizacao da matriz de cobertura das normas

arquivo_matriz <- "06_matrizes/matriz_cobertura_normas.csv"

matriz <- read.csv(
  arquivo_matriz,
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

atualizacoes <- data.frame(
  Norma = c(
    "NBC TA 240",
    "NBC TA 450",
    "NBC TA 520",
    "NBC TA 540",
    "NBC TA 570",
    "NBC TA 560",
    "NBC TA 550",
    "NBC TA 250",
    "NBC TA 260",
    "NBC TA 265",
    "NBC TA 510",
    "NBC TA 501",
    "NBC TA 505"
  ),
  Status = c(
    "Parcial - riscos preliminares documentados",
    "Parcial - excecoes sinteticas analisadas",
    "Parcial - analise comparativa de cinco contas; variacoes relevantes identificadas",
    "Parcial - analise documental limitada",
    "Parcial - analise documental de continuidade",
    "Parcial - procedimentos sobre eventos subsequentes pendentes",
    "Parcial - procedimentos sobre partes relacionadas pendentes",
    "Parcial - analise documental de leis e regulamentos",
    "Parcial - estrutura de comunicacao com a governanca documentada",
    "Parcial - limitacao de avaliacao dos controles internos",
    "Parcial - analise de saldos comparativos pendente de verificacao",
    "Parcial - procedimentos sobre itens selecionados parcialmente documentados",
    "Parcial - confirmacoes externas planejadas, nao executadas"
  ),
  stringsAsFactors = FALSE
)

# Verificar se as colunas necessarias existem
if (!all(c("Norma", "Status") %in% names(matriz))) {
  stop("A matriz nao possui as colunas Norma e Status esperadas.")
}

# Atualizar os status pelo nome da coluna
for (j in seq_len(nrow(atualizacoes))) {
  i <- matriz$Norma == atualizacoes$Norma[j]
  
  if (any(i)) {
    matriz$Status[i] <- atualizacoes$Status[j]
  } else {
    warning(
      paste(
        "Norma nao encontrada na matriz:",
        atualizacoes$Norma[j]
      )
    )
  }
}

# Salvar a matriz atualizada
write.csv(
  matriz,
  arquivo_matriz,
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Matriz atualizada com sucesso.\n")
cat("Total de normas com status atualizado:", nrow(atualizacoes), "\n")
cat("Arquivo:", arquivo_matriz, "\n")


# Atualizar a matriz com os quatro ultimos papeis de trabalho

atualizacoes_finais <- data.frame(
  Norma = c(
    "NBC TA 200",
    "NBC TA 210",
    "NBC TA 402",
    "NBC TA 580"
  ),
  Status = c(
    "Parcial - objetivos gerais, ceticismo e limitacoes documentados",
    "Parcial - pre-condicoes e termos do trabalho documentados; sem contratacao real",
    "Parcial - riscos de organizacoes prestadoras de servicos documentados; sem avaliacao interna",
    "Parcial - representacoes formais planejadas; nao solicitadas nem recebidas"
  ),
  stringsAsFactors = FALSE
)

for (j in seq_len(nrow(atualizacoes_finais))) {
  i <- matriz$Norma == atualizacoes_finais$Norma[j]
  
  if (any(i)) {
    matriz$Status[i] <- atualizacoes_finais$Status[j]
  } else {
    warning(
      paste(
        "Norma nao encontrada na matriz:",
        atualizacoes_finais$Norma[j]
      )
    )
  }
}

write.csv(
  matriz,
  arquivo_matriz,
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Matriz atualizada com os quatro papeis adicionais.\n")


# Atualizar a matriz com PT22, PT23 e PT24

atualizacoes_novas <- data.frame(
  Norma = c(
    "Estrutura Conceitual",
    "NBC TA 220",
    "NBC TA 600"
  ),
  Status = c(
    "Parcial - principios de asseguracao, ceticismo e limitacoes documentados",
    "Parcial - consideracoes sobre gestao da qualidade documentadas; sem auditoria contratada",
    "Parcial - riscos de auditoria de grupo documentados; avaliacao de componentes pendente"
  ),
  stringsAsFactors = FALSE
)

for (j in seq_len(nrow(atualizacoes_novas))) {
  i <- matriz$Norma == atualizacoes_novas$Norma[j]
  
  if (any(i)) {
    matriz$Status[i] <- atualizacoes_novas$Status[j]
  } else {
    warning(
      paste(
        "Norma nao encontrada na matriz:",
        atualizacoes_novas$Norma[j]
      )
    )
  }
}

write.csv(
  matriz,
  arquivo_matriz,
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Matriz atualizada com PT22, PT23 e PT24.\n")


