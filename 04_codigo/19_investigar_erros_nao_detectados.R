
# Investigar erros de vida util nao detectados
# Base exclusivamente sintetica para fins academicos

# 1. Ler o log de erros inseridos
erros <- read.csv(
  "03_base_sintetica/log_erros_inseridos.csv",
  fileEncoding = "UTF-8"
)

# 2. Ler os registros sinalizados pelo teste
sinalizados <- read.csv(
  "05_resultados/registros_sinalizados.csv",
  fileEncoding = "UTF-8"
)

# 3. Separar os erros inseridos de vida util inadequada
erros_vida_util <- subset(
  erros,
  tipo_erro == "Vida util inadequada"
)

# 4. Identificar quais desses registros foram sinalizados
nao_detectados <- erros_vida_util[
  !erros_vida_util$id_registro %in% sinalizados$id_registro,
]

# 5. Exibir os resultados
cat("Erros de vida util inseridos:", nrow(erros_vida_util), "\n")
cat("Erros de vida util nao detectados:", nrow(nao_detectados), "\n")

# 6. Mostrar os registros nao detectados
print(nao_detectados)

# 7. Salvar uma copia para analise
write.csv(
  nao_detectados,
  "05_resultados/erros_vida_util_nao_detectados.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)


# Conferencia dos totais e das categorias

cat("\n--- LOG DE ERROS INSERIDOS ---\n")
print(table(erros$tipo_erro, useNA = "ifany"))

cat("\n--- REGISTROS SINALIZADOS ---\n")
print(names(sinalizados))
print(nrow(sinalizados))

cat("\n--- VIDA UTIL POR TIPO DE INTANGIVEL ---\n")
print(table(erros_vida_util$tipo_intangivel, useNA = "ifany"))

cat("\n--- VIDA UTIL NAO DETECTADA POR TIPO ---\n")
print(table(nao_detectados$tipo_intangivel, useNA = "ifany"))

