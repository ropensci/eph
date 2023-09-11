#'  Pool de Datos en Panel - Base Individudal EPH continua
#'
#' Permite armar un pool de datos en panel de la EPH continua a partir
#' de especificar una serie consecutiva de bases, variables y el largo de la ventana -window- de observacion
#'
#' @param bases Lista de bases de microdatos a utilizar para armar el pool de datos
#' @param variables Vector con nombres de las variables de interes
#' @param window Especificar distancia temporal entre las observaciones. anual o trimestral
#' @details
#' disclaimer: El script no es un producto oficial de INDEC.
#' @return Devuelve el pool de datos de panel
#' @export
#'
#' @examples
#'
#' lista_bases <- list(toybase_individual_2016_03, toybase_individual_2016_04)
#' pool_trimestral <- organize_panels(
#'   bases = lista_bases,
#'   variables = c("P21", "ESTADO"),
#'   window = "trimestral"
#' )
organize_panels <- function(bases, variables, window = "anual") {
  if (!is.list(bases)) {
    cli::cli_abort(c(
      "El argumento bases requiere un objeto de tipo lista."
    ))
  }
  if (!window %in% c("anual", "trimestral")) {
    cli::cli_abort(c(
      "Elegir alguna de las opciones de window: 'anual' u 'trimestral'."
    ))
  }

  bases_continua <- dplyr::bind_rows(bases) %>%
    dplyr::select(tidyselect::all_of(c("CODUSU", "NRO_HOGAR", "COMPONENTE",
                  "ANO4", "TRIMESTRE", "CH04", "CH06", variables))) %>%
    dplyr::filter(ESTADO != 0) %>%
    dplyr::mutate(Periodo = zoo::as.yearqtr(paste0(ANO4, " Q", TRIMESTRE)))

  ## Creo una Replica de la base, y le agrego (_t1) al nombre de cada
  ## variable, excepto a las que voy a usar para "matchear".
  Teuno <- function(x) {
    paste0(x, "_t1")
  }

  ## En Base a la amplitud del panel que especificare al correr en la funcion resto en la Base
  ## Replica el identificador de Trimestre construido, para hacer un join  con la Base.

  bases_continua_join <- bases_continua %>%
    dplyr::rename_at(dplyr::vars(-c(1:3, ncol(.))), Teuno) %>%
    dplyr::mutate(Periodo = dplyr::case_when(
      window == "anual" ~ Periodo - 1,
      window == "trimestral" ~ Periodo - 0.25
    ))

  panel_continua <- dplyr::inner_join(bases_continua,
    bases_continua_join,
    by = c("CODUSU", "NRO_HOGAR", "COMPONENTE", "Periodo")
  ) %>%
    dplyr::mutate(consistencia = dplyr::case_when(
      abs(CH06_t1 - CH06) > 2 |
        CH04 != CH04_t1 ~ FALSE,
      TRUE ~ TRUE
    ))

  consistencias_continua <- panel_continua %>%
    dplyr::group_by(Periodo) %>%
    dplyr::summarise(
      sin_controles = dplyr::n(),
      con_controles = sum(consistencia, na.rm = TRUE),
      perdida = 1 - (con_controles / sin_controles)
    )

  return(panel_continua)
}
