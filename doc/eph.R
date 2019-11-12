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

## ------------------------------------------------------------------------
library(eph)
library(tidyverse)

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
bases <- list(i_2018_1=get_microdata(year=2018, trimester=1, type='individual'),
              i_2018_2=get_microdata(year=2018, trimester=2, type='individual'),
              i_2018_3=get_microdata(year=2018, trimester=3, type='individual'),
              i_2018_4=get_microdata(year=2018, trimester=4, type='individual')
)


## ------------------------------------------------------------------------
pool <- organize_panels(bases=bases, variables=c('ESTADO'),
                        window='anual')

## ------------------------------------------------------------------------
pool

## ------------------------------------------------------------------------


## ----message=FALSE, warning=FALSE----------------------------------------
year <- 2004:2018
trimester <- 1:4
wave<-NA
type<-'individual'

df <- as_tibble(expand.grid(year, trimester, wave, type))
colnames(df)<-c('year','trimester','wave', 'type')

get_data <- function(year, trimester, wave=NA, type){
  indicator<-list()  
  d <- get_microdata(year=year, 
                     trimester=trimester, 
                     type=type, 
                     wave=wave)

  indicator$year<-year
  indicator$trimester<-trimester

  if (nrow(d) == 0){ 
    indicator$indic<-NA
  }
                
  if (year==2007 & (trimester ==2 | trimester == 4)) {
    indicator$ind<-sum(d[d$cat_ocup==2,]$pondera, na.rm=TRUE) /sum(d[d$estado==1,]$pondera, na.rm=TRUE)
  }
                
  else {
    indicator$ind<-sum(d[d$CAT_OCUP==2,]$PONDERA, na.rm=TRUE) /sum(d[d$ESTADO==1,]$PONDERA, na.rm=TRUE)
  }
  return(indicator)
}

df <- df %>%
    dplyr::mutate(microdata=
      purrr::pmap(list('year' = year,
                       'trimester' = trimester,
                       'wave' = wave,
                       'type' = type),
                  .f = get_data) 
                  )



## ------------------------------------------------------------------------
df %>% 
  select(microdata) %>% 
  map_df(.,bind_rows) %>% 
  select(-indic) %>%
  mutate(date=lubridate::parse_date_time(paste(year, trimester,sep='-'), '%y%q')) %>%
  ggplot() + 
    geom_line(aes(x=date,y=ind), color='blue') +
    scale_y_continuous(limits=c(0,0.3)) +
    labs(y='% TCP sobre ocupados')


## ----eval=FALSE, include=FALSE-------------------------------------------
#  years <- 2011:2018
#  trims <- 1:4
#  
#  indicator<-matrix(nrow=length(years) * length(trims), ncol=3)
#  i<-0
#  for (y in years){
#          for (t in trims){
#                  i<-i+1
#                  d<-get_microdata(year=y, trimester = t) %>%
#                    organize_labels(.)
#  
#                  indicator[i,1]<-y
#                  indicator[i,2]<-t
#  
#                  if (nrow(d) == 0){
#                    indicator[i,3]<-NA
#                  }
#  
#                  if (y==2007 & (t ==2 | t == 4)) {
#                    indicator[i,3]<-sum(d[d$cat_ocup==2,]$pondera, na.rm=TRUE) /sum(d[d$estado==1,]$pondera, na.rm=TRUE)
#                  }
#  
#                  else {
#                  indicator[i,3]<-sum(d[d$CAT_OCUP==2,]$PONDERA, na.rm=TRUE) /sum(d[d$ESTADO==1,]$PONDERA, na.rm=TRUE)
#                  }
#        }
#  }
#  
#  indicator<-as.data.frame(indicator)
#  colnames(indicator)<-c('year', 'trim', 'ind')
#  
#  indicator <- indicator %>%
#    mutate(fecha = lubridate::parse_date_time(paste(indicator$year, indicator$trim, sep='-'), "%y%q"))
#  
#  
#  ggplot(data=indicator) +
#          geom_line(aes(x=fecha,y=ind), color='red') +
#          scale_y_continuous(limits=c(0,0.35)) +
#          labs(y='Tasa de TCP / Ocupados')
#  

## ----message=FALSE, warning=FALSE----------------------------------------
bases <- dplyr::bind_rows(toybase_individual_2016_03,toybase_individual_2016_04)


## ------------------------------------------------------------------------
lineas <- get_poverty_lines()
lineas %>% head()

## ------------------------------------------------------------------------
lineas %>%
  select(-ICE) %>%
  gather(canasta, valor, -periodo) %>%
  ggplot() +
    geom_line(aes(x=periodo, y=valor, col=canasta))

## ------------------------------------------------------------------------
canastas_reg_example

## ------------------------------------------------------------------------
adulto_equivalente

## ----warning=FALSE-------------------------------------------------------

bases <- dplyr::bind_rows(toybase_individual_2016_03,toybase_individual_2016_04)
base_pobreza <- calculate_poverty(base = bases, basket = canastas_reg_example,print_summary=TRUE)


## ------------------------------------------------------------------------
base_pobreza %>% 
  select(CODUSU,ITF,region,adequi_hogar,CBA_hogar,CBT_hogar,situacion) %>% 
  sample_n(10)

