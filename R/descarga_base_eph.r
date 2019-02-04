# Función que descarga bases de la página de indec, según el nombre que le pusieron al zip.
descarga_base_eph <- function(anio = 2018, trimestre = 1, individual = FALSE, hogar = FALSE,
                          etiqueta = FALSE){
  
  ### El paquete 'pacman' carga e instala (si no está aún instalado) el paquete que indicamos en la función 'p_load'.
if(!require(pacman))install.packages("pacman")

pacman::p_load(tidyverse, expss, httr, stringr, haven, readxl)
  
  if (anio == 2016 | (anio == 2017 & trimestre ==1)){
    if (trimestre == 1){
      trimestre <- "1ro"}
    if (trimestre == 2){
      trimestre <- "2do"}
    if (trimestre == 3){
      trimestre <- "3er"}
    if (trimestre == 4){
      trimestre <- "4to"}
    
  base = paste0("EPH_usu_", trimestre, "Trim_", anio, "_txt.zip")
  }
  
  if (anio >= 2018 | (anio == 2017 & trimestre >=2)){
  base = paste0("EPH_usu_", trimestre, "_Trim_", anio, "_txt.zip")
  }
  
  link = paste0('https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/', base)
  temp <- tempfile()
  download.file(link,temp)
  nombres <- as_vector(unzip(temp, list = TRUE)['Name'])
  base_hogar_name <- nombres[str_detect(nombres, 'hog')]
  base_individual_name <- nombres[str_detect(nombres, 'ind')]
  
  if (individual == TRUE) {
    base_individual <<- read.table(unz(temp,base_individual_name), sep=";", dec=",", header = TRUE, fill = TRUE)
    if (etiqueta == TRUE) {
      source("https://github.com/pablinte/eph/raw/master/R/etiquetas_eph_ind_2018.R", encoding="UTF-8")
    } 
  }
  
  if (hogar == TRUE) {
    base_hogar <<- read.table(unz(temp,base_hogar_name), sep=";", dec=",", header = TRUE, fill = TRUE)
    if (etiqueta == TRUE) {
      source("https://github.com/pablinte/eph/raw/master/R/etiquetas_eph_hog_2018.R", encoding="UTF-8")
    } 
  }
  
  unlink(temp)
  
}
