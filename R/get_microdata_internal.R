#' Descarga de Bases de EPH
#' @description
#' Funcion que descarga bases de la Encuesta Permanente de Hogares del INDEC a partir de 1996
#' @param year un integer a partir de 2003
#' @param period un integer con el numero de trimestre u onda: 1,2,3,4, para la EPH continua, y 1 o 2, para la EPH puntual
#' @param type tipo de base a descargar: 'individual' ; 'hogar', default individual
#' @param vars variables a seleccionar. Default trae todas las variables
#'
#' @noRd

get_microdata_internal <- function(year = 2018,
                                   period = 1,
                                   type = "individual",
                                   vars = "all") {
  # controles de los parametros

  if (!is.numeric(year)) {
    cli::cli_abort(c(
      "El argumento year debe ser numeric"
    ))
  }
  if (year < 1996) {
    cli::cli_alert_warning(c(
      "La funcion puede descargar bases publicadas desde 1996."
    ))
  }
  if (!is.numeric(period)) {
    cli::cli_abort(c(
      "El argumento period debe ser numeric"
    ))
  }
  if (any(!period %in% c(1, 2, 3, 4))) {
    cli::cli_abort(c(
      "Por favor ingrese un numero de periodo valido: 1,2,3,4",
      "i" = "El periodo refiere a la onda o el trimestre dependiendo del anio"
    ))
  }
  if (!type %in% c("individual", "hogar")) {
    cli::cli_abort(c(
      "Elegir alguna de las opciones de type: 'individual' u 'hogar'."
    ))
  }


  if (year < 2003) {
    if (any(!period %in% c(1, 2))) {
      cli::cli_abort(c(
        "Por favor ingrese un numero de periodo valido: 1,2",
        "i" = "Para antes de 2003, es necesario definir la onda de la EPH puntual."
      ))
    }

    link <- sprintf("https://github.com/holatam/data/raw/master/eph/%s/base_%s_%sO%s.RDS", type, type, year, period)
  } else if (year > 2003) {
    if ((year == 2007 & period == 3)) {
      warning("INDEC advierte: La informacion correspondiente al tercer trimestre
                 2007 no esta disponible ya que los aglomerados Mar del Plata-Batan,
                 Bahia Blanca-Cerri y Gran La Plata no fueron relevados por causas
                 de orden administrativo, mientras que los datos correspondientes al
                 Aglomerado Gran Buenos Aires no fueron relevados por paro del
                 personal de la EPH.")

      return(tibble::tibble())
    }

    if ((year == 2015 & period %in% 3:4) | (year == 2016 & period == 1)) {
      cli::cli_abort("En el marco de la emergencia estadistica el INDEC no publico la base solicitada.
                 Mas informacion en: https://www.indec.gob.ar/ftp/cuadros/sociedad/anexo_informe_eph_23_08_16.pdf")

      return(tibble::tibble())
    }

    link <- sprintf("https://github.com/holatam/data/raw/master/eph/%s/base_%s_%sT%s.RDS", type, type, year, period)
    if (year %in% 2007:2015) {
      warning("INDEC advierte:
'''
              Advertencia sobre el uso de series estadisticas

Se advierte que las series estadisticas publicadas con posterioridad a enero 2007 y hasta diciembre 2015 deben ser consideradas con reservas, excepto las que ya hayan sido revisadas en 2016 y su difusion lo consigne expresamente. El INDEC, en el marco de las atribuciones conferidas por los decretos 181/15 y 55/16, dispuso las investigaciones requeridas para establecer la regularidad de procedimientos de obtencion de datos, su procesamiento, elaboracion de indicadores y difusion.
'''
Mas informacon en: https://www.indec.gob.ar/ftp/cuadros/sociedad/anexo_informe_eph_23_08_16.pdf
")
    }
  } else if (year == 2003) {
    if (any(!period %in% c(1, 3, 4))) {
      cli::cli_abort(c(
        "Por favor ingrese un numero de periodo valido para 2003: 1, 3 o 4",
        "i" = "La EPH puntual termina en la primera onda de 2003. La EPH continua comienza en el tercer trimestre de 2003."
      ))
    }

    if (period == 1) {
      link <- sprintf("https://github.com/holatam/data/raw/master/eph/%s/base_%s_%sO%s.RDS", type, type, year, period)
    } else if (all(period %in% c(3, 4))) {
      link <- sprintf("https://github.com/holatam/data/raw/master/eph/%s/base_%s_%sT%s.RDS", type, type, year, period)
    }
  }

  if (is_in_github(year = year, period = period, type = type)) {
    base <- emptyenv()
    try(base <- readRDS(gzcon(url(link))), silent = TRUE)

    if (rlang::is_empty(base)) {
      cli::cli_abort(c(
        "Problema con la descarga. Posiblemente un error de la conexion a internet"
      ))
    }
  } else {
    if (!is_in_github(year = year, period = period, type = type)) {
      link <- sprintf("https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_usu_%s_Trim_%s_txt.zip", period, year)

      temp <- tempfile(pattern = sprintf("microdatos_%s_%s", period, year))

      try(check <- utils::download.file(link, temp), silent = TRUE)

      nombres <- NA
      try(nombres <- purrr::as_vector(utils::unzip(temp, list = TRUE)["Name"]), silent = TRUE)
      if (all(is.na(nombres))) {
        cli::cli_abort(c(
          sprintf("Problema con la descarga %s period %s. Puede deberse a que la base solicitada no exista.", year, period)
        ))
      }

      base_hogar_name <- nombres[grep("hog", nombres, ignore.case = TRUE)]
      base_individual_name <- nombres[grep("ind", nombres, ignore.case = TRUE)]

      if (type == "individual") {
        base <- utils::read.table(unz(temp, base_individual_name),
          sep = ";", dec = ",", header = TRUE, fill = TRUE,
          colClasses = c(
            CH14 = "character",
            PP04B_COD = "character",
            PP04D_COD = "character",
            PP11B_COD = "character",
            PP11D_COD = "character",
            DECOCUR = "character",
            IDECOCUR = "character",
            RDECOCUR = "character",
            GDECOCUR = "character",
            PDECOCUR = "character",
            ADECOCUR = "character",
            DECINDR = "character",
            IDECINDR = "character",
            RDECINDR = "character",
            GDECINDR = "character",
            PDECINDR = "character",
            ADECINDR = "character",
            DECIFR = "character",
            IDECIFR = "character",
            RDECIFR = "character",
            GDECIFR = "character",
            PDECIFR = "character",
            ADECIFR = "character",
            DECCFR = "character",
            IDECCFR = "character",
            RDECCFR = "character",
            GDECCFR = "character",
            PDECCFR = "character",
            ADECCFR = "character"
          )
        ) %>%
          tidyr::as_tibble()
      }
      if (type == "hogar") {
        base <- utils::read.table(unz(temp, base_hogar_name),
          sep = ";", dec = ",", header = TRUE, fill = TRUE,
          colClasses = c(
            DECIFR = "character",
            IDECIFR = "character",
            GDECIFR = "character",
            PDECIFR = "character",
            ADECIFR = "character",
            DECCFR = "character",
            IDECCFR = "character",
            RDECCFR = "character",
            GDECCFR = "character",
            PDECCFR = "character",
            ADECCFR = "character",
            RDECIFR = "character"
          )
        ) %>%
          tidyr::as_tibble()
      }
      unlink(temp)
    }
  }

  if (all(vars == "all")) {
    vars <- colnames(base)
  }
  if (nrow(base) > 0) {
    chequeo <- vars %in% colnames(base)

    if (!all(chequeo)) {
      cli::cli_abort(sprintf("Las variables: %s no se encuentran disponibles para esta base.
                             Puede deberse a que son variables de la base individual (hogar) y se quiere descargar la base hogar (individual)", sub(",([^,]*)$", " y\\1", paste0(vars[!chequeo], collapse = ", "))))
    }

    base %>%
      dplyr::rename_all(toupper) %>%
      dplyr::select(tidyselect::all_of(vars))
  } else {
    base
  }
}
