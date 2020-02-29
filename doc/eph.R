## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE, message=FALSE, warning=FALSE, include=TRUE--------------
#  install.packages('eph')

## ---- eval=FALSE, message=FALSE, warning=FALSE, include=TRUE-------------
#  # install.packages('devtools') si no tiene instalado devtools
#  
#  devtools::install_github("holatam/eph")

## ----message=FALSE, warning=FALSE----------------------------------------
library(eph)
library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)

## ------------------------------------------------------------------------
ind_3_18 <- get_microdata(year=2018, trimester=2, type='individual')

## ----message=FALSE, warning=FALSE----------------------------------------
ind_2_02 <- get_microdata(year=2001, wave=2, type='individual')

## ------------------------------------------------------------------------
ind_3_18 <- organize_labels(df=ind_3_18, type='individual')

## ------------------------------------------------------------------------
hog_3_18 <- get_microdata(year=2018, trimester=3, type='hogar') %>%
              organize_labels(., type='hogar')

## ------------------------------------------------------------------------
calculate_tabulates(base=ind_3_18, x='ESTADO', y='CH04', weights = 'PONDIH',
                    add.totals='row', add.percentage='col')

## ------------------------------------------------------------------------
calculate_tabulates(base=ind_3_18, x='ESTADO', y='CH04',
                    add.totals='row', add.percentage='col')

## ------------------------------------------------------------------------
bases <- get_microdata(year=2018, trimester=1:4, type='individual', 
                       vars = c('CODUSU','NRO_HOGAR','COMPONENTE','ANO4','TRIMESTRE','CH04','CH06', #variables necesarias para hacer el panel
                                'ESTADO','PONDERA') ) #variables que nos interesan en nuestro análisis
bases

## ----warning=FALSE-------------------------------------------------------
pool <- organize_panels(bases=bases$microdata, variables=c('ESTADO','PONDERA'),
                        window='trimestral')

## ------------------------------------------------------------------------
pool

## ----message=FALSE, warning=FALSE----------------------------------------
pool %>% 
  organize_labels(.) %>% 
calculate_tabulates(x='ESTADO', y='ESTADO_t1',
                    weights = "PONDERA", add.percentage='row')

## ----message=FALSE, warning=FALSE----------------------------------------
df <- get_microdata(year = 2017:2019, trimester = 1:4,type = 'individual',
                    vars = c('PONDERA','ESTADO','CAT_OCUP')) %>% 
  unnest()

df %>% 
  sample_n(5)

## ------------------------------------------------------------------------
df <- df %>% 
  group_by(year,trimester) %>% 
  summarise(indicador = sum(PONDERA[CAT_OCUP==3 & ESTADO==1], na.rm = T) / sum(PONDERA[ESTADO==1], na.rm = T)) 
df

## ----message=FALSE, warning=FALSE----------------------------------------
bases <- dplyr::bind_rows(toybase_individual_2016_03,toybase_individual_2016_04)

## ------------------------------------------------------------------------
lineas <- get_poverty_lines()
lineas %>% head()

## ---- fig.width=7, fig.height=5------------------------------------------
lineas %>%
  select(-ICE) %>%
  gather(canasta, valor, -periodo) %>%
  ggplot() +
    geom_line(aes(x=periodo, y=valor, col=canasta))

## ------------------------------------------------------------------------
canastas_reg_example %>% head()

## ------------------------------------------------------------------------
adulto_equivalente %>% head()

## ----warning=FALSE-------------------------------------------------------
bases <- dplyr::bind_rows(toybase_individual_2016_03,toybase_individual_2016_04)
base_pobreza <- calculate_poverty(base = bases, basket = canastas_reg_example,print_summary=TRUE)

## ------------------------------------------------------------------------
base_pobreza %>% 
  select(CODUSU,ITF,region,adequi_hogar,CBA_hogar,CBT_hogar,situacion) %>% 
  sample_n(10)

