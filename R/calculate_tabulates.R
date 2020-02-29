#'Tabulado con ponderación
#'@description
#'Función para crear tabulados uni o bivariados con ponderacion, totales parciales y porcentajes.
#'@param base Dataframe
#'@param x string con el nombre de la variable a tabular
#'@param y otro string (opcional) con el nombre de una segunda variable, para una tabla de doble entrada. Tiene que ser de igual largo que x
#'@param weights string con el nombre de la variable con los pesos de pesos, tiene que ser de igual largo que x
#'@param digits numero de digitos significativos
#'@param normwt si es TRUE, normaliza los pesos de modo que el recuento ponderado total sea el mismo que el no ponderado
#'@param na.rm Si es TRUE, elimina los NA antes del computo
#'@param na.show si TRUE, muestra el recuento de NA en la salida
#'@param exclude valores a remover de x e y
#'@param add.totals  toma los valores c('none','row','col','both'), para agregar totales por fila, columna o ambos
#'@param add.percentage toma los valores c('none','row','col'), para agregar porcentajes por fila y columna
#'@examples
#'
#'
#'### tabla simple ###
#'
#'calculate_tabulates(base = toybase_individual_2016_04,x = 'REGION', y = 'CH04',
#'             weights = 'PONDERA')
#'
#'### para ver los totales por fila ###
#'
#'calculate_tabulates(base = toybase_individual_2016_04,x = 'REGION', y = 'CH04',
#'             weights = 'PONDERA', add.totals = 'row')
#'
#'### para ver los totales por columna ###
#'
#'calculate_tabulates(base = toybase_individual_2016_04,x = 'REGION', y = 'CH04',
#'             weights = 'PONDERA', add.totals = 'col')
#'
#'### para ver porcentajes por fila ###
#'
#'calculate_tabulates(base = toybase_individual_2016_04,x = 'REGION', y = 'CH04',
#'             weights = 'PONDERA', add.percentage ='row')
#'
#'@export

calculate_tabulates <- function(base, x, y = NULL, weights = NULL, digits = 3, normwt = FALSE,
                         na.rm = TRUE, na.show = FALSE, exclude = NULL,
                         add.totals = 'none',
                         add.percentage = 'none'){

x_vec <- base[[x]]
if (!is.null(y)) {
  y_vec <- base[[y]]
} else {
  y_vec = NULL
}
if (!is.null(weights)) {

  weights_vec <- base[[weights]]
} else {
  weights_vec = NULL
}

# Controles de los parametros
  assertthat::assert_that(is.vector(x))
  assertthat::assert_that(add.totals %in% c('none','row','col','both'))
  assertthat::assert_that(add.percentage %in% c('none','row','col'))

    weighted_table <- as.data.frame(questionr::wtd.table(x = x_vec,
                                                         y = y_vec,
                                                         weights = weights_vec,
                                                         digits = digits,
                                                         normwt = normwt,
                                                         na.rm = na.rm,
                                                         na.show = na.show))
    if (!is.null(y)) {
      weighted_table <- weighted_table %>%
        tidyr::spread(., Var2, Freq)
      names(weighted_table) <- c(paste0(x,'/',y),names(weighted_table)[2:ncol(weighted_table)])
    } else {
      names(weighted_table) <- c(paste0(x),names(weighted_table)[2:ncol(weighted_table)])
    }

    if (add.totals=='row') {
      weighted_table <- weighted_table %>%
        janitor::adorn_totals("row")
    } else{
      if (add.totals=='col') {
        weighted_table <- weighted_table %>%
          janitor::adorn_totals("col")
      } else{
        if (add.totals =='both') {
          weighted_table <- weighted_table %>%
            janitor::adorn_totals("row") %>%
            janitor::adorn_totals("col")
        }
      }
    }
    if (add.percentage == 'col') {
      weighted_table <- weighted_table %>%
      janitor::adorn_percentages("col") %>%
        janitor::adorn_pct_formatting()
    } else {
      if (add.percentage == 'row') {
        weighted_table <- weighted_table %>%
          janitor::adorn_percentages("row") %>%
          janitor::adorn_pct_formatting()
      }
    }

return(weighted_table)
}

