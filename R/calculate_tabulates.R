#' Tabulado con ponderacion
#' @importFrom rlang .data
#' @description
#' Funcion para crear tabulados uni o bivariados con ponderacion, totales parciales y porcentajes.
#' @param base Dataframe
#' @param x string con el nombre de la variable a tabular
#' @param y otro string (opcional) con el nombre de una segunda variable, para una tabla de doble entrada. Tiene que ser de igual largo que x
#' @param weights string con el nombre de la variable con los pesos de pesos, tiene que ser de igual largo que x
#' @param digits numero de digitos significativos
#' @param affix_sign si es TRUE agrega el signo \% al final
#' @param add.totals  toma los valores c('none','row','col','both'), para agregar totales por fila, columna o ambos
#' @param add.percentage toma los valores c('none','row','col'), para agregar porcentajes por fila y columna
#'
#' @return Devuelve un tabulado uni o bivariado con ponderacion, totales parciales y porcentajes.
#'
#' @examples
#'
#'
#' ### Tabla simple ###
#'
#' calculate_tabulates(
#'   base = toybase_individual_2016_04,
#'   x = "REGION", y = "CH04",
#'   weights = "PONDERA"
#' )
#'
#' ### Totales por fila ###
#'
#' calculate_tabulates(
#'   base = toybase_individual_2016_04,
#'   x = "REGION", y = "CH04",
#'   weights = "PONDERA", add.totals = "row"
#' )
#'
#' ### Totales por columna ###
#'
#' calculate_tabulates(
#'   base = toybase_individual_2016_04,
#'   x = "REGION", y = "CH04",
#'   weights = "PONDERA", add.totals = "col"
#' )
#'
#' ### Porcentajes por fila ###
#'
#' calculate_tabulates(
#'   base = toybase_individual_2016_04,
#'   x = "REGION", y = "CH04",
#'   weights = "PONDERA", add.percentage = "row"
#' )
#'
#' @export

calculate_tabulates <- function(base,
                                x, y = NULL,
                                weights = NULL, affix_sign = FALSE, digits = 1,
                                add.totals = "none", add.percentage = "none") {
  # Controles de los parametros
  if (!is.vector(x)) {
    cli::cli_abort(c(
      "El formato de la variable a tabular no es valido.",
      "i" = "Ingrese un string"
    ))
  }

  if (!add.totals %in% c("none", "row", "col", "both")) {
    cli::cli_abort(c(
      "Elegir alguna de las opciones de add.totals: 'none','row', 'col' o 'both'."
    ))
  }

  if (!add.percentage %in% c("none", "row", "col")) {
    cli::cli_abort(c(
      "Elegir alguna de las opciones de add.percentage: 'none','row' o 'col'."
    ))
  }

  if (!is.numeric(digits)) {
    cli::cli_abort(c(
      "El argumento digits debe ser numeric."
    ))
  }

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
    y_vec <- NULL
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
    weights_vec <- NULL
  }


  ###############################################################
  ####### Tabulado uni-variado - ponderado

  if (!is.null(weights) & is.null(y)) {
    tabulado <- stats::xtabs(weights_vec ~ x_vec, data = base) %>%
      as.data.frame(.)

    names(tabulado) <- c(paste0(x), names(tabulado)[2:ncol(tabulado)])
  }


  ###############################################################
  ######## Tabulado bi-variado - ponderado

  if (!is.null(weights) & !is.null(y)) {
    tabulado <- stats::xtabs(weights_vec ~ x_vec + y_vec,
      data = base
    ) %>%
      as.data.frame(.)

    tabulado <- tabulado %>%
      tidyr::pivot_wider(.,
        names_from = y_vec,
        values_from = Freq
      )


    names(tabulado) <- c(paste0(x, "/", y), names(tabulado)[2:ncol(tabulado)])
  }



  ###############################################################
  ######## Tabulado bi-variado - NO ponderado
  if (is.null(weights) & !is.null(y_vec)) {
    tabulado <- stats::xtabs(~ x_vec + y_vec, data = base) %>%
      as.data.frame(.)

    tabulado <- tabulado %>%
      tidyr::pivot_wider(.,
        names_from = y_vec,
        values_from = Freq
      )

    names(tabulado) <- c(paste0(x, "/", y), names(tabulado)[2:ncol(tabulado)])
  }


  ###############################################################
  ####### Tabulado uni-variado - NO ponderado

  if (is.null(weights) & is.null(y)) {
    tabulado <- stats::xtabs(~x_vec, data = base) %>%
      as.data.frame(.)

    names(tabulado) <- c(paste0(x), names(tabulado)[2:ncol(tabulado)])
  }

  ##### Early return

  if (add.totals == "none" & add.percentage == "none") {
    return(tabulado)
  }

  ### add.totals

  if (add.percentage == "none") {
    if (add.totals == "row") {
      totales <- data.frame(
        "label" = "Total",
        "var" = names(tabulado)[2:ncol(tabulado)],
        "valor" = colSums(tabulado[2:ncol(tabulado)])
      ) %>%
        tidyr::pivot_wider(names_from = var, values_from = valor)

      names(totales)[1] <- paste0(names(tabulado)[1])

      tabulado <- dplyr::bind_rows(tabulado, totales)
    }

    if (add.totals == "col") {
      totales <- tabulado %>%
        dplyr::select_if(is.numeric) %>%
        dplyr::transmute(Total = rowSums(., na.rm = TRUE))

      tabulado <- dplyr::bind_cols(tabulado, totales)
    }

    if (add.totals == "both") {
      totales_c <- tabulado %>%
        dplyr::select_if(is.numeric) %>%
        dplyr::transmute(Total = rowSums(., na.rm = TRUE))

      tab_intermedio <- dplyr::bind_cols(tabulado, totales_c)

      totales_r <- data.frame(
        "label" = "Total",
        "var" = names(tab_intermedio)[2:ncol(tab_intermedio)],
        "valor" = colSums(tab_intermedio[2:ncol(tab_intermedio)])
      ) %>%
        tidyr::pivot_wider(names_from = var, values_from = valor)

      names(totales_r)[1] <- paste0(names(tab_intermedio)[1])

      tabulado <- dplyr::bind_rows(tab_intermedio, totales_r)
    }


    return(tabulado)
  }

  ### add.percentage

  if (add.percentage == "col") {
    perc_col <- tabulado %>%
      dplyr::mutate(Total = rowSums(dplyr::across(dplyr::where(is.numeric)))) %>%
      tidyr::pivot_longer(cols = !names(tabulado)[1],
                          names_to = "var",
                          values_to = "valor") %>%
      dplyr::group_by(var) %>%
      dplyr::mutate(aux = sum(valor, na.rm = TRUE)) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(prop = round((valor / aux) * 100, digits)) %>%
      dplyr::select(-tidyselect::any_of(c("valor", "aux"))) %>%
      tidyr::pivot_wider(names_from = var, values_from = prop)

    if (add.totals == "col") {
      tabulado <- perc_col
    }

    if (add.totals == "row") {
      perc_col <- perc_col[, 1:(ncol(perc_col) - 1)]

      totales <- data.frame(
        "label" = "Total",
        "var" = names(perc_col)[2:ncol(perc_col)],
        "valor" = round(100, digits)
      ) %>%
        tidyr::pivot_wider(names_from = var, values_from = valor)

      names(totales)[1] <- paste0(names(perc_col)[1])

      tabulado <- dplyr::bind_rows(perc_col, totales)
    }

    if (add.totals == "none") {
      tabulado <- perc_col[, 1:(ncol(perc_col) - 1)]
    }

    if (add.totals == "both") {
      totales <- data.frame(
        "label" = "Total",
        "var" = names(perc_col)[2:ncol(perc_col)],
        "valor" = round(100, digits)
      ) %>%
        tidyr::pivot_wider(names_from = var, values_from = valor)

      names(totales)[1] <- paste0(names(perc_col)[1])

      tabulado <- dplyr::bind_rows(perc_col, totales)
    }
  }

  if (add.percentage == "row") {
    totales <- data.frame(
      "label" = "Total",
      "var" = names(tabulado)[2:ncol(tabulado)],
      "valor" = colSums(tabulado[2:ncol(tabulado)])
    ) %>%
      tidyr::pivot_wider(names_from = var, values_from = valor)

    names(totales)[1] <- paste0(names(tabulado)[1])

    tabulado <- dplyr::bind_rows(tabulado, totales)

    perc_row <- tabulado %>%
      dplyr::mutate(aux = rowSums(dplyr::across(dplyr::where(is.numeric)))) %>%
      dplyr::mutate(dplyr::across(c(names(tabulado)[2:ncol(tabulado)]), function(x) round((x / aux) * 100, digits))) %>%
      dplyr::select(-tidyselect::any_of(c("aux")))


    if (add.totals == "col") {
      perc_row <- perc_row[1:(nrow(perc_row) - 1), ]

      totales <- perc_row %>%
        dplyr::select_if(is.numeric) %>%
        dplyr::transmute(Total = rowSums(., na.rm = TRUE))

      tabulado <- dplyr::bind_cols(perc_row, totales)
    }

    if (add.totals == "row") {
      tabulado <- perc_row
    }


    if (add.totals == "none") {
      tabulado <- perc_row[1:(nrow(perc_row) - 1), ]
    }

    if (add.totals == "both") {
      totales <- perc_row %>%
        dplyr::select_if(is.numeric) %>%
        dplyr::transmute(Total = rowSums(., na.rm = TRUE))

      tabulado <- dplyr::bind_cols(perc_row, totales)
    }
  }

  if (affix_sign == TRUE) {
    tabulado <- tabulado %>%
      dplyr::mutate_at(dplyr::vars(names(tabulado)[2:ncol(tabulado)]), function(x) paste0(x, "%"))
  }

  return(tabulado)
}
