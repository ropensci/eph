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




  ###############################################################
  ######## Tabulado bi-variado - ponderado
  if(!is.null(weights) & !is.null(y)){
    tabulado <- xtabs(weights_vec ~ x_vec + y_vec,
                          data = base)

    tabulado <- as.data.frame(tabulado) %>%
      tidyr::pivot_wider(.,
                         names_from = y_vec,
                         values_from = Freq)


    names(tabulado) <- c(paste0(x,'/',y),names(tabulado)[2:ncol(tabulado)])

  }



  ###############################################################
  ####### Tabulado uni-variado - ponderado

  if(!is.null(weights) & is.null(y)){
    tabulado <- as.data.frame(xtabs(weights_vec ~ x_vec,
                                         data = base))

    names(tabulado) <- c(paste0(x),names(tabulado)[2:ncol(tabulado)])
  }



  ###############################################################
  ######## Tabulado bi-variado - NO ponderado
  if(is.null(weights) & !is.null(y_vec)){
    tabulado <- xtabs(~ x_vec + y_vec,
                        data = base)

    tabulado <- as.data.frame(tabulado) %>%
      tidyr::pivot_wider(.,
                         names_from = y_vec,
                         values_from = Freq)

    names(tabulado) <- c(paste0(x,'/',y),names(tabulado)[2:ncol(tabulado)])

  }




  ###############################################################
  ####### Tabulado uni-variado - NO ponderado

  if(is.null(weights) & is.null(y)){
    tabulado <- as.data.frame(xtabs(~ x_vec,
                                    data = base))

    names(tabulado) <- c(paste0(x),names(tabulado)[2:ncol(tabulado)])
  }


  #
  # if (add.totals=='row') {
  #   tabulado <- tabulado %>%
  #     janitor::adorn_totals("row")
  # } else{
  #   if (add.totals=='col') {
  #     tabulado <- tabulado %>%
  #       janitor::adorn_totals("col")
  #   } else{
  #     if (add.totals =='both') {
  #       tabulado <- tabulado %>%
  #         janitor::adorn_totals("row") %>%
  #         janitor::adorn_totals("col")
  #     }
  #   }
  # }
  # if (add.percentage == 'col') {
  #   if (affix_sign == TRUE) {
  #     tabulado <- tabulado %>%
  #       janitor::adorn_percentages("col") %>%
  #       janitor::adorn_pct_formatting(affix_sign = TRUE)
  #   } else {
  #     if (affix_sign == FALSE) {
  #       tabulado <- tabulado %>%
  #         janitor::adorn_percentages("col") %>%
  #         janitor::adorn_pct_formatting(affix_sign = FALSE)}
  #   }
  # } else {
  #   if (add.percentage == 'row') {
  #     if (affix_sign == TRUE) {
  #       tabulado <- tabulado %>%
  #         janitor::adorn_percentages("row") %>%
  #         janitor::adorn_pct_formatting(affix_sign = TRUE)
  #     } else {
  #       if (affix_sign == FALSE) {
  #         tabulado <- tabulado %>%
  #           janitor::adorn_percentages("row") %>%
  #           janitor::adorn_pct_formatting(affix_sign = FALSE)}
  #     }
  #   }
  # }

  return(tabulado)


}

