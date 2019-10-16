#'Descarga de Bases de EPH
#'@description
#'Funcion que descarga bases de la Encuesta Permanente de Hogares del INDEC a partir de 1996
#'@param year un integer o vector de integers a partir de 2003
#'@param trimester un integer o vector de integers con el numero de trimester: 1,2,3,4, para la EPH continua
#'@param wave un integer o vector de integers con el numero de onda, 1 o 2, para la EPH puntual
#'@param type un character o vector de characters con el tipo de base a descargar: 'individual' ; 'hogar', default individual
#'@details
#'Las bases de la EPH puntual utilizan el parametro wave, para referirse a las ondas.
#'Su alcance es entre la onda 1 de 1996 y a onda 1 de 2003.
#'
#'Las bases de la EPH continua utiliza el parametro trimester, para referirse a los trimestres.
#'Su alcance es entre tercer trimestre de 2003 a la actualidad
#'disclaimer: El script no es un producto oficial de INDEC.
#'
#'@return
#'
#'En caso de una única base devuevle un dataframe.
#'En caso de una consulta múltiple devuelve un dataframe anidado, con
#'la información de cada consulta y una columna `microdata` con la base
#'correspondiente
#'
#'@examples
#'
#'base_individual <- get_microdata(year = 2018:2019,
#'                                  trimester = 1,
#'                                  type='individual')
#'
#'base_2018 <- base_individual %>%
#'  dplyr::filter(year==2018) %>%
#'  dplyr::select(microdata) %>%
#'  tidyr::unnest(microdata)
#'
#'
#'bases_bind <- base_individual %>%
#'  dplyr::select(microdata) %>%
#'  tidyr::unnest()
#'@export

get_microdata <- function(year = 2018,
                          trimester = NA,
                          wave = NA,
                          type='individual'){





  df <- tibble::as_tibble(expand.grid(year=year,
                                      trimester=trimester,
                                      wave=wave,
                                      type=type))

  df <- df %>%
    dplyr::mutate(microdata=
      purrr::pmap(list('year' = year,
                       'trimester' = trimester,
                       'wave' = wave,
                       'type' = type),
                  purrr::possibly(get_microdata_internal,
                                  otherwise = tibble::tibble(),
                                  quiet = FALSE)
                  )
      )

  if (nrow(df)==1) {
    df$microdata[[1]]
  }else{
    df
  }
}
