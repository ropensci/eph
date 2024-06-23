#' Descarga de canasta basica alimentaria y canasta basica total
#' @description
#' Funcion que descarga la CBA y CBT a partir de abril 2016
#' @param regional booleano, default = FALSE. Si es TRUE, descarga los datos de canastas regionales
#'       que se utilizan para el calculo de pobreza. Si es FALSE, descarga la serie de GBA
#'       provista por indec en https://www.indec.gob.ar/indec/web/Nivel4-Tema-4-43-149
#'
#' @return Devuelve una tabla con la CBA y CBT a partir de abril 2016
#'
#' @details
#' disclaimer: El script no es un producto oficial de INDEC.
#'
#' @examples
#'
#' canasta <- get_poverty_lines(regional = TRUE)
#' canasta
#'
#' @export

get_poverty_lines <- function(regional = FALSE) {
  # attempt::stop_if_not(
  #   .x = curl::has_internet(),
  #   msg = "No se detecto acceso a internet. Por favor checkea tu conexion."
  # )
  if (!curl::has_internet()) { # network is down = message (not an error anymore)
    message("No se detecto acceso a internet. Por favor checkea tu conexion.")
    return(NULL)
  }

  if (regional) {
    temp <- tempfile()
    link <- "https://github.com/holatam/data/raw/master/eph/canasta/canastas.rds"

    check <- NA
    try(check <- utils::download.file(link, destfile = temp, mode = "wb"), silent = TRUE)
    if (is.na(check)) {
      cli::cli_inform(c(
        "Problema con la descarga"
      ))
      return(NULL)
    }

    canasta <- readRDS(temp)
    unlink(temp)
  } else {
    temp <- tempfile(fileext = ".xls")
    dataURL <- "https://www.indec.gob.ar/ftp/cuadros/sociedad/serie_cba_cbt.xls"

    check <- NA
    try(check <- utils::download.file(dataURL, destfile = temp, mode = "wb"), silent = TRUE)
    if (is.na(check)) {
      cli::cli_inform(c(
        "Problema con la descarga"
      ))
      return(NULL)
    }

    suppressWarnings({
      canasta <- readxl::read_excel(temp,
        sheet = 1, skip = 6, col_names = c("periodo", "CBA", "ICE", "CBT"),
        col_types = c("date", "numeric", "numeric", "numeric")
      ) %>% stats::na.omit()
    })
    unlink(temp)
  }

  canasta
}
