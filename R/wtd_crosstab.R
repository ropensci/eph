#'Tabulado bi-variado con ponderación
#'@description
#'Función que genera un cruce de variables ponderadas por una tercera.
#'@param
#'base: data.frame donde se alojan las variables.
#'@param
#'var_row: Variable en fila.
#'@param
#'var_col: Variable en columnas.
#'@param
#'weight_var: Variable correspondiente al factor de ponderación.
#'@param
#'na.rm: TRUE/FALSE, en caso de quere/eliminar los valores NA.
#'@param
#'pct_col: TRUE/FALSE si el 100% es por columnas.
#'@param
#'pct_row: TRUE/FALSE si el 100% es por filas.
#'@details
#'disclaimer: El script no es un producto oficial de INDEC.
#'@examples
#'wtd.crosstab(var_row = df$var_row, var_col = df$var_col, weight_var = df$weighted_var, total = "col", na.rm=TRUE)
#'@export

wtd_crosstab <- function(base, var_row, var_col, weight_var, total = "col", na.rm = TRUE){

# Controles de los parametros
  assertthat::assert_that(total %in% c("col", "row"), msg = "Por favor ingrese 'col' para total por columna o 'row' para total por fila")
  assertthat::assert_that(assertthat::is.flag(na.rm),   msg = "Por favor ingresa TRUE o FALSE")

# Tabulado con valores NA inluídos
  if(na.rm == TRUE){
    weighted_table <- as.data.frame(questionr::wtd.table(var_row, var_col,
                                                         weights = weight_var,
                                                         na.rm = TRUE,
                                                         na.show = FALSE)) %>%
      tidyr::spread(., var_col, Freq)

  # if Porcentaje por columna
  if(total == "col"){
    weighted_table %>%
      janitor::adorn_totals("row") %>%
      janitor::adorn_totals("col") %>%
      janitor::adorn_percentages("col") %>%
      janitor::adorn_pct_formatting()
  } else {

  # if Porcentaje por fila
    if(total == "row"){
    weighted_table %>%
      janitor::adorn_totals("row") %>%
      janitor::adorn_totals("col") %>%
      janitor::adorn_percentages("row") %>%
      janitor::adorn_pct_formatting()
  }
  }
  } else {

    # Tabulado sin valores NA inluídos
  if(na.rm == FALSE){
    weighted_table <- as.data.frame(questionr::wtd.table(var_row, var_col,
                                                         weights = weight_var,
                                                         na.rm = FALSE,
                                                         na.show = TRUE)) %>%
      tidyr::spread(., var_col, Freq)

    # Por columnas
    if(total == "col"){
      weighted_table %>%
        janitor::adorn_totals("row") %>%
        janitor::adorn_totals("col") %>%
        janitor::adorn_percentages("col") %>%
        janitor::adorn_pct_formatting()
    } else {

    # Por fila
      if(total == "row"){
      weighted_table %>%
        janitor::adorn_totals("row") %>%
        janitor::adorn_totals("col") %>%
        janitor::adorn_percentages("row") %>%
        janitor::adorn_pct_formatting()
    }
      }
  }
  }
}

