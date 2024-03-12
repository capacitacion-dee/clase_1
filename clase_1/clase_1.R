
# Variables y tipos de datos ----------------------------------------------

# En R existen distintos tipos de datos u objetos en símbolos llamados variables (en R todo es en esencia un objeto).
# La manera más sencilla de asignar un objeto a una variable es mediante la función "<-". 
# Los tipos de datos más utilizados en R corresponden a:

# numeric
numero <- 6.5
class(numero)

# integer
# NOTA: la L es para decirle a R que es un número entero. Esto no es siempre necesario pero lo hacemos para
# contextualizar este ejemplo
int <- 8L
class(int)

# Podemos hacer operaciones aritméticas

numero + int
numero * int
numero ^ int
int - numero

# character
str <- "texto"
class(str)

# variables lógicas
verdadero <- TRUE
falso <- FALSE
class(verdadero)

# operadores lógicos
verdadero & falso 
verdadero | falso

# Podemos comparar la igualdad lógica entre dos valores mendiante "=="
3 == 5
7 == 7

# Podemos evaluar la no igualdad con "!=" (es distinto de)
3 != (1+2)

# podemos realizar comparaciones de orden
2 >= -10
8 < -1

# Vectores ----------------------------------------------------------------

# Corresponden a arreglos unidimensionales que almacenan un mismo tipo de dato en cada una de sus entradas.
# Todo vector en R se puede declarar con la letra "c" seguido de los elementos que lo componen entre 
# paréntesis y separados por comas.

# Declaración de dos vectores
v1 <- c(1,1,2,3,5,8,13)
v1

# Otra forma
v2 <- 1:100 # Retorna un vector de enteros consecutivos del 1 al 100.
v2

# Vectores lógicos
v_log <- c(T,T,F,T,F)
v_log

# Vectores de strings
palabras <- c("hola", "soy", "loreto")
palabras

# podemos asignar los nombres a vector 1 usando la función names()
names(v1) <- c("n1","n2","n3","n4","n5","n6","n7")
v1

# combinar vectores
v3 <- c(100,200)
nuevo <- c(v1,v3)
nuevo

# largo de un vector
length(nuevo)

# Subset de vectores
# Por posición
v1
v1[2]

# retorna los elementos de las casillas 1  y 4
v1[c(1,4)]

#NOTA 3:5, R lo interpreta como c(3,4,5)
v1[c(3,4,5)]
v1[3:5]

# Por comparaciones lógicas
v1[v1>3] # Con esto podemos obtener las entradas que son mayores a 3.
v1[!(v1 > 3)] # Estamos negando la expresión (v1 > 3)

# Por nombre
v1["n3"]  # Misma idea que la anterior, pero indicando el nombre de la casilla (con comillas)
v1[c("n1","n2")]  # En el caso de requerir más de una celda se incluye un vector de nombres.

# Ej: Queremos cambiar el elmento de posición 3, por un -999
v1[3] <- -999
v1


# Ejercicio 1 -------------------------------------------------------------
# Genere un vector llamado mi_vector que contenga los números del 5 al 10
# Genere un vector llamado mi_vector2 que contenga las 5 primeras letras del abecedario
# Combine ambos vectores y llámelo mi_vector_combinado. 
# Qué tipo de datos contiene mi_vector_combinado?
# Cuál es el largo de mi_vector_combinado?
# De mi_vector_combinado substraiga los elementos 1 y 10
# Cambie el valor del elemento de la posición 10 por "z"



# Dataframes --------------------------------------------------------------

# Instalar y cargar el paquete dplyr
install.packages("dplyr")
library(dplyr)

# En este caso cada vector corresponde a una columna del data.frame, mientras que la cantidad de filas 
# corresponde al largo común de los vectores de cada entrada. 
# El objeto resultante es una tabla, de ahora en adelante data.frame, 
# cuyas columnas poseen distintos tipos de datos entre sí.

# Ejemplo sencillo de definición de un data.frame
# recordar que 1:3 es lo mismo que c(1,2,3)
n1 <- 1:5
let <- c("A", "A", "B", "C", "B")
log <- c(TRUE, TRUE, FALSE, TRUE, FALSE)

df <- data.frame(num = n1,
                 letra = let ,
                 bool = log)
df

# Dimensión de un data.frame
dim(df) 

# Número de filas
nrow(df)

# Número de columnas
ncol(df)

# Nombre de las columnas
names(df)

# Función str() muestra la estructura interna de un objeto
str(df)

# Valores únicos de una variable
distinct(df, letra)

# Conteo de valores únicos de una variable
count(df, letra)

# Resumen estadístico
summary(df)

# Cómo se accede a los elementos de un dataframe?

# Acceso a columnas de un data.frame

# Acceder a una sola columna

# Por posición 
# [] selecciona una porción de datos (puede ser una o varias columnas) -> aplicado a un dataframe obtengo otro dataframe

df[,3]
class(df[,3])

# Por nombre 
df[,"letra"]

# Por $ 
df$letra

# Acceso a filas

# segunda fila de df
df[2, ] # si dejamos en blanco después de la coma toma todas las columnas

# Acceso a filas y columnas

# segunda columna y segunda fila
df[2, 2]

# Acceso a varias columnas y filas
df[1:2, "bool"]
df[1:2, c("letra", "bool")]

# Según condición
df[df$num<3, ]
df[df[1]<3, ]

# Según varias condiciones
df[df$num<3 & df$letra=="A",]

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
# Cuántos datos existen para cada valor único de estado civil?
# Seleccione las columnas "anio", "edad" y "religion"
# Seleccione las mismas columnas pero ahora sólo las 10 primeras filas
# Seleccione las filas donde horas_tv es menor a 5


# Importación de datos ----------------------------------------------------
install.packages("readxl")
install.packages("readr")
library(readxl)
library(readr)

# Importe el archivo excel "vuelos.xlsx" dentro de la carpeta "data" y nómbrela vuelos
vuelos <- read_excel("data/vuelos.xlsx")

# Más argumentos...
iac <- read_excel("data/descargas/series-mensuales-desde-enero-de-2018-a-la-fecha.xls", sheet = 2, skip = 5,
                  col_types = c("text", "text", rep("numeric", 4)))
# NOTA: rep replica valores del primer argumento n-veces

# Importe el archivo csv "datosCine.csv" dentro de la carpeta "data" y nómbrela cine
cine <- read_csv("data/datosCine.csv")


