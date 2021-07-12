#' @title errores_muestrales
#' @description Base con los errores muestrales para estimaciones puntuales en los 31 aglomerados urbanos.
#' Estos errores rigen para la EPH continua desde 2003 segundo trimestre según documentación de INDEC:
#' https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_errores_muestreo_3t2014.pdf
#' https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_errores_muestreo.pdf
#' @format A data frame with 1687 rows and 5 variables:
#' \describe{
#'   \item{\code{codigo}}{character ---String con código numérico de aglomerado o con "Total" para el conjunto de los 31 aglomerados---}
#'   \item{\code{aglomerado}}{character ---String con el nombre del aglomerado---}
#'   \item{\code{periodo}}{character ---String indicando el periodo de EPH que corresponde, "2014.03" para datos de EPH a partir del tercer trimestre 2014, o "2003.03_2014.02" para datos anteriores---}"
#'   \item{\code{x}}{double ---Estimación puntual de individuos para la cual se desea conocer el error muestral---}
#'   \item{\code{ds}}{double ---Desvío Estándar para la estimacióm puntual en el aglomerado correspondiente---}
#'   \item{\code{cv}}{double ---Coeficiente de Variación para la estimacióm puntual en el aglomerado correspondiente---}
#'}

"errores_muestrales"
