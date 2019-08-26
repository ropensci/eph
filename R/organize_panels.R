#'  Pool de Datos en Panel - Base Individudal EPH continua
#'
#'Permite armar un pool de datos en panel de la EPH continua a partir
#'de especificar una serie consecutiva de bases, variables y el largo de la window de observación
#'
#' @param bases Lista de bases de microdatos a utilizar para armar el pool de datos
#' @param variables Vector con nombres de las variables de interés
#' @param window Especificar distancia temporal entre las observaciones. anual o trimestral
#' @details
#'disclaimer: El script no es un producto oficial de INDEC.
#' @return Devuelve el pool de datos de panel
#' @export
#'
#' @examples
#'
#' lista_bases <- list(toybase_individual_2016_03,toybase_individual_2016_04)
#' pool_trimestral <- organize_panels(bases = lista_bases,
#'                     variables =c("P21","ESTADO"),
#'                     window = "trimestral")

organize_panels <- function(bases,variables,window = "anual"){

  assertthat::assert_that(is.list(bases),
                          msg = "El argumento bases requiere un objeto de tipo lista")
  assertthat::assert_that(window %in% c("anual", "trimestral"),
                          msg = "Las opciones para window son: anual y trimestral")

  bases_continua <- dplyr::bind_rows(bases) %>%
    dplyr::select(CODUSU,NRO_HOGAR,COMPONENTE,ANO4,TRIMESTRE,CH04,CH06,variables) %>%
    dplyr::filter(ESTADO !=0) %>%
    dplyr::mutate(Trimestre = paste(ANO4, TRIMESTRE, sep="_"))%>%
    dplyr::arrange(Trimestre) %>%
    dplyr::mutate(Id_Trimestre = match(Trimestre,unique(Trimestre)))


  ##Creo una Replica de la base, y le agrego (_t1) al nombre de cada
  ##variable, excepto a las que voy a usar para "matchear".

  bases_continua_join <- bases_continua
  names(bases_continua_join)[!(names(bases_continua_join) %in%
                                 c("CODUSU","COMPONENTE","NRO_HOGAR","Id_Trimestre"))] <- paste0(names(bases_continua_join)[
                                   !(names(bases_continua_join) %in%
                                       c("CODUSU","COMPONENTE","NRO_HOGAR","Id_Trimestre"))],"_t1")

  ##En Base a la amplitud del panel que especificaré al correr en la funcion resto en la Base
  ##Replica el identificador de Trimestre construido, para hacer un join  con la Base.
  t <- dplyr::case_when(window == "anual"      ~ 4,
                 window == "trimestral"~ 1)

  bases_continua_join$Id_Trimestre <- bases_continua_join$Id_Trimestre - t

  panel_continua <- dplyr::inner_join(bases_continua,bases_continua_join) %>%
    dplyr::mutate(consistencia = dplyr::case_when(
                                                  abs(CH06_t1-CH06) > 2 |
                                                  CH04 != CH04_t1 ~ FALSE,
                                                  TRUE ~ TRUE))

  consistencias_continua <- panel_continua %>%
    dplyr::group_by(Trimestre) %>%
    dplyr::summarise(sin_controles = n(),
              con_controles = sum(consistencia,na.rm = TRUE),
              perdida = 1 - (con_controles/sin_controles))

  return(panel_continua)
}

