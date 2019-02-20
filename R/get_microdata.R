#'Descarga de Bases de EPH
#'@description
#'Función que descarga bases de la Encuesta Permanente de Hogares del INDEC a partir de 2016
#'@param year un integer entre 2016:2018
#'@param trimester un integer con el numero de trimester: 1,2,3,4
#'@param labels TRUE/FALSE, opcion para labelsr los datos
#'@details
#'disclaimer: El script no es un producto oficial de INDEC.
#'
#'@examples
#'
#'base <- get_microdata(year = 2018, trimester = 1, labels = FALSE)
#'base_individual <- base[['base_individual']]
#'base_hogar <- base[['base_hogar']]
#'
#'@export
get_microdata <- function(year = 2018, trimester = 1,labels = FALSE){

  #controles de los parametros
  assertthat::assert_that(is.numeric(year))
  assertthat::assert_that(is.numeric(trimester))
  assertthat::assert_that(assertthat::is.flag(labels), msg = "Por favor ingresa TRUE o FALSE")
  assertthat::assert_that(trimester %in% 1:4, msg = "Por favor ingresa un numero de trimeste valido: 1,2,3,4")

  assertthat::assert_that(year>=2016,msg = "Esta funcion solo es valida para las bases a partir de 2016")


  if (year == 2016 | (year == 2017 & trimester ==1)){
    if (trimester == 1){
      trimester <- "1ro"}
    if (trimester == 2){
      trimester <- "2do"}
    if (trimester == 3){
      trimester <- "3er"}
    if (trimester == 4){
      trimester <- "4to"}

  base = paste0("EPH_usu_", trimester, "Trim_", year, "_txt.zip")
  }
  #'@description
  #'Función que descarga bases de la Encuesta Permanente de Hogares del INDEC a partir de 2016
  #'@param year: un integer entre 2016:2018
  #'@param trimester: un integer con el numero de trimester: 1,2,3,4
  #'@param labels: TRUE/FALSE, opcion para labelsr los datos
  #'@details
  #'disclaimer: El script no es un producto oficial de INDEC.
  #'
  #'@examples
  #'
  #'base <- get_microdata(year = 2018, trimester = 1, labels = FALSE)
  #'base_individual <- base[['base_individual']]
  #'base_hogar <- base[['base_hogar']]
  #'
  #'@export
  get_microdata <- function(year = 2018, trimester = 1,labels = FALSE){

    #controles de los parametros
    assertthat::assert_that(is.numeric(year))
    assertthat::assert_that(is.numeric(trimester))
    assertthat::assert_that(assertthat::is.flag(labels), msg = "Por favor ingresa TRUE o FALSE")
    assertthat::assert_that(trimester %in% 1:4, msg = "Por favor ingresa un numero de trimeste valido: 1,2,3,4")

    assertthat::assert_that(year>=2016,msg = "Esta funcion solo es valida para las bases a partir de 2016")


    if (year == 2016 | (year == 2017 & trimester ==1)){
      if (trimester == 1){
        trimester <- "1ro"}
      if (trimester == 2){
        trimester <- "2do"}
      if (trimester == 3){
        trimester <- "3er"}
      if (trimester == 4){
        trimester <- "4to"}

      base = paste0("EPH_usu_", trimester, "Trim_", year, "_txt.zip")
    }

    if (year >= 2018 | (year == 2017 & trimester >=2)){
      base = paste0("EPH_usu_", trimester, "_Trim_", year, "_txt.zip")
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
    if (labels == TRUE) {
      base_individual <- put_labels_eph(base_individual, base = 'individual')
    }

    base_hogar <- utils::read.table(unz(temp,base_hogar_name), sep=";", dec=",", header = TRUE, fill = TRUE)
    if (labels == TRUE) {
      base_hogar <- put_labels_eph(base_hogar, base = 'hogar')
    }

    unlink(temp)
    bases <- list("base_hogar"=base_hogar,"base_individual"=base_individual)

  }

  if (year >= 2018 | (year == 2017 & trimester >=2)){
  base = paste0("EPH_usu_", trimester, "_Trim_", year, "_txt.zip")
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
  if (labels == TRUE) {
    base_individual <- put_labels_eph(base_individual, base = 'individual')
  }

  base_hogar <- utils::read.table(unz(temp,base_hogar_name), sep=";", dec=",", header = TRUE, fill = TRUE)
  if (labels == TRUE) {
    base_hogar <- put_labels_eph(base_hogar, base = 'hogar')
  }

  unlink(temp)
  bases <- list("base_hogar"=base_hogar,"base_individual"=base_individual)

}
