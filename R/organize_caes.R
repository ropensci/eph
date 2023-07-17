#' @title Clasificador de Actividades
#' @description Funcion para clasificar las actividades economicas segun el
#'              Clasificador de actividades economicas para encuestas sociodemograficas.
#'              CAES Mercosur 1.0 y CAES Mercosur.
#'              Basado en https://www.indec.gob.ar/ftp/cuadros/menusuperior/clasificadores/notas_explicativas_caes_v2018.pdf
#'
#' @param base  Base individual de uno o mas periodos
#'
#' @return Devuelve la base con 8 columnas nuevas (ver `caes`)
#'
#' @details disclaimer: El script no es un producto oficial de INDEC.
#'
#' No olvides contemplar los cambios en la codificacion y categorias de las distintas versiones del clasificador CAES para la elaboracion de series de largo plazo.
#' @export
#'
#' @examples
#' bases <- dplyr::bind_rows(toybase_individual_2016_03, toybase_individual_2016_04)
#' bases_clasificadas <- organize_caes(base = bases)
#'
organize_caes <- function(base) {
  if ("PP04B_CAES" %in% names(base)) {
    warning("Creando nueva variable PP04B_COD como copia de PP04B_CAES por compatibilidad.")
    base <- base %>%
      dplyr::mutate(PP04B_COD = dplyr::case_when(
        ANO4 %in% 2011:2015 ~ PP04B_CAES,
        TRUE ~ PP04B_COD
      ))
  }

  warning("Convirtiendo PP04B_COD a character")
  base <- base %>%
    dplyr::mutate(
      PP04B_COD = as.character(PP04B_COD),
      PP04B_COD = dplyr::case_when(
        nchar(PP04B_COD) == 1 ~ paste0("0", PP04B_COD),
        nchar(PP04B_COD) == 2 ~ PP04B_COD,
        nchar(PP04B_COD) == 3 ~ paste0("0", PP04B_COD),
        nchar(PP04B_COD) == 4 ~ PP04B_COD
      ),
      caes_version = dplyr::case_when(
        ANO4 >= 2011 ~ "1.0",
        ANO4 < 2011 ~ "0"
      )
    )

  base <- base %>%
    dplyr::left_join(caes, by = c("PP04B_COD", "caes_version"))

  if (any(base$ANO4 < 2011) & any(base$ANO4 >= 2011)) {
    warning("Para los datos anteriores a 2011 se aplico la clasificacion CAES v.0 y para los de 2011 en adelante la clasificacion CAES v.1.0")
  }
  return(base)
}
