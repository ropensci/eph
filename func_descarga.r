# rm(list = ls())
library(tidyverse)
library(httr)
library(stringr)
library(haven)
library(readxl)


# Función que descarga bases de la página de indec, según el nombre que le pusieron al zip.
descarga_ultima_base <- function(base = 'EPH_usu_2_Trim_2017_txt.zip', individual = FALSE, hogar = FALSE){
  
  link = paste0('https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/', base)
  temp <- tempfile()
  download.file(link,temp)
  nombres <- as_vector(unzip(temp, list = TRUE)['Name'])
  base_hogar_name <- nombres[str_detect(nombres, 'hog')]
  base_individual_name <- nombres[str_detect(nombres, 'ind')]
  
  if (individual) {
    base_individual <<- read.table(unz(temp,base_individual_name), sep=";", dec=",", header = TRUE, fill = TRUE)
    source("https://github.com/pablinte/eph/raw/master/etiquetas_b_usu_IND_eph.r")
    
  }
  if (hogar) {
    base_hogar <<- ?read.table(unz(temp,base_hogar_name), sep=";", dec=",", header = TRUE, fill = TRUE)
    source("https://github.com/pablinte/eph/raw/master/etiquetas_b_usu_HOG_eph_1t_18.R")
  }
  unlink(temp)

}






