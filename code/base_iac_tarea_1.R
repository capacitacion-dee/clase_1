


iac_division <- read_excel("data/descargas/series-mensuales-desde-enero-de-2018-a-la-fecha.xls", sheet = 3, skip = 5)

iac_division <- iac_division %>% slice(1:72)

iac_division <- iac_division %>% select(-...1)

iac_division <- iac_division %>% select(`Mes y año`,`Índice general`,`Índice división 45`,
                                        `Índice división 46`,`Índice división 47`) %>% 
  rename(mes_anio = `Mes y año`,
         iac_general = `Índice general`,
         iac_div_45 = `Índice división 45`,
         iac_div_46 = `Índice división 46`,
         iac_div_47 = `Índice división 47`) %>% 
  mutate(mes = str_sub(mes_anio, 1, 3),
         anio = str_sub(mes_anio, 5, 6),
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
         fecha = ym(paste0(anio,"-",mes_num))) %>% 
  select(anio, mes_num, iac_general, iac_div_45, iac_div_46, iac_div_47) %>% 
  as.data.frame()

write_rds(iac_division, "data/iac_division.rds")

