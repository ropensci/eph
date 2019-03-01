#'Descarga de Bases de EPH
#'@description
#'Función que descarga bases de la Encuesta Permanente de Hogares del INDEC a partir de 2003
#'@param year un integer a partir de 2003
#'@param trimester un integer con el numero de trimester: 1,2,3,4
#'@param type tipo de base a descargar: 'individual' ; 'hogar'
#'@param labels TRUE/FALSE, opcion para labelsr los datos
#'@details
#'disclaimer: El script no es un producto oficial de INDEC.
#'
#'@examples
#'
#'base_individual <- get_microdata(year = 2018, trimester = 1,type='individual', labels = FALSE)
#'base_hogar <- get_microdata(year = 2018, trimester = 1,type='hogar', labels = FALSE)
#'
#'@export

get_microdata <- function(year = 2018, trimester = 1,type='individual',labels = FALSE){

    #controles de los parametros
    assertthat::assert_that(is.numeric(year))
    assertthat::assert_that(is.numeric(trimester))
    assertthat::assert_that(assertthat::is.flag(labels), msg = "Por favor ingresa TRUE o FALSE")
    assertthat::assert_that(trimester %in% 1:4, msg = "Por favor ingresa un numero de trimeste valido: 1,2,3,4")

    link = glue::glue('https://github.com/rindec/data/raw/master/eph/{type}/base_{type}_{year}T{trimester}.RDS')

    temp <- glue::glue('{tempfile()}.RDS')

    check <- NA

    try(check <- utils::download.file(link, destfile = temp),silent = TRUE)

    assertthat::assert_that(assertthat::noNA(check),msg = "problema con la descarga. Posiblemente un error de la conexion a internet")

    base <- readr::read_rds(temp)
    unlink(temp)
    base
  }
