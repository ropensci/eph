#' @title organize_caes
#' @description Base con codigos y etiquetas del Clasificador de actividades economicas para encuestas sociodemograficas.
#'              CAES Mercosur 1.0 - Actualizacion 2018.
#'              Basado en https://bit.ly/notas-explicativas-CAES-v2018 y
#'              https://www.indec.gob.ar/ftp/cuadros/menusuperior/clasificadores/caes_v2018.xls,
#'              obtenidos de
#'              https://www.indec.gob.ar/indec/web/Institucional-Indec-Clasificadores
#'
#' @param base  Base individual de uno o mas periodos
#'
#' @return Devuelve la base con 7 columnas nuevas (ver \code{\link{caes}})
#'
#'@details Disclaimer: El script no es un producto oficial de INDEC.
#'
#'Importante: El usuario debe garantizarse que el clasificador CAES 1.0 es compatible con la base que esta utilizando
#' @export
#'
#' @examples
#'bases <- dplyr::bind_rows(toybase_individual_2016_03,toybase_individual_2016_04)
#'
#'organize_caes(base = bases)
#'
organize_caes <- function(base){

  if ('PP04B_CAES' %in% names(base)) {
    warning("Creando nueva variable PP04B_COD como copia de PP04B_CAES por compatibilidad.")
    base <- base %>%
      dplyr::mutate(PP04B_COD  = PP04B_CAES)
  }

    warning("Convirtiendo PP04B_COD a character")
    base <- base %>%
      dplyr::mutate(PP04B_COD = as.character(PP04B_COD),
                    PP04B_COD =  dplyr::case_when(nchar(PP04B_COD) == 1 ~ paste0("0", PP04B_COD),
                                           nchar(PP04B_COD) == 2 ~ PP04B_COD,
                                           nchar(PP04B_COD) == 3 ~ paste0("0", PP04B_COD),
                                           nchar(PP04B_COD) == 4 ~ PP04B_COD))

  base <- base %>%
    dplyr::left_join(caes, by = "PP04B_COD")
}

