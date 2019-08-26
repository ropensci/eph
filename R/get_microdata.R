#'Descarga de Bases de EPH
#'@description
#'Funcion que descarga bases de la Encuesta Permanente de Hogares del INDEC a partir de 1996
#'@param year un integer a partir de 2003
#'@param trimester un integer con el numero de trimester: 1,2,3,4, para la EPH continua
#'@param wave un integer con el numero de onda, 1 o 2, para la EPH puntual
#'@param type tipo de base a descargar: 'individual' ; 'hogar', default individual
#'@details
#'Las bases de la EPH puntual utilizan el parametro wave, para referirse a las ondas.
#'Su alcance es entre la onda 1 de 1996 y a onda 1 de 2003.
#'
#'Las bases de la EPH continua utiliza el parametro trimester, para referirse a los trimestres.
#'Su alcance es entre tercer trimestre de 2003 a la actualidad
#'disclaimer: El script no es un producto oficial de INDEC.
#'
#'@examples
#'
#'base_individual <- get_microdata(year = 2018, trimester = 1,type='individual')
#'
#'@export

get_microdata <- function(year = 2018,
                          trimester = NA,
                          wave = NA,
                          type='individual'){

    #controles de los parametros
    assertthat::assert_that(is.numeric(year))
    assertthat::assert_that((is.numeric(trimester)|is.numeric(wave)))
    # assertthat::assert_that(assertthat::is.flag(labels), msg = "Por favor ingresa TRUE o FALSE")
    assertthat::assert_that((is.na(trimester)|is.na(wave)), msg = 'por favor seleccionar onda o trimestre, no ambas')
    if (!is.na(trimester)) {
    assertthat::assert_that(trimester %in% 1:4, msg = "Por favor ingresa un numero de trimeste valido: 1,2,3,4")
    }
    if (!is.na(wave)) {
      assertthat::assert_that(wave %in% 1:2, msg = "Por favor ingresa un numero de onda valido: 1,2")
    }
    assertthat::assert_that(type %in% c('individual','hogar'))
    if (year<2003) {
      assertthat::assert_that(!is.na(wave), msg='para antes de 2003, es necesario definir la onda (wave) de la EPH puntual')
      link = glue::glue('https://github.com/rindec/data/raw/master/eph/{type}/base_{type}_{year}O{wave}.RDS')
    }else
    if (year>2003){
      assertthat::assert_that(!is.na(trimester), msg='para despues de 2003, es necesario definir el trimestre de la EPH continua')
      assertthat::assert_that(!(year==2007 & trimester==3), msg="INDEC advierte: La informacion correspondiente al tercer trimestre 2007 no esta disponible ya que los aglomerados Mar del Plata-Batan, Bahia Blanca-Cerri y Gran La Plata no fueron relevados por causas de orden administrativo, mientras que los datos correspondientes al Aglomerado Gran Buenos Aires no fueron relevados por paro del personal de la EPH.")
      assertthat::assert_that(!((year==2015 & trimester %in% 3:4)|(year==2016 & trimester ==1)), msg="En el marco de la emergencia estadistica el INDEC no publico la base solicitada.
                            mas informacon en: https://www.indec.gob.ar/ftp/cuadros/sociedad/anexo_informe_eph_23_08_16.pdf")
      if (year %in% 2007:2015) {
        warning("INDEC advierte:
'''
              Advertencia sobre el uso de series estadisticas

Se advierte que las series estadisticas publicadas con posterioridad a enero 2007 y hasta diciembre 2015 deben ser consideradas con reservas, excepto las que ya hayan sido revisadas en 2016 y su difusion lo consigne expresamente. El INDEC, en el marco de las atribuciones conferidas por los decretos 181/15 y 55/16, dispuso las investigaciones requeridas para establecer la regularidad de procedimientos de obtencion de datos, su procesamiento, elaboracion de indicadores y difusion.
'''
mas informacon en: https://www.indec.gob.ar/ftp/cuadros/sociedad/anexo_informe_eph_23_08_16.pdf
")
      }
      if(year %in% 2016:2018){
        link = glue::glue('https://github.com/rindec/data/raw/master/eph/{type}/base_{type}_{year}T{trimester}.RDS')
      }
    }else
    if (year==2003) {
      if (!is.na(wave)) {
        assertthat::assert_that(wave ==1, msg = 'La EPH puntual termina en la primera onda de 2003')
        link = glue::glue('https://github.com/rindec/data/raw/master/eph/{type}/base_{type}_{year}O{wave}.RDS')
      }else
        if (!is.na(trimester)) {
          assertthat::assert_that(trimester %in% 3:4, msg = 'la EPH conitnua comienza en el tercer trimestre de 2003')
        link = glue::glue('https://github.com/rindec/data/raw/master/eph/{type}/base_{type}_{year}T{trimester}.RDS')
        }
    }

    if (year<2018| year==2018& trimester %in% 1:3) {
    base <- emptyenv()
    try(base <- readRDS(gzcon(url(link))),silent = TRUE)

    assertthat::assert_that(assertthat::not_empty(base),msg = "problema con la descarga. Posiblemente un error de la conexion a internet")
    }
    if (year>2018 |year==2018 & trimester==4) {

      link= glue::glue('https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_usu_{trimester}_Trim_{year}_txt.zip')

      temp <- tempfile(pattern = glue::glue('microdatos_{trimester}_{year}'))


      check <- NA
      try(check <- utils::download.file(link,temp),silent = TRUE)
      assertthat::assert_that(assertthat::noNA(check),msg = "problema con la descarga. Posiblemente un error de la conexion a internet")
      nombres <- purrr::as_vector(utils::unzip(temp, list = TRUE)['Name'])
      base_hogar_name <- nombres[stringr::str_detect(nombres, 'hog')]
      base_individual_name <- nombres[stringr::str_detect(nombres, 'ind')]

      if (type=='individual') {
        base <- utils::read.table(unz(temp,base_individual_name), sep=";", dec=",", header = TRUE, fill = TRUE)
      }
      if (type=='hogar') {
        base <- utils::read.table(unz(temp,base_hogar_name), sep=";", dec=",", header = TRUE, fill = TRUE)
      }
      unlink(temp)
    }
    base
  }
