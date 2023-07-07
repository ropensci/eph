#' @title Tabla con los errores muestrales para estimaciones de población
#' @description Base con los errores muestrales para estimaciones de población en los aglomerados urbanos
#'  para la EPH continua desde 2003 segundo trimestre según documentación de INDEC:
#' https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_errores_muestreo_3t2014.pdf
#' https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_errores_muestreo.pdf
#' @format A data frame with 1687 rows and 5 variables:
#' \describe{
#'   * `codigo`{character ---String con código numérico de los 31 aglomerados, "Gran Buenos Aires"
#'    (sólo para 2003.03 a 2014.02), o con "Total" para el conjunto de los 31 aglomerados---}
#'   * `aglomerado`{character ---String con el nombre del aglomerado---}
#'   * `periodo`{character ---String indicando el periodo de EPH que corresponde, "2014.03"
#'    para datos de EPH a partir del tercer trimestre 2014, o "2003.03_2014.02" para datos anteriores---}
#'   * `x`{double ---Estimación de población para la cual se desea conocer el error muestral---}
#'   *`ds`{double ---Desvío Estándar correspondiente a la estimación de población en el aglomerado---}
#'   * `cv`{double ---Coeficiente de Variación correspondiente a la estimación de población en el aglomerado---}
#'}

"errores_muestrales"
