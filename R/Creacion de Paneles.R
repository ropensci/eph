#' Pool de Datos en Panel Base Individudal EPH Continua
#'
#'Permite armar un pool de datos en panel de la EPH continua a partir
#'de especificar una serie de bases, variables y el largo de la ventana de observación
#'
#' @param Bases Lista de bases de microdatos a utilizar para armar el pool de datos
#' @param Variables Vector con nombres de las variables de interés
#' @param Ventana Que tipo de distancia temporal entre las obseraciones. Anual o Trimestral
#'
#' @return Devuelve el pool de datos de panel y un conteo de casos consistentes
#' @export
#'
#' @examples
#' Lista_Bases <- list(Base_4t_2017,Base_1t_2018,Base_2t_2018)
#' Crea_Panel_Continua(Bases = Lista_Bases,
#'                     Variables =c("P21","ESTADO"),
#'                     Ventana = "Trimestral")


Crea_Panel_Continua <- function(Bases,Variables,Ventana = "Anual"){

  assertthat::assert_that(is.list(Bases),
                          msg = "El argumento Bases requiere un objeto de tipo lista")
  assertthat::assert_that(Ventana %in% c("Anual", "Trimestral"),
                          msg = "Las opciones para Ventana son: Anual y Trimestral")

  if(!require(pacman))install.packages("pacman")
  ### El paquete 'pacman' carga e instala (si no está aún instalado) el paquete que indicamos en la función 'p_load'.
  pacman::p_load(tidyverse)

  Bases_Continua <<- bind_rows(Bases)  %>%
    select(CODUSU,NRO_HOGAR,COMPONENTE,ANO4,TRIMESTRE,CH04,CH06,Variables) %>%
    filter(ESTADO !=0) %>%
    mutate(Trimestre = paste(ANO4, TRIMESTRE, sep="_"))%>%
    arrange(Trimestre) %>%
    mutate(Id_Trimestre = match(Trimestre,unique(Trimestre)))


  ##Creo una Replica de la base, y le agrego (_t1) al nombre de cada
  ##variable, excepto a las que voy a usar para "matchear".

  Bases_Continua_join <- Bases_Continua
  names(Bases_Continua_join)[!(names(Bases_Continua_join) %in%
                                 c("CODUSU","COMPONENTE","NRO_HOGAR","Id_Trimestre"))] <- paste0(names(Bases_Continua_join)[
                                   !(names(Bases_Continua_join) %in%
                                       c("CODUSU","COMPONENTE","NRO_HOGAR","Id_Trimestre"))],"_t1")

  ##En Base a la amplitud del panel que especificaré al correr en la funcion resto en la Base
  ##Replica el identificador de Trimestre construido, para hacer un join  con la Base.
  t <- case_when(Ventana == "Anual"      ~ 4,
                 Ventana == "Trimestral"~ 1)

  Bases_Continua_join$Id_Trimestre <- Bases_Continua_join$Id_Trimestre - t

  Panel_Continua <<- inner_join(Bases_Continua,Bases_Continua_join) %>%
    mutate(Consistencia = case_when(abs(CH06_t1-CH06) > 2 |
                                      CH04 != CH04_t1 ~ FALSE,
                                    TRUE ~ TRUE))

  Consistencias_Continua <<- Panel_Continua %>%
    group_by(Trimestre) %>%
    summarise(Sin_Controles = n(),
              Con_Controles = sum(Consistencia,na.rm = TRUE),
              Perdida = 1 - (Con_Controles/Sin_Controles))

}

