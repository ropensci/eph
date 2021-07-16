#'Tabulado con ponderacion
#'@description
#'Funcion para crear tabulados uni o bivariados con ponderacion, totales parciales y porcentajes.
#'@param base Dataframe
#'@param x string con el nombre de la variable a tabular
#'@param y otro string (opcional) con el nombre de una segunda variable, para una tabla de doble entrada. Tiene que ser de igual largo que x
#'@param weights string con el nombre de la variable con los pesos de pesos, tiene que ser de igual largo que x
#'@param digits numero de digitos significativos
#'@param normwt si es TRUE, normaliza los pesos de modo que el recuento ponderado total sea el mismo que el no ponderado
#'@param exclude valores a remover de x e y
#'@param affix_sign si es TRUE agrega el signo \% al final
#'@param add.totals  toma los valores c('none','row','col','both'), para agregar totales por fila, columna o ambos
#'@param add.percentage toma los valores c('none','row','col'), para agregar porcentajes por fila y columna
#'@examples
#'
#'
#'### tabla simple ###
#'
#'calculate_tabulates(base = toybase_individual_2016_04,
#'                     x = 'REGION', y = 'CH04',
#'                     weights = 'PONDERA')
#'
#'### para ver los totales por fila ###
#'
#'calculate_tabulates(base = toybase_individual_2016_04,
#'                     x = 'REGION', y = 'CH04',
#'                     weights = 'PONDERA', add.totals = 'row')
#'
#'### para ver los totales por columna ###
#'
#'calculate_tabulates(base = toybase_individual_2016_04,
#'                     x = 'REGION', y = 'CH04',
#'                     weights = 'PONDERA', add.totals = 'col')
#'
#'### para ver porcentajes por fila ###
#'
#'calculate_tabulates(base = toybase_individual_2016_04,
#'                     x = 'REGION', y = 'CH04',
#'                     weights = 'PONDERA', add.percentage ='row')
#'
#'@export

calculate_tabulates_prueba <- function(base, x, y = NULL, weights = NULL, affix_sign = FALSE,
                                  add.totals = 'none',
                                  add.percentage = 'none'){


  # Controles de los parametros
  assertthat::assert_that(is.vector(x))
  assertthat::assert_that(add.totals %in% c('none','row','col','both'))
  assertthat::assert_that(add.percentage %in% c('none','row','col'))


if(!is.null(weights) & !is.null(y)){
  cross_w_freq <- as.data.frame(xtabs(data = base,
                                      formula = weights ~ x + y))
}

      simple_w_freq <- as.data.frame(xtabs(data = base,
                                           formula = weights ~ x))
      } else {
        cross_w_freq <- as.data.frame(xtabs(data = base,
                                          formula = weights ~ x + y))
        } else {
        simple_w_freq <- as.data.frame(xtabs(data = base,
                                           formula = weights ~ x))
      }


  if (!is.null(weights)) {
    weights_vec <- base[[weights]]
    weighted_table <- as.data.frame(xtabs(data = base,
                                          formula = weights_vec ~ x_vec + y_vec))

  } else {
    weights_vec = NULL
    weighted_table <- as.data.frame(xtabs(data = base,
                                          ~x_vec + y_vec))
  }



  # weighted_table <- as.data.frame(xtabs(data = base,
  #                                       formula = weights_vec ~ x_vec + y_vec))

  if (!is.null(y)) {
    weighted_table <- weighted_table %>%
      tidyr::spread(., y_vec, Freq)
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
    if (affix_sign == TRUE) {
      weighted_table <- weighted_table %>%
        janitor::adorn_percentages("col") %>%
        janitor::adorn_pct_formatting(affix_sign = TRUE)
    } else {
      if (affix_sign == FALSE) {
        weighted_table <- weighted_table %>%
          janitor::adorn_percentages("col") %>%
          janitor::adorn_pct_formatting(affix_sign = FALSE)}
    }
  } else {
    if (add.percentage == 'row') {
      if (affix_sign == TRUE) {
        weighted_table <- weighted_table %>%
          janitor::adorn_percentages("row") %>%
          janitor::adorn_pct_formatting(affix_sign = TRUE)
      } else {
        if (affix_sign == FALSE) {
          weighted_table <- weighted_table %>%
            janitor::adorn_percentages("row") %>%
            janitor::adorn_pct_formatting(affix_sign = FALSE)}
      }
    }
  }

  return(weighted_table)
}

