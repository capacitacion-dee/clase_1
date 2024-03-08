library(readxl)
library(tidyverse)
library(stringr)
library(lubridate)

iac <- read_excel("data/descargas/series-mensuales-desde-enero-de-2018-a-la-fecha.xls", sheet = 2, skip = 4,
                  col_types = c("text", "text", rep("numeric", 4)))

iac$`Diciembre 2023` <- NULL

iac <- iac[3:73,]

iac <- iac %>% 
  rename(fecha = ...2,
         iac = ...3,
         var_mensual = ...4,
         var_anual = ...5,
         var_acumulada = ...6)

iac <- iac %>% 
  mutate(mes = str_sub(fecha, 1, 3),
         anio = str_sub(fecha, 5, 6),
         mes_num = case_when(mes == "ene" ~ 1,
                             mes == "feb" ~ 2,
                             mes == "mar" ~ 3,
                             mes == "abr" ~ 4,
                             mes == "may" ~ 5,
                             mes == "jun" ~ 6,
                             mes == "jul" ~ 7,
                             mes == "ago" ~ 8,
                             mes == "sep" ~ 9,
                             mes == "oct" ~ 10,
                             mes == "nov" ~ 11,
                             mes == "dic" ~ 12),
         anio = as.numeric(paste0("20",anio)))

iac %>% group_by(anio) %>% 
  summarise(prom = mean(iac))

iac_division <- read_excel("data/descargas/series-mensuales-desde-enero-de-2018-a-la-fecha.xls", sheet = 3, skip = 5)

iac_division <- iac_division %>% slice(1:72)

iac_division <- iac_division %>% select(-...1)

iac_division <- iac_division %>% select(-starts_with("Variación")) %>% 
  pivot_longer(starts_with("Índice"), names_to = "indice", values_to = "valor") %>% 
  mutate(indice = case_when(indice == "Índice general" ~ "indice_general",
                            indice == "Índice división 45" ~ "indice_45",
                            indice == "Índice división 46" ~ "indice_46",
                            indice == "Índice división 47" ~ "indice_47")) %>% 
  rename(fecha = `Mes y año`) %>% 
  mutate(mes = str_sub(fecha, 1, 3),
         anio = str_sub(fecha, 5, 6),
         mes_num = case_when(mes == "ene" ~ 1,
                             mes == "feb" ~ 2,
                             mes == "mar" ~ 3,
                             mes == "abr" ~ 4,
                             mes == "may" ~ 5,
                             mes == "jun" ~ 6,
                             mes == "jul" ~ 7,
                             mes == "ago" ~ 8,
                             mes == "sep" ~ 9,
                             mes == "oct" ~ 10,
                             mes == "nov" ~ 11,
                             mes == "dic" ~ 12),
         anio = as.numeric(paste0("20",anio)),
         fecha_formato = ym(paste0(anio,"-",mes_num))) %>% 
  as.data.frame()

write_rds(iac_division, "data/iac_division.rds")

iac_division  %>%
  ggplot()+
  aes(x = fecha_formato, y = valor, group=indice, fill=indice, color=indice) +
  geom_line(size = 1)+
  scale_fill_brewer(palette = "Set1") +
  scale_color_brewer(palette = "Set1") +
  theme_bw()


