
# PROGRAMA 12 - Corrigir a classificacao dos erros simulados
# Uso exclusivamente educacional: base sintetica.

set.seed(241003375)

base <- read.csv(
  "03_base_sintetica/base_sintetica_intangivel.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

log_erros <- read.csv(
  "03_base_sintetica/log_erros_inseridos.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8"
)

# Conferir se os arquivos possuem as colunas esperadas
if (!all(c("id_registro", "tipo_erro") %in% names(log_erros))) {
  stop("O log nao possui as colunas id_registro e tipo_erro. Nao foram feitas alteracoes.")
}

if (!all(c("id_registro", "tipo_intangivel", "vida_util_anos",
           "erro_inserido", "tipo_erro") %in% names(base))) {
  stop("A base nao possui todas as colunas esperadas. Nao foram feitas alteracoes.")
}

# Identificar os erros atuais de vida util
ids_antigos <- log_erros$id_registro[
  log_erros$tipo_erro == "Vida util inadequada"
]

# Restaurar uma vida util plausivel nos registros antigos
pos_antigas <- match(ids_antigos, base$id_registro)
pos_antigas <- pos_antigas[!is.na(pos_antigas)]

base$vida_util_anos[pos_antigas] <- sample(
  c(3, 5, 6, 10, 15, 20),
  length(pos_antigas),
  replace = TRUE
)

# Manter os registros com outros tipos de erro
outros_erros <- log_erros[
  log_erros$tipo_erro != "Vida util inadequada",
]

ids_ocupados <- outros_erros$id_registro

# Selecionar apenas intangiveis diferentes de Goodwill
elegiveis <- base[
  base$tipo_intangivel != "Goodwill" &
    !base$id_registro %in% ids_ocupados,
]

if (nrow(elegiveis) < length(ids_antigos)) {
  stop("Nao ha registros elegiveis suficientes. Nenhum arquivo foi salvo.")
}

# Escolher novos registros para o erro de vida util
novos_ids <- sample(elegiveis$id_registro, length(ids_antigos))

pos_novas <- match(novos_ids, base$id_registro)
base$vida_util_anos[pos_novas] <- 2

# Atualizar a marcacao de erro na base
base$erro_inserido <- FALSE
base$tipo_erro <- NA_character_

ids_todos_erros <- c(outros_erros$id_registro, novos_ids)
tipos_todos_erros <- c(outros_erros$tipo_erro,
                       rep("Vida util inadequada", length(novos_ids)))

pos_todos <- match(ids_todos_erros, base$id_registro)
base$erro_inserido[pos_todos] <- TRUE
base$tipo_erro[pos_todos] <- tipos_todos_erros

# Reconstruir o log, preservando as demais colunas existentes
novos_erros_vida <- log_erros[
  log_erros$tipo_erro == "Vida util inadequada",
]

novos_erros_vida$id_registro <- novos_ids

log_atualizado <- rbind(outros_erros, novos_erros_vida)

# Salvar base e log juntos
write.csv(
  base,
  "03_base_sintetica/base_sintetica_intangivel.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

write.csv(
  log_atualizado,
  "03_base_sintetica/log_erros_inseridos.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Base e log atualizados.\n")
cat("Erros de vida util:", length(novos_ids), "\n")
cat("Erros de vida util em Goodwill:",
    sum(base$id_registro %in% novos_ids &
          base$tipo_intangivel == "Goodwill"), "\n")
cat("Total de erros no log:", nrow(log_atualizado), "\n")
cat("Total de erros marcados na base:",
    sum(base$erro_inserido == TRUE), "\n")
