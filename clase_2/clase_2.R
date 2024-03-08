
# Instalar paquetes
install.packages("tidyverse")

# Cargar paquetes
library(tidyverse)
library(readxl)

# Utilizaremos el dataframe "vuelos"
# Contiene la información de los vuelos con salida en los aeropuertos de Nueva York en el año 2013.

### Importar datos ###
vuelos <- read_excel("clase_2/vuelos.xlsx")

# Operador %>% ------------------------------------------------------------

# Funciona como una composición de funciones
# Permite escribir código de forma más ordenada y fácil de entender, leyendo de izquierda a derecha
# Es equivalente a f(x)

# Ejemplo 1:
# Obtener los 6 primeros elementos de un dataframe usando la función head()

vuelos %>% head()

# Es lo mismo que...

head(vuelos)

# Ejemplo 2:
# Contar el número de veces que aparece cada aerolinea

vuelos %>% count(aerolinea)

# Es lo mismo que...

count(vuelos, aerolinea)


# Trabajo básico con filas ------------------------------------------------

### Función filter ###

# Filtrar filas según condición
filter(vuelos, aerolinea=="UA")

# Usando %>%
vuelos %>% filter(aerolinea=="UA")

# Otros ejemplos usando filter()
vuelos %>% filter(mes>1)
vuelos %>% filter(atraso_salida <= 100)
vuelos %>% filter(aerolinea!="AA" & mes == 12)
vuelos %>% filter(atraso_llegada %in% 100:200)
#NOTA: El operador %in% se utiliza para verificar si un elemento está presente en un vector, lista, o conjunto de datos

### Funciones slice ###

# Cortar las primeras datos según un número determinado
slice_head(vuelos, n = 5)

# Recordar que es equivalente a
vuelos %>% slice_head(n = 5)

# Cortar las últimas filas según un número determinado
# Si no le entrego el argumento n devuleve la última fila
slice_tail(vuelos, n = 5)

# Equivalente a
vuelos %>% slice_tail()

# Obtener una muestra de filas aleatorias
slice_sample(vuelos, n = 5)

# Equivalente a
vuelos %>% slice_sample(n = 5)

# Obtener filas especificadas
slice(vuelos, 100:105)

# Equivalente a
vuelos %>% slice(100:05)

# NOTA: para obtener mayor información sobre las funciones y sus argumentos podemos usar "?"
?slice_tail

### Anidación de funciones ###

# Usando filter y slice_head en conjunto
slice_head(filter(vuelos, aerolinea=="UA"), n = 5)

# Usando %>%
vuelos %>% filter(aerolinea=="UA") %>% 
  slice_head(n = 5)

# Más complejo...

# Utilizar la función count() para contar la frecuencia de ocurrencia de combinaciones únicas de los valores en las columnas "mes" y "dia"
# Luego, utilizar la función filter() para seleccionar solo aquellas filas donde el valor de la columna "dia" sea igual a 1.
# Finalmente, utiliza la función head() para mostrar las primeras filas del resultado obtenido, 
# que contiene la frecuencia de vuelos para cada mes en el primer día del mes.

slice_head(filter(count(vuelos, mes, dia), dia==1), n = 5)

vuelos %>% 
  count(mes, dia) %>%
  filter(dia == 1) %>%
  slice_head(n = 5)

# Ejercicio 1 -------------------------------------------------------------

# Obtenga las 100 primeras filas de vuelos
vuelos %>% slice_head(n = 100)

# Del dataframe vuelos, filtre las filas donde los meses estén entre enero y marzo
vuelos %>% filter(mes %in% 1:3)

# Filtre las filas donde la aerolinea sea UA o DL
vuelos %>% filter(aerolinea=="UA" | aerolinea=="DL")

# Use el mismo filtro anterior y agregue la condición de que el día sea igual a 12
vuelos %>% filter((aerolinea=="UA" | aerolinea=="DL") & dia == 12)

# Filtre la base donde el horario de salida este entre 500 y 1200, luego cuente el número
# de veces que aparece cada aerolinea
vuelos %>% filter(horario_salida %in% 500:1200) %>% 
  count(aerolinea)

# Utilice la misma anidación anterior pero ahora obtenga las cinco primeras filas
vuelos %>% filter(horario_salida %in% 500:1200) %>% 
  count(aerolinea) %>% 
  slice(1:5)


# Trabajo básico con columnas ---------------------------------------------

### Seleccionar columnas ###

# Por nombre 
vuelos %>% 
  select(aerolinea, vuelo)

# Por posición
vuelos %>% 
  select(1,3,5)

# Por rango
vuelos %>% 
  select(1:4)

# Por selección negativa
vuelos %>% 
  select(-4,-6)

# Por condiciones en el nombre
vuelos %>% 
  select(starts_with("horario"))

vuelos %>% 
  select(ends_with("programada"))

vuelos %>% 
  select(contains("_"))

### Renombrar columnas ###

vuelos %>% 
  rename(salida = horario_salida,
         llegada = horario_llegada)


# Ejercicio 2 -------------------------------------------------------------
# Cargue el excel "flores.xlsx" y llámelo flores
flores <- read_excel(flores, "clase_2/flores.xlsx")

# ¿Cuáles son los nombres de las columnas?
names(flores)

# Seleccione las columnas Especie y Largo.Petalo
flores %>% select(Especie, Largo.Petalo)

# Seleccione las mismas columnas usando su posición
flores %>% select(1,5)

# Seleccione las columnas que empiezan con "Largo"
flores %>% select(starts_with("Largo"))

# Seleccione las columnas que terminen con "Sepalo"
flores %>% select(ends_with("Sepalo"))

# Sleccione las columnas que no contengan "."
flores %>% select(!contains("."))


# Herramientas de edición de datos  --------------------------------------

### Mutate ###
# La función mutate() en R se utiliza para crear nuevas columnas o modificar las existentes 
# Por ejemplo, queremos crear una columna que sea la suma del atraso en la salida y el 
# atraso en la llegada llamada atraso_total

vuelos %>% 
  mutate(atraso_total = atraso_salida + atraso_llegada)

# Reemplazar la columna distancia por distancia/2

vuelos %>% 
  mutate(distancia = distancia/2)

# Otros ejemplos

vuelos %>% 
  mutate(distancia_promedio = mean(distancia, na.rm = TRUE),
         distancia_cuadrado = sqrt(distancia),
         origen_destino = paste(origen, destino, sep = "_"),
         atraso_salida_min = min(atraso_salida, na.rm = TRUE),
         atraso_llegada_max = max(atraso_llegada, na.rm = TRUE),
         aerolinea_minuscula = tolower(aerolinea))

### if_else ###

# Generar una columna llamado tramo que sea "largo" si el tiempo de vuelo fue mayor a
# 150, en caso contrario sea "corto" y si es NA "valor perdido.
# Modificar la variable tiempo_vuelo. Si un valor en esta columna es NA (valor perdido),
# se reemplaza por 0; de lo contrario, se mantiene el valor original

vuelos %>% 
  mutate(tramo = if_else(condition = tiempo_vuelo > 150, true = "largo", false = "corto", missing = "valor perdido"),
         tiempo_vuelo = if_else(is.na(tiempo_vuelo), 0, tiempo_vuelo))

# # Usando la base de vuelos generaremos una variable del tipo fecha
# # Queremos formar fechas del tipo "2013-02-12"
# 
# # Primero creamos las variables dia2 y mes2
# # Si la longitud de la variable "dia" o "mes" es igual a 1 (sólo tiene un dígito)
# # entonces agrega un "0" al principio, en caso contrario, convertir las variables en formato 
# # character
# 
# vuelos %>% select(dia, mes)
# 
# vuelos2 <- vuelos %>% vmesuelos2 <- vuelos %>% 
#   mutate(dia2 = if_else(nchar(dia) == 1, paste0("0", dia), as.character(dia)),
#          mes2 = if_else(nchar(mes) == 1, paste0("0", mes), as.character(mes)))
# 
# # Luego pegamos el año, el mes y el día usando como separador "-"
# 
# vuelos2 <- vuelos2 %>% 
#   mutate(fecha = paste(anio, mes2, dia2, sep = "-"))
# 
# vuelos2 <- vuelos2 %>% 
#   mutate(fecha = as.Date(fecha))

## case_when ##

# Usamos la función case_when cuando queremos generar o modificar una variable en base a más de una condición
# Ejemplo:

datos <- data.frame(puntuacion = c(80, 65, 90, 75, 50))
datos <- datos %>%
  mutate(resultado = case_when(
    puntuacion >= 90 ~ "A",
    puntuacion >= 80 ~ "B",
    puntuacion >= 70 ~ "C",
    TRUE ~ "F" # En caso de que ninguna de las condiciones anteriores se cumpla
  ))
datos

# Por ejemplo: queremos crear una variable con el nombre de los meses en el dataframe vuelos

vuelos <- vuelos <- vuelos %>% 
  mutate(mes_nombre = case_when(mes == 1 ~ "Enero",
                                mes == 2 ~ "Febrero",
                                mes == 3 ~ "Marzo",
                                mes == 4 ~ "Abril",
                                mes == 5 ~ "Mayo",
                                mes == 6 ~ "Junio",
                                mes == 7 ~ "Julio",
                                mes == 8 ~ "Agosto",
                                mes == 9 ~ "Septiembre",
                                mes == 10 ~ "Octubre",
                                mes == 11 ~ "Noviembre",
                                mes == 12 ~ "Diciembre"))

# Revisamos
vuelos %>% select(mes, mes_nombre) %>% 
  slice_sample(n = 10)

# Notas: 
# - Si no se cumple una condición, el valor asignado será NA
# - Las condiciones se evalúan en orden

# Otro ejemplo

vuelos <- vuelos %>% 
  mutate(tramo =  case_when(distancia >= 3000 ~ "largo",
                            distancia >= 1000 ~ "mediano",
                            TRUE ~ "corto")) %>% 
  select(distancia, tramo)

# Revisamos
vuelos %>% select(distancia, tramo) %>% 
  slice_sample(n = 10)


# Ejercicio 3 -------------------------------------------------------------

# Cargue la base "encuesta.xlsx" y guárdela como encuesta
encuesta <- read_excel("clase_2/encuesta.xlsx")

# Usando un solo mutate:
# - Modifique la columna horas_tv.Si horas tv es NA reemplazar por un 0; de lo contrario, se mantiene
# el valor original
# - Haga lo mismo para edad
# - Genere una columna llamada horas_tv_promedio que sea el promedio de horas_tv
# - Genere una columnna llamada mediana_edad que sea la mediana de la variable edad (la función es median())
# - Genere una columna llamada reglion_raza que sea la concatenación de la columna religion y raza, 
# usando como separador "-".
# - Genere una columna llamada tramo_edad que sea "Adulto mayor" cuando la edad sea mayor o igual que 50, 
# "Adulto" cuando la edad esté entre 20 y 49 y "Joven" cuando la edad sea menor que 20.

encuesta %>% mutate(horas_tv = if_else(is.na(horas_tv), 0, horas_tv),
                    edad = if_else(is.na(edad), 0, edad),
                    horas_tv_promedio = mean(horas_tv),
                    mediana_edad = median(edad),
                    religon_raza = paste(religion, raza, sep = "-"),
                    tramo_edad = case_when(edad >= 50 ~ "Adulto mayor",
                                           edad >= 20 ~ "Adulto",
                                           TRUE ~ "Joven")) 

# Tarea -------------------------------------------------------------------
# Cargue la base iac_division.rds
iac_division <- read_rds("clase_2/iac_division.rds")

# De ahora en adelante trabaje solamente usando el operador %>% 

# Obtenga las 10 primeras filas del dataframe
iac_division %>% slice_head(n = 10)

# Filtre por las filas donde el iac_div_46 fue mayor que 110
iac_division %>% filter(iac_div_46>110)

# Filtre las filas donde el año haya sido 2021 y el mes entre enero y diciembre
iac_division %>% filter(anio==2021 & mes_num %in% 1:12)

# Genere una nueva columna llamada iac_prom que sea el promedio del iac_general
iac_division %>% mutate(iac_prom = mean(iac_general))

# Genere una nueva columna llamada iac_rango  donde si el iac_general fue mayor que la mediana del iac_general,
# entonces iac_rango es igual a "alto" y en caso contrario fue "bajo"
iac_division2 %>% mutate(iac_rango = if_else(iac_general > median(iac_general), "alto", "bajo"))

# Utilizando la función case_when genere una nueva variable llamada mes_nombre que donde si el mes_num fue
# igual a 1 entonces es "Enero" y así hasta "Diciembre"
iac_division2 %>% 
  mutate(mes_nombre = case_when(mes_num == 1 ~ "Enero",
                                mes_num == 2 ~ "Febrero",
                                mes_num == 3 ~ "Marzo",
                                mes_num == 4 ~ "Abril",
                                mes_num == 5 ~ "Mayo",
                                mes_num == 6 ~ "Junio",
                                mes_num == 7 ~ "Julio",
                                mes_num == 8 ~ "Agosto",
                                mes_num == 9 ~ "Septiembre",
                                mes_num == 10 ~ "Octubre",
                                mes_num == 11 ~ "Noviembre",
                                mes_num == 12 ~ "Diciembre"))

# iac_division2 %>% mutate(fecha = paste(anio, mes_num, 1, sep = "-"))
# 
# iac_division2 <- iac_division2 %>% mutate(fecha = as.Date(fecha))

encuesta %>% filter(religion == "Cristiana")

encuesta %>% filter(religion == "Cristiana" & estado_civil == "Nunca se ha casado")

encuesta %>% select(1:4)

encuesta %>% filter(horas_tv %in% 2:5)

encuesta %>% mutate(horas_tv = if_else(is.na(horas_tv), 0, horas_tv),
                    horas_tv_promedio = mean(horas_tv))

encuesta %>% mutate(tramo_edad = case_when(edad < 20 ~ "Joven",
                                           edad >= 20 & edad <= 50 ~ "Adulto",
                                           edad > 50 ~ "Viejo"))


flores2 <- flores %>% mutate(ancho_petalo_prom = mean(Ancho.Petalo))

flores2 <- flores %>% mutate(largo_sepalo_tramo = if_else(Largo.Sepalo >= 5.8, "largo", "bajo"))