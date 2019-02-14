#'Descarga de Bases de EPH
#'@description
#'Función que descarga bases de la Encuesta Permanente de Hogares del INDEC a partir de 2016
#'@param anio: un integer entre 2016:2018
#'@param trimestre: un integer con el numero de trimestre: 1,2,3,4
#'@param etiqueta: TRUE/FALSE, opcion para etiquetar los datos
#'@details
#'disclaimer: El script no es un producto oficial de INDEC.
#'
#'@examples
#'
#'base <- get_bases_eph0307(anio = 2018, trimestre = 1, etiqueta = FALSE)
#'base_individual <- base[['base_individual']]
#'base_hogar <- base[['base_hogar']]
#'
#'@export
get_bases_eph0307 <- function(anio = 2003, trimestre = 3,etiqueta = FALSE){

  #controles de los parametros
  assertthat::assert_that(is.numeric(anio))
  assertthat::assert_that(is.numeric(trimestre))
  assertthat::assert_that(assertthat::is.flag(etiqueta), msg = "Por favor ingresa TRUE o FALSE")
  assertthat::assert_that(trimestre %in% 1:4, msg = "Por favor ingresa un numero de trimeste valido: 1,2,3,4")

  assertthat::assert_that(anio>=2017                      |
                          (anio==2016 &trimestre %in% 2:4)|
                          (anio %in% 2004:2006)           |
                          (anio == 2007 &trimestre == 1)  |
                          (anio == 2003 &trimestre %in% 3:4)
                            ,msg = "Esta funcion solo es valida para las bases comprendidas entre el
                          3er trimestre de 2003 y el primero del 2007, o a partir del 2do trimestre de 2016 ")

 if (anio >= 2016){
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

  }

  if (anio  %in% 2003:2007){
    link_base = 'https://www.indec.gob.ar/dbindec/'

      if ( anio >= 2005                      |
        (anio == 2004 & trimestre %in% 3:4)|
        (anio == 2003 & trimestre==3)
        ) {

    link = paste0(link_base,"USU_T",trimestre,substr(anio,3,4),".ZIP")

    }
    if (anio == 2004 & trimestre %in% 1:2){

    link = paste0(link_base,"EPH_PREL_USU_T",trimestre,substr(anio,3,4),".ZIP")

    }

    if (anio == 2003 & trimestre == 4){

    link = paste0(link_base,"USU_",trimestre,substr(anio,3,4),".ZIP")

    }


  }

  temp <- tempfile()

  check <- NA
  try(check <- utils::download.file(link,temp,method = 'libcurl'),silent = TRUE)
  assertthat::assert_that(assertthat::noNA(check),msg = "problema con la descarga. Posiblemente un error de la conexion a internet")

  nombres <- purrr::as_vector(utils::unzip(temp, list = TRUE)['Name'])
  base_hogar_name <- nombres[stringr::str_detect(nombres, 'hog')|
                            stringr::str_detect(nombres, 'USH')|
                            stringr::str_detect(nombres, 'HOG')]
  base_individual_name <- nombres[stringr::str_detect(nombres, 'ind')|
                                  stringr::str_detect(nombres, 'USP')|
                                  stringr::str_detect(nombres, 'PER')]


  if(anio >= 2016){
  base_individual <- utils::read.table(unz(temp,base_individual_name), sep=";", dec=",", header = TRUE, fill = TRUE)
  }

  if(anio < 2016){
    dir.create(temp,showWarnings = F)
    utils::unzip(zipfile = temp,exdir =  tempdir())

  base_individual <- foreign::read.dbf(paste0(tempdir(),'/',base_individual_name))
  }


if (etiqueta == TRUE) {
    base_individual <- put_labels_eph(base_individual, base = 'individual')
  }


  if(anio >= 2016){
  base_hogar <- utils::read.table(unz(temp,base_hogar_name), sep=";", dec=",", header = TRUE, fill = TRUE)
  }

  if(anio < 2016){
    base_hogar <- foreign::read.dbf(paste0(tempdir(),'/',base_hogar_name))
  }


    if (etiqueta == TRUE) {
    base_hogar <- put_labels_eph(base_hogar, base = 'hogar')
  }

  unlink(temp)
  bases <- list("base_hogar"=base_hogar,"base_individual"=base_individual)

}


