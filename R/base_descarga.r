
### El paquete 'pacman' carga e instala (si no está aún instalado) el paquete que indicamos en la función 'p_load'.
require(pacman)
p_load(tidyverse, expss)

# Función que descarga bases de la página de indec, según el nombre que le pusieron al zip.
descarga_base <- function(base = 'EPH_usu_2_Trim_2017_txt.zip', individual = FALSE, hogar = FALSE){
  
  link = paste0('https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/', base)
  temp <- tempfile()
  download.file(link,temp)
  nombres <- as_vector(unzip(temp, list = TRUE)['Name'])
  base_hogar_name <- nombres[str_detect(nombres, 'hog')]
  base_individual_name <- nombres[str_detect(nombres, 'ind')]
  
  if (individual) {
    base_individual <<- read.table(unz(temp,base_individual_name), sep=";", dec=",", header = TRUE, fill = TRUE)
    source("https://github.com/pablinte/eph/raw/master/R/etiquetas_eph_ind_2018.R", encoding="UTF-8")
    
  }
  if (hogar) {
    base_hogar <<- ?read.table(unz(temp,base_hogar_name), sep=";", dec=",", header = TRUE, fill = TRUE)
    source("https://github.com/pablinte/eph/raw/master/R/etiquetas_eph_hog_2018.R", encoding="UTF-8")
  }
  unlink(temp)

}






