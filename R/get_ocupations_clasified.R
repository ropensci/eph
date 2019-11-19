#'Clasificador de Ocupaciones
#'@description
#'Función para clasificar las ocupaciones según las 4 dimensiones del Clasificador Nacional de Ocupaciones (CNO 2001)
#'@param base Base individual de uno o más períodos
#'@details #'disclaimer: El script no es un producto oficial de INDEC.
#'
#'@examples
#'
#'#'
#'bases <- dplyr::bind_rows(toybase_individual_2016_03,toybase_individual_2016_04)
#'bases_clasif <- get_ocupations_clasified(base = bases)
#'
#'@export
get_ocupations_clasified <- function(base){

##Estos 4 df quizás podrían ir como RDA guardados en vez de CNO
##que, si bien condensa toda la info,  está en un formato que mucho no ayuda
##La otra opción es definir las categorías a mano con case_when

    categoria <- CNO %>%
    dplyr::filter(digit==12) %>%
    dplyr::select(value,CATEGORIA = label)


  tecnologia <- CNO %>%
    dplyr::filter(digit==3) %>%
    dplyr::select(value,TECNOLOGIA = label)


  jerarquia <- CNO %>%
    dplyr::filter(digit==4) %>%
    dplyr::select(value,JERARQUIA = label)

  calificacion <- CNO %>%
    dplyr::filter(digit==5) %>%
    dplyr::select(value,CALIFICACION = label)


    base <- base %>%
      dplyr::mutate(PP04D_COD = as.character(PP04D_COD),
                    CLASIF_CNO = dplyr::case_when(nchar(PP04D_COD) == 5 ~ PP04D_COD,
                                          nchar(PP04D_COD) == 4 ~ paste0("0", PP04D_COD),
                                          nchar(PP04D_COD) == 3 ~ paste0("00", PP04D_COD),
                                          nchar(PP04D_COD) == 2 ~ paste0("000", PP04D_COD),
                                          nchar(PP04D_COD) == 1 ~ paste0("0000", PP04D_COD)),
                    DIGIT12= substr(CLASIF_CNO,1,2),
                    DIGIT3 = substr(CLASIF_CNO,3,3),
                    DIGIT4 = substr(CLASIF_CNO,4,4),
                    DIGIT5 = substr(CLASIF_CNO,5,5)) %>%
      dplyr::left_join(.,categoria,
                       by = c("DIGIT12" = "value")) %>%
      dplyr::left_join(.,tecnologia,
                       by = c("DIGIT3" = "value")) %>%
      dplyr::left_join(.,jerarquia,
                       by = c("DIGIT4" = "value")) %>%
      dplyr::left_join(.,calificacion,
                       by = c("DIGIT5" = "value")) %>%
      dplyr::select(-c(CLASIF_CNO,DIGIT12,DIGIT3,DIGIT4,DIGIT5))



    return(base)
}


