#' Descarga de Bases de EPH total urbano
#'
#' @param year un integer a partir de 2016
#' @param type tipo de base a descargar: 'individual' ; 'hogar'
#' @param vars variables a seleccionar. Default trae todas las variables
#'
#' @noRd

get_total_urbano_internal <- function(year = 2016,
                                      type = "individual",
                                      vars = "all") {
  if (!is.numeric(year)) {
    cli::cli_abort(c(
      "El argumento year debe ser numeric"
    ))
  }
  if (year < 2016) {
    cli::cli_alert_warning(c(
      "La funcion puede descargar bases publicadas desde 2016."
    ))
  }
  if (!type %in% c("individual", "hogar")) {
    cli::cli_abort(c(
      "Elegir alguna de las opciones de type: 'individual' u 'hogar'."
    ))
  }

  if (year < 2016) {
    cli::cli_abort(c(
      "El anio elegido no es valido",
      "i" = "Hay datos disponibles desde 2016"
    ))
  }

  link <- sprintf("https://www.indec.gob.ar/ftp/cuadros/menusuperior/eahu/EPH_Tot_Urbano_3T_%s.zip", year)

  temp <- tempfile(pattern = sprintf("microdatos_%s", year))

  try(check <- utils::download.file(link, temp), silent = TRUE)
  if (rlang::is_empty(check)) {
    cli::cli_abort(c(
      sprintf("Problema con la descarga %s. Puede deberse a que la base solicitada no exista.", year)
    ))
  }

  nombres <- NA
  try(nombres <- purrr::as_vector(utils::unzip(temp, list = TRUE)["Name"]), silent = TRUE)
  if (all(is.na(nombres))) {
    cli::cli_abort(c(
      sprintf("Problema con la descarga %s. Puede deberse a que la base solicitada no exista.", year)
    ))
  }

  base_hogar_name <- nombres[grep("hog", nombres, ignore.case = TRUE)]
  base_individual_name <- nombres[grep("pers", nombres, ignore.case = TRUE)]

  if (type == "individual") {
    base <- utils::read.table(unz(temp, base_individual_name), sep = ";", dec = ",", header = TRUE, fill = TRUE, colClasses = c(PP3F_TOT = "character", IPCF = "character", CH16_COD = "character", CH15_COD = "character")) %>%
      tidyr::as_tibble()
  }
  if (type == "hogar") {
    base <- utils::read.table(unz(temp, base_hogar_name), sep = ";", dec = ",", header = TRUE, fill = TRUE) %>%
      tidyr::as_tibble()
  }

  unlink(temp)

  if (all(vars == "all")) {
    base <- base %>%
      dplyr::rename_all(toupper)

    return(base)
  }
  if (nrow(base) > 0) {
    chequeo <- vars %in% colnames(base)

    if (!all(chequeo)) {
      cli::cli_abort(sprintf("Las variables: %s no se encuentran disponibles para esta base.
                             Puede deberse a que son variables de la base individual (hogar) y se quiere descargar la base hogar (individual)", sub(",([^,]*)$", " y\\1", paste0(vars[!chequeo], collapse = ", "))))
    }

    base <- base %>%
      dplyr::rename_all(toupper) %>%
      dplyr::select(tidyselect::all_of(vars))

    return(base)
  }
}
