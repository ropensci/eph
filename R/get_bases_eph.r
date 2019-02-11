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
#'base <- get_bases_eph(anio = 2018, trimestre = 1, etiqueta = FALSE)
#'
#'@export
get_bases_eph <- function(anio = 2018, trimestre = 1,etiqueta = FALSE){

  #controles de los parametros
  assertthat::assert_that(is.numeric(anio))
  assertthat::assert_that(is.numeric(trimestre))
  assertthat::assert_that(assertthat::is.flag(etiqueta), msg = "Por favor ingresa TRUE o FALSE")
  assertthat::assert_that(trimestre %in% 1:4, msg = "Por favor ingresa un numero de trimeste valido: 1,2,3,4")

  assertthat::assert_that(anio>=2016,msg = "Esta funcion solo es valida para las bases a partir de 2016")


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

  check <- NA
  try(check <- utils::download.file(link,temp,method = 'libcurl'),silent = TRUE)
  assertthat::assert_that(assertthat::noNA(check),msg = "problema con la descarga. Posiblemente un error de la conexion a internet")

  nombres <- purrr::as_vector(utils::unzip(temp, list = TRUE)['Name'])
  base_hogar_name <- nombres[stringr::str_detect(nombres, 'hog')]
  base_individual_name <- nombres[stringr::str_detect(nombres, 'ind')]

  base_individual <- utils::read.table(unz(temp,base_individual_name), sep=";", dec=",", header = TRUE, fill = TRUE)
  if (etiqueta == TRUE) {
    base_individual <- put_labels_eph(base_individual, base = 'individual')
  }

  base_hogar <- utils::read.table(unz(temp,base_hogar_name), sep=";", dec=",", header = TRUE, fill = TRUE)
  if (etiqueta == TRUE) {
    base_hogar <- put_labels_eph(base_hogar, base = 'hogar')
  }

  unlink(temp)
  bases <- list("base_hogar"=base_hogar,"base_individual"=base_individual)

}
