% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculate_errors.R
\name{calculate_errors}
\alias{calculate_errors}
\title{Calculo del desvio estandar y el coeficiente de variacion}
\usage{
calculate_errors(
  value,
  codigo_aglo = "Total",
  periodo_eph = "2014.03",
  measure = "cv"
)
}
\arguments{
\item{value}{Vector numerico de las estimaciones de poblacion para las
que se desea hallar el desvio estandar o el coeficiente de variacion.}

\item{codigo_aglo}{default = "Total". String con el codigo numerico del aglomerado al que
pertenecen las estimaciones. "Total" para trabajar estimaciones del conjunto de 31 aglomerados urbanos.}

\item{periodo_eph}{default = "2014.03". String indicando el periodo al que corresponde la EPH. "2014.03" para
obtener los errores muestrales correspondientes al tercer trimestre de 2014 en adelante. "2003.03_2014.02"
para los errores muestrales del tercer trimestre del 2003 al segundo trimestre del 2014.}

\item{measure}{default = "cv". String indicando la medida que se desea obtener. "cv" para obtener el coeficiente de variacion
correspondiente a las estimaciones o "ds" para obtener el desvio estandar.}
}
\value{
Devuelve la estimacion de un total poblacional agregando el desvio estandar o el coeficiente de variacion correspondiente segun las tablas de error muestral de INDEC para EPH continua a partir del segundo trimestre 2003
}
\description{
Asigna a una estimacion de un total poblacional el desvio estandar o el coeficiente de variacion
correspondiente segun las tablas de error muestral de INDEC para EPH continua
 a partir del segundo trimestre 2003.
(Ver `errores_muestrales`)
}
\details{
disclaimer: El script no es un producto oficial de INDEC.
}
\examples{

tabla <- eph::toybase_individual_2016_03 \%>\%
  eph::organize_labels() \%>\%
  dplyr::filter(AGLOMERADO == 32) \%>\%
  eph::calculate_tabulates(
    x = "CH03",
    weights = "PONDERA",
    add.totals = "row"
  )
tabla \%>\%
  dplyr::mutate(ds = calculate_errors(Freq,
    codigo_aglo = "32",
    periodo_eph = "2014.03", measure = "ds"
  ))

}
