#'Calculo del desvío estándar y el coeficiente de variación
#'@description
#'Asigna a una estimación de un total poblacional el desvío estándar o el coeficiente de variación
#' correspondiente según las tablas de error muestral de INDEC para EPH continua
#'  a partir del segundo trimestre 2003.
#' (Ver \code{\link{errores_muestrales}})
#'@param value Vector numérico de las estimaciones de población para las
#' que se desea hallar el desvío estándar o el coeficiente de variación.
#'@param codigo_aglo default = "Total". String con el código numerico del aglomerado al que
#' pertenecen las estimaciones. "Total" para trabajar estimaciones del conjunto de 31 aglomerados urbanos.
#'@param periodo_eph default = "2014.03". String indicando el periodo al que corresponde la EPH. "2014.03" para
#' obtener los errores muestrales correspondientes al tercer trimestre de 2014 en adelante. "2003.03_2014.02"
#' para los errores muestrales del tercer trimestre del 2003 al segundo trimestre del 2014.
#'@param measure default = "cv". String indicando la medida que se desea obtener. "cv" para obtener el coeficiente de variación
#' correspondiente a las estimaciones o "ds" para obtener el desvío estándar.
#'@details disclaimer: El script no es un producto oficial de INDEC.
#'
#'@examples
#'
#'tabla <- eph::toybase_individual_2016_03 %>%
#'   eph::organize_labels() %>%
#'   dplyr::filter(AGLOMERADO == 32) %>%
#'   calculate_tabulates(x = "CH03",
#'                          weights = "PONDERA",
#'                          add.totals = "row")
#'tabla %>%
#'   dplyr::mutate(ds = calculate_error(Freq, codigo_aglo = "32",
#'    periodo_eph = "2014.03", measure = "ds"))
#'
#'@export


calculate_error <- function(value, codigo_aglo = "Total", periodo_eph = "2014.03", measure = "cv") {

  # Controles de los parametros
  assertthat::assert_that(is.numeric(value))
  assertthat::assert_that(codigo_aglo %in% c("Total", "Gran Buenos Aires", "2", "3", "5", "4", "6", "7",
                                             "8", "9", "10", "12", "13", "14", "15", "17", "18", "19", "20",
                                             "22", "23", "25", "26", "27", "29", "30", "31", "32", "33", "34",
                                             "36", "38", "91", "93"))
  assertthat::assert_that(periodo_eph %in% c("2014.03", "2003.03_2014.02"))
  assertthat::assert_that(measure %in% c("cv","ds"))

  # Operacion
  tabla_referencia <- eph::errores_muestrales %>%
    dplyr::filter(.data$codigo == codigo_aglo & .data$periodo == periodo_eph)  %>%
    dplyr::select(.data$x, measure)

  find_closest <-function(y) {
    tabla_referencia[[measure]][which.min(abs(tabla_referencia[["x"]] - y))]
  }

  sapply(value, find_closest)
}
