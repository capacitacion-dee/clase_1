
# Ejercicio 1 -------------------------------------------------------------
# Genere un vector llamado mi_vector que contenga los números del 5 al 10
# Genere un vector llamado mi_vector2 que contenga las 5 primeras letras del abecedario
# Combine ambos vectores y llámelo mi_vector_combinado. 
# Qué tipo de datos contiene mi_vector_combinado?
# Cuál es el largo de mi_vector_combinado?
# De mi_vector_combinado substraiga los elementos 1 y 10
# Cambie el valor del elemento de la posición 10 por "z"

mi_vector <- 5:10
mi_vector2 <- c("a","b","c","d","e")
mi_vector_combinado <- c(mi_vector, mi_vector2)
class(mi_vector_combinado)
length(mi_vector_combinado)
mi_vector_combinado[c(1,10)]
mi_vector_combinado[10] <- "z"

# Ejercicio 2 -------------------------------------------------------------
install.packages("datos")
library(datos)

datos <- encuesta

# Cuál es la dimensión del dataframe?
# Cuántas filas tiene?
# Cuántas columnas?
# Cuáles son los nombres de las columnas?
# Qué tipo de datos tiene?
# NOTA: "Factor" es un tipo de dato que almacena variables
# categóricas o cuantitativas con un número finito de valores o niveles
# Cuáles son los valores únicos de la variable estado_civil?
# Cuántos datos existen para cada valor único
# Seleccione las columnas "anio", "edad" y "religion"
# Seleccione las mismas columnas pero ahora sólo las 10 primeras filas
# Seleccione las filas donde horas_tv es menor a 5


dim(datos)
nrow(datos)
ncol(datos)
names(datos)
str(datos)
distinct(datos, estado_civil)
count(datos, estado_civil)
datos[, c("anio", "edad", "religion")]
datos[1:10, c("anio", "edad", "religion")]
datos[datos$horas_tv < 5,]
# Otra forma
datos[datos[,"horas_tv"]<5,]
