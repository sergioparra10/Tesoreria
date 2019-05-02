#######################################################
### Tesoreria
#######################################################

### Librerias ----
library(dplyr)
library(readxl)
library(tidyverse)
library(stargazer)
library(stats)
library(ggthemes)
library(aTSA)
library(xtable)
library(read.csv)
library(magrittr)
library(haven)
library(sjlabelled)
library(tis)
options(scipen = 1000000) #Prevenir Notacion Cientifica
Sys.setlocale("LC_ALL", "es_ES.UTF-8") #Permitir Acentos


### Base de datos: ----

pagos <- read_dta("Tesoreria/Bases de datos/2019.dta")
View(pagos)

#Quitamos todas las observaciones que sean del 2019
#perini significa al numero de pagos de ese año 
table(pagos$perini)

#me quedo con los que pagaron en el 2019
pagos2019 <- pagos %>% 
  filter((perini == 2019)) %>% 
  mutate("2019" = case_when(
    perini == 2019 ~ 1 ))

pagos <- pagos %>% 
  mutate("2019" = case_when(
    perini == 2019 ~ 1,
    perini <  2019 ~ 0))

colnames(pagos)

padron <- read_dta("Tesoreria/Bases de datos/padron_impuesto_sobre_tenencia_o_uso_de_vehiculos_2019asdasd.dta", encoding='latin1')

View(padron)

#Hacemos el Merge por el numero de placa eliminamos todas las observaciones que no hicieron match
tenencia <- merge(pagos, padron,by="nplaca")


table(pagos$`2019`)

tenencia2019 <- merge(pagos2019, padron, by = "nplaca", all = TRUE)
#tenencia2019 <- merge(pagos2019, padron, by = "nplaca", all.y = TRUE)

#Reemplazamos NA, es decir, los que no han pagado 2019 por un 0 
tenencia2019$`2019`[is.na(tenencia2019$`2019`)] <- 0



table(tenencia2019$`2019`)
sum(is.na(tenencia2019$`2019`))






