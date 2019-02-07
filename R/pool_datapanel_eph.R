#' Pool de Datos en Panel - Base Individudal EPH continua
#'
#'Permite armar un pool de datos en panel de la EPH continua a partir
#'de especificar una serie de bases, variables y el largo de la ventana de observación
#'
#' @param bases Lista de bases de microdatos a utilizar para armar el pool de datos
#' @param variables Vector con nombres de las variables de interés
#' @param ventana Que tipo de distancia temporal entre las obseraciones. anual o trimestral
#'
#' @return Devuelve el pool de datos de panel y un conteo de casos consistentes
#' @export
#'
#' @examples
#' base_1t_2018 <- get_bases_eph(anio = 2018,trimestre = 1)[[2]]
#' base_2t_2018 <- get_bases_eph(anio = 2018,trimestre = 2)[[2]]
#'
#' lista_bases <- list(base_1t_2018,base_2t_2018)
#' pool_datapanel_eph(bases = lista_bases,
#'                     variables =c("P21","ESTADO"),
#'                     ventana = "trimestral")


pool_datapanel_eph <- function(bases,variables,ventana = "anual"){

  assertthat::assert_that(is.list(bases),
                          msg = "El argumento bases requiere un objeto de tipo lista")
  assertthat::assert_that(ventana %in% c("anual", "trimestral"),
                          msg = "Las opciones para ventana son: anual y trimestral")

  if(!require(pacman))install.packages("pacman")
  ### El paquete 'pacman' carga e instala (si no está aún instalado) el paquete que indicamos en la función 'p_load'.
  pacman::p_load(tidyverse)

  bases_continua <<- bind_rows(bases)  %>%
    select(CODUSU,NRO_HOGAR,COMPONENTE,ANO4,TRIMESTRE,CH04,CH06,variables) %>%
    filter(ESTADO !=0) %>%
    mutate(Trimestre = paste(ANO4, TRIMESTRE, sep="_"))%>%
    arrange(Trimestre) %>%
    mutate(Id_Trimestre = match(Trimestre,unique(Trimestre)))


  ##Creo una Replica de la base, y le agrego (_t1) al nombre de cada
  ##variable, excepto a las que voy a usar para "matchear".

  bases_continua_join <- bases_continua
  names(bases_continua_join)[!(names(bases_continua_join) %in%
                                 c("CODUSU","COMPONENTE","NRO_HOGAR","Id_Trimestre"))] <- paste0(names(bases_continua_join)[
                                   !(names(bases_continua_join) %in%
                                       c("CODUSU","COMPONENTE","NRO_HOGAR","Id_Trimestre"))],"_t1")

  ##En Base a la amplitud del panel que especificaré al correr en la funcion resto en la Base
  ##Replica el identificador de Trimestre construido, para hacer un join  con la Base.
  t <- case_when(ventana == "anual"      ~ 4,
                 ventana == "trimestral"~ 1)

  bases_continua_join$Id_Trimestre <- bases_continua_join$Id_Trimestre - t

  panel_continua <<- inner_join(bases_continua,bases_continua_join) %>%
    mutate(consistencia = case_when(abs(CH06_t1-CH06) > 2 |
                                    CH04 != CH04_t1 ~ FALSE,
                                    TRUE ~ TRUE))

  consistencias_continua <<- panel_continua %>%
    group_by(Trimestre) %>%
    summarise(sin_controles = n(),
              con_controles = sum(consistencia,na.rm = TRUE),
              perdida = 1 - (con_controles/sin_controles))

}

