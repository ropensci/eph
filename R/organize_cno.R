#' Clasificador de Ocupaciones
#' @description
#' Funcion para clasificar las ocupaciones segun las 4 dimensiones del Clasificador Nacional de Ocupaciones
#' (CNO 2001)
#' @param base Base individual de uno o mas periodos
#'
#' @return Devuelve la base con 4 columnas nuevas (que indican la informacion correspondiente al Clasificador Nacional de Ocupaciones)
#'
#' @details
#' Importante: Verificar que el clasificador CNO 2001 sea compatible con la base que estes utilizando.
#'
#' disclaimer: El script no es un producto oficial de INDEC.
#'
#' @examples
#'
#'
#' bases <- dplyr::bind_rows(toybase_individual_2016_03, toybase_individual_2016_04)
#' bases_clasificadas <- organize_cno(base = bases)
#'
#' @export
organize_cno <- function(base) {
  ## Estos 4 df quizas podrian ir como RDA guardados en vez de CNO
  ## que, si bien condensa toda la info,  esta en un formato que mucho no ayuda
  ## La otra opcion es definir las categorias a mano con case_when

  caracter <- CNO %>%
    dplyr::filter(digit == 12) %>%
    dplyr::select(value, CATEGORIA = label) %>%
    dplyr::add_row(value = "99", CATEGORIA = "Ns.Nc")

  jerarquia <- CNO %>%
    dplyr::filter(digit == 3) %>%
    dplyr::select(value, JERARQUIA = label) %>%
    dplyr::add_row(value = "9", JERARQUIA = "Ns.Nc")

  tecnologia <- CNO %>%
    dplyr::filter(digit == 4) %>%
    dplyr::select(value, TECNOLOGIA = label) %>%
    dplyr::add_row(value = "9", TECNOLOGIA = "Ns.Nc")

  calificacion <- CNO %>%
    dplyr::filter(digit == 5) %>%
    dplyr::select(value, CALIFICACION = label) %>%
    dplyr::add_row(value = c("6", "7", "8", "9"), CALIFICACION = c("mal codificado", "falta informacion", "otro", "Ns.Nc"))

  base <- base %>%
    dplyr::mutate(
      PP04D_COD = as.character(PP04D_COD),
      CLASIF_CNO = stringr::str_pad(PP04D_COD, 5, side = "left", pad = "0"),
      DIGIT12 = substr(CLASIF_CNO, 1, 2),
      DIGIT3 = substr(CLASIF_CNO, 3, 3),
      DIGIT4 = substr(CLASIF_CNO, 4, 4),
      DIGIT5 = substr(CLASIF_CNO, 5, 5)
    ) %>%
    dplyr::left_join(., caracter,
      by = c("DIGIT12" = "value")
    ) %>%
    dplyr::left_join(., jerarquia,
      by = c("DIGIT3" = "value")
    ) %>%
    dplyr::left_join(., tecnologia,
      by = c("DIGIT4" = "value")
    ) %>%
    dplyr::left_join(., calificacion,
      by = c("DIGIT5" = "value")
    ) %>%
    dplyr::select(-tidyselect::any_of(c("CLASIF_CNO", "DIGIT12", "DIGIT3", "DIGIT4", "DIGIT5")))



  return(base)
}
