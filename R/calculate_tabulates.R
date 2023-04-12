#'Tabulado con ponderacion
#'@description
#'Funcion para crear tabulados uni o bivariados con ponderacion, totales parciales y porcentajes.
#'@param base Dataframe
#'@param x string con el nombre de la variable a tabular
#'@param y otro string (opcional) con el nombre de una segunda variable, para una tabla de doble entrada. Tiene que ser de igual largo que x
#'@param weights string con el nombre de la variable con los pesos de pesos, tiene que ser de igual largo que x
#'@param digits numero de digitos significativos
#'@param affix_sign si es TRUE agrega el signo \% al final
#'@param addNA de haber, cuenta valores NA
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

calculate_tabulates <- function(base,
                                x, y = NULL,
                                weights = NULL, affix_sign = FALSE, digits = 1, addNA = FALSE,
                                add.totals = 'none', add.percentage = 'none'){


  # Controles de los parametros
  assertthat::assert_that(is.vector(x))
  assertthat::assert_that(add.totals %in% c('none','row','col','both'),msg = "Elegir alguna de las opciones de add.totals: 'none','row', 'col' o 'both'.")
  assertthat::assert_that(add.percentage %in% c('none','row','col'),msg = "Elegir alguna de las opciones de add.percentage: 'none','row' o 'col'.")
  assertthat::assert_that(is.numeric(digits),msg = "digits debe ser numeric.")

  if (x %in% names(base)) {
    x_vec <- base[[x]]
  } else {
    cli::cli_abort(c(
      "La variable x no pertence a la base de datos",
      "i" = "Puede usar names() para extraer los nombres de las variables."
    ))
  }


  ## Vector y
  if (!is.null(y)) {

    if (y %in% names(base)) {
    y_vec <- base[[y]]
    } else {
      cli::cli_abort(c(
        "La variable y no pertence a la base de datos",
        "i" = "Puede usar names() para extraer los nombres de las variables."
      ))
    }

  } else {

    y_vec = NULL
  }



  ## weight[ponderador]
  if (!is.null(weights)) {

    if (weights %in% names(base)) {
      weights_vec <- base[[weights]]
    } else {
      cli::cli_abort(c(
        "La variable weights no pertence a la base de datos",
        "i" = "Puede usar names() para extraer los nombres de las variables."
      ))
    }

  } else {

    weights_vec = NULL
  }


  ###############################################################
  ####### Tabulado uni-variado - ponderado

  if(!is.null(weights) & is.null(y)){

    tabulado <- stats::xtabs(weights_vec ~ x_vec, data = base) %>%
      as.data.frame(.)

    names(tabulado) <- c(paste0(x),names(tabulado)[2:ncol(tabulado)])
  }


  ###############################################################
  ######## Tabulado bi-variado - ponderado

  if(!is.null(weights) & !is.null(y)){

    tabulado <- stats::xtabs(weights_vec ~ x_vec + y_vec,
                             data = base) %>%
      as.data.frame(.)

    tabulado <- tabulado %>%
      tidyr::pivot_wider(.,
                         names_from = y_vec,
                         values_from = Freq)


    names(tabulado) <- c(paste0(x,'/',y),names(tabulado)[2:ncol(tabulado)])

  }



  ###############################################################
  ######## Tabulado bi-variado - NO ponderado
  if(is.null(weights) & !is.null(y_vec)){

    tabulado <- stats::xtabs(~ x_vec + y_vec, data = base) %>%
      as.data.frame(.)

    tabulado <- tabulado %>%
      tidyr::pivot_wider(.,
                         names_from = y_vec,
                         values_from = Freq)

    names(tabulado) <- c(paste0(x,'/',y),names(tabulado)[2:ncol(tabulado)])

  }


  ###############################################################
  ####### Tabulado uni-variado - NO ponderado

  if(is.null(weights) & is.null(y)){

    tabulado <- stats::xtabs(~ x_vec, data = base) %>%
      as.data.frame(.)

    names(tabulado) <- c(paste0(x),names(tabulado)[2:ncol(tabulado)])
  }



  ### add.totals
  if (add.totals=='row') {

    tabulado <- tabulado %>%
      janitor::adorn_totals("row")

  } else{

    if (add.totals=='col') {

      tabulado <- tabulado %>%
        janitor::adorn_totals("col")

    } else {

      if (add.totals =='both') {

        tabulado <- tabulado %>%
          janitor::adorn_totals("row") %>%
          janitor::adorn_totals("col")
      }
    }
  }


  ### add.percentage

  if (add.percentage == 'col') {

    tabulado <- tabulado %>%
      janitor::adorn_percentages("col") %>%
      janitor::adorn_pct_formatting(affix_sign = affix_sign, digits = digits)
  }

  if (add.percentage == 'row') {
    tabulado <- tabulado %>%
      janitor::adorn_percentages("row") %>%
      janitor::adorn_pct_formatting(affix_sign = affix_sign, digits = digits)
  }

  if(affix_sign == FALSE){

    tabulado <- tabulado %>%
      dplyr::mutate(dplyr::across(.cols = 2:length(.), ~ as.numeric(.)))
  }

  return(tabulado)
}
