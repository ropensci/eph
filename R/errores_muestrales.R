#' @title errores_muestrales
#' @description Base con los errores muestrales para estimaciones puntuales en los 31 aglomerados urbanos.
#' Estos errores rigen para la EPH continua desde 2014 tercer trimestre según documentación de INDEC:
#' https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_errores_muestreo_3t2014.pdf
#' @format A data frame with 935 rows and 4 variables:
#' \describe{
#'   \item{\code{aglomerado}}{character ---String con código numérico de aglomerado o con "Total" para el conjunto de los 31 aglomerados---}
#'   \item{\code{x}}{double ---Estimación puntual para la cual se desea conocer el error muestral---}
#'   \item{\code{ds}}{double ---Desvío Estándar para la estimacióm puntual en el aglomerado correspondiente---}
#'   \item{\code{cv}}{double ---Coeficiente de Variación para la estimacióm puntual en el aglomerado correspondiente---}
#'}

"errores_muestrales"
