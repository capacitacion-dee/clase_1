# Tarea 1 -----------------------------------------------------------------
# En este ejercicio usaremos un dataframe con las series históricas del IAC tanto general
# como por división

# Carque la base "iac_division.rds" usando la función read_rds del paquete readr
# Llame al dataframe iac_division
library(readr)

iac_division <- read_rds("data/iac_division.rds")

# Utilize la funcion head(iac_division, 10) para observar las 10 primeras filas del dataframe
head(iac_division, 10)

# Qué puede decir de la base?

# Cuál es la dimensión del dataframe?
dim(iac_division)

# Cuál es la estructura de la base y qué tipo de datos contiene?
str(iac_division)

# Cuente los valores únicos de la variable "anio"
count(iac_division, anio)

# Substaiga la columna "iac_general" y llame al objeto "valores"
valores <- iac_division["iac_general"]

# Cuál es la clase de "valores"?
class(valores)

# Utilizando el dataframe iac_division responda en qué fecha el IAC fue menor a 80?
iac_division[iac_division$iac_general<80, ]

# En qué fecha o fechas el IAC de la división 45 fue menor a 60
iac_division[iac_division$iac_div_45<60, ]

# Cuál fue el IAC en el mes de diciembre del 2023?
iac_division[iac_division$mes_num==12 & iac_division$anio==2023, ]