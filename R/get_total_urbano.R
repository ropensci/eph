#' Descarga de Bases de EPH total urbano
#' @description
#' Funcion que descarga bases de la Encuesta Permanente de Hogares total urbano del INDEC a partir de 2016
#' @param year un integer o vector de integers a partir de 2016
#' @param type tipo de base a descargar: 'individual' ; 'hogar'
#' @param vars opcional: un vector de characters. variables a seleccionar. Default = 'all' trae todas las variables
#' @param destfile opcional: un string con la direccion de un archivo .RDS. Si se ingresa un path a un archivo que no existe, se descarga
#'                el archivo y se graba en esa direccion. Si existe un archivo en ese path, se lee el archivo.
#'
#' @return Devuelve la o las bases de la EPH total urbano solicitadas
#'
#' @details
#' disclaimer: El script no es un producto oficial de INDEC.
#'
#' @examples
#' \dontrun{
#' base_individual <- get_total_urbano(
#'   year = 2016,
#'   type = "hogar",
#'   vars = c("PONDERA", "IV1", "IV2")
#' )
#' }
#'
#' @export

get_total_urbano <- function(year = 2016,
                             type = "individual",
                             vars = "all",
                             destfile = NULL) {

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
      type = type
    ))


    df <- df %>%
      dplyr::mutate(
        microdata =
          purrr::pmap(
            list(
              "year" = year,
              "type" = type
            ),
            purrr::safely(
              .f = get_total_urbano_internal,
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
      warning(sprintf("No se pudo descargar la base de year %s, type %s.
    Mensaje: %s

                       ", errors$year, errors$type, errors$error_message))
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
      dplyr::select(-tidyselect::any_of(c("year", "type")))
  }
}
