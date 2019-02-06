#'Función que descarga bases de la página de indec, según el nombre que le pusieron al zip.
#'@description
#' El primer uso puede tomarse un tiempito (dependiendo tu compu / conexión) para instalar aquellos paquetes que aún no
#'tengas instalados. El segundo uso apenas tomará unos segundos.
#'
#'@param
#'anio: un integer entre 2016:2018
#'trimestr: un integer con el numero de trimestre: 1,2,3,4
#'etiqueta: TRUE/FALSE, opcion para etiquetar los datos
#'@details
#'disclaimer: El script no es un producto oficial de INDEC.
#'
#'@example
#'descarga_base_eph(anio = 2018, trimestre = 1, etiqueta = FALSE)
#'
descarga_base_eph <- function(anio = 2018, trimestre = 1,etiqueta = FALSE){

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
  try(check <- download.file(link,temp),silent = TRUE)
  assertthat::assert_that(assertthat::noNA(check),msg = "problema con la descarga. Posiblemente un error de la conexion a internet")

  nombres <- purrr::as_vector(unzip(temp, list = TRUE)['Name'])
  base_hogar_name <- nombres[str_detect(nombres, 'hog')]
  base_individual_name <- nombres[str_detect(nombres, 'ind')]

  base_individual <- read.table(unz(temp,base_individual_name), sep=";", dec=",", header = TRUE, fill = TRUE)
  if (etiqueta == TRUE) {
    source("https://github.com/pablinte/eph/raw/master/R/etiquetas_eph_ind_2018.R", encoding="UTF-8")
  }

  base_hogar <- read.table(unz(temp,base_hogar_name), sep=";", dec=",", header = TRUE, fill = TRUE)
  if (etiqueta == TRUE) {
    source("https://github.com/pablinte/eph/raw/master/R/etiquetas_eph_hog_2018.R", encoding="UTF-8")
  }

  unlink(temp)
  bases <- list("base_hogar"=base_hogar,"base_individual"=base_individual)

}
