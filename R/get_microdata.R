#' Descarga de Bases de EPH
#' @description
#' Funcion que descarga bases de la Encuesta Permanente de Hogares del INDEC a partir de 1996
#' @param year un integer o vector de integers a partir de 2003
#' @param period un integer o vector de integers con el numero de trimestre u onda: 1,2,3,4, para la EPH continua, y 1 o 2, para la EPH puntual
#' @param type un character o vector de characters con el tipo de base a descargar: 'individual'; 'hogar', default individual
#' @param vars opcional: un vector de characters. variables a seleccionar. Default='all' trae todas las variables
#' @param destfile opcional: un string con la direccion de un archivo .RDS. Si se ingresa un path a un archivo que no existe, se descarga
#'                el archivo y se graba en esa direccion. Si existe un archivo en ese path, se lee el archivo.
#' @param ... asegura el funcionamiento de la funcion en su version anterior con los parametros wave o trimester
#'
#' @return Devuelve la o las bases de la EPH solicitadas
#'
#' @details
#' Las bases de la EPH puntual utilizan el parametro period para referirse a las ondas.
#' Su alcance es entre la onda 1 de 1996 y la onda 1 de 2003.
#'
#' Las bases de la EPH continua utilizan el parametro period para referirse a los trimestres.
#' Su alcance es entre tercer trimestre de 2003 a la actualidad
#' disclaimer: El script no es un producto oficial de INDEC.
#'
#' @examples
#'
#' base_individual <- get_microdata(
#'   year = 2018:2019,
#'   period = 1,
#'   type = "individual",
#'   vars = c("PONDERA", "ESTADO", "CAT_OCUP")
#' )
#'
#' @export

get_microdata <- function(year = 2018,
                          period = 1,
                          type = "individual",
                          vars = "all",
                          destfile = NULL, ...) {

  dots <- list(...)

  if ("trimester" %in% names(dots)) {
    period <- dots$trimester
  }
  if ("wave" %in% names(dots)) {
    period <- dots$wave
  }

  destfile_exists <- FALSE
  if (!is.null(destfile)) {
    destfile_exists <- file.exists(destfile)
  }

  if (destfile_exists) {
    df <- readRDS(destfile)

    return(df)
  }


  if (is.null(destfile) | !destfile_exists) {
    # attempt::stop_if_not(
    #   .x = curl::has_internet(),
    #   msg = "No se detecto acceso a internet. Por favor checkea tu conexion."
    # )
    if (!curl::has_internet()) { # network is down = message (not an error anymore)
      message("No se detecto acceso a internet. Por favor checkea tu conexion.")
      return(NULL)
    }

    df <- tibble::as_tibble(expand.grid(
      year = year,
      period = period,
      type = type
    ))


    df <- df %>%
      dplyr::mutate(
        microdata =
          purrr::pmap(
            list(
              "year" = year,
              "period" = period,
              "type" = type
            ),
            purrr::safely(
              .f = get_microdata_internal,
              otherwise = tibble::tibble(),
              quiet = TRUE
            ), vars
          )
      )


    df <- df %>%
      dplyr::mutate(
        error = purrr::map(microdata, ~ .x$error),
        microdata = purrr::map(microdata, ~ .x$result)
      )

    errors <- df %>%
      dplyr::mutate(filter_col = purrr::map_lgl(error, ~ !is.null(.x))) %>%
      dplyr::filter(filter_col) %>%
      dplyr::mutate(error_message = purrr::map(error, ~ purrr::pluck(.x, 1))) %>%
      dplyr::select(-tidyselect::any_of(c("microdata", "error"))) %>%
      tidyr::unnest(cols = c(error_message))

    if (nrow(errors) > 0) {
      warning(sprintf("No se pudo descargar la base de year %s, period %s, type %s.
    Mensaje: %s

                       ", errors$year, errors$period, errors$type, errors$error_message))
    }

    df <- df %>%
      dplyr::select(-tidyselect::any_of(c("error")))

    if (!is.null(destfile) & !destfile_exists) {
      saveRDS(df, file = destfile)
    }
  }

  if (nrow(df) == 1) {
    return(df$microdata[[1]])
  } else {
    df %>%
      tidyr::unnest(microdata) %>%
      dplyr::select(-tidyselect::any_of(c("year", "period", "type")))
  }
}
