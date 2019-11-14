#'Descarga de Bases de EPH
#'@description
#'Funcion que descarga bases de la Encuesta Permanente de Hogares del INDEC a partir de 1996
#'@param year un integer o vector de integers a partir de 2003
#'@param trimester un integer o vector de integers con el numero de trimester: 1,2,3,4, para la EPH continua
#'@param wave un integer o vector de integers con el numero de onda, 1 o 2, para la EPH puntual
#'@param type un character o vector de characters con el tipo de base a descargar: 'individual' ; 'hogar', default individual
#'@param vars un vector de characters. variables a seleccionar. Default='all' trae todas las variables
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
#'                                  type='individual',
#'                                  vars = c('PONDERA','ESTADO','CAT_OCUP'))
#'
#'base_2018 <- base_individual %>%
#'  dplyr::filter(year==2018) %>%
#'  dplyr::select(microdata) %>%
#'  tidyr::unnest(microdata)
#'
#'
#'bases_bind <- base_individual %>%
#'  dplyr::select(microdata) %>%
#'  tidyr::unnest(cols = c(microdata))
#'@export

get_microdata <- function(year = 2018,
                          trimester = NA,
                          wave = NA,
                          type='individual',
                          vars = 'all'){

  attempt::stop_if_not(.x = curl::has_internet(),
                       msg = "No se detecto acceso a internet. Por favor checkea tu conexion.")

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
                  purrr::safely(.f = get_microdata_internal,
                                  otherwise = tibble::tibble(),
                                  quiet = TRUE), vars
                  )
      )



  df <- df %>%
    dplyr::mutate(error = purrr::map(microdata,~.x$error),
                  microdata = purrr::map(microdata,~.x$result))

  errors <- df %>%
    dplyr::mutate(filter_col = purrr::map_lgl(error, ~ !is.null(.x))) %>%
    dplyr::filter(filter_col) %>%
    dplyr::mutate(error_message = purrr::map(error, ~purrr::pluck(.x,1))) %>%
    dplyr::select(-microdata,-error) %>%
    tidyr::unnest(cols = c(error_message))

  if (nrow(errors)>0) {
    warning(glue::glue('No se pudo descargar la base de year {errors$year},trimester {errors$trimester}, wave {errors$wave}, type {errors$type}.
  Mensaje: {errors$error_message}

                     '))
  }

  df <- df %>%
    dplyr::select(-error)

  if (nrow(df)==1) {
    df$microdata[[1]]
  }else{
    df
  }
}
