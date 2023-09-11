#' Calculo de Pobreza e Indigencia
#' @description
#' Funcion para calcular la pobreza e indigencia siguiendo la metodologia de linea.
#' @param base Base individual de uno o mas periodos
#' @param basket canasta basica alimentaria y total, con la estructura de la canasta de ejemplo (ver `canastas_reg_example`)
#' @param print_summary default = TRUE. Opcion para imprimir las tasas de pobreza e indigencia (proporcion de individuos)
#' @param window default = "quarter". Opcion para cambiar el lapso del calculo que se imprime en consola.
#' "quarter" (para estimacion trimestral) o "semester" (estimacion semestral)
#' @param group_vars Opcion para agregar variables agrupadoras para el calculo que se imprime en consola.
#'
#' @return Devuelve la base agregando informacion respecto a la situacion de cada hogar en terminos de sus ingresos: indigente, pobre o no pobre (a estos fines, se agregan 5 columnas nuevas).
#'
#' @details disclaimer: El script no es un producto oficial de INDEC.
#'
#' @examples
#'
#' bases <- dplyr::bind_rows(
#'   toybase_individual_2016_03,
#'   toybase_individual_2016_04
#' )
#'
#' base_pobreza <- calculate_poverty(
#'   base = bases,
#'   basket = canastas_reg_example,
#'   print_summary = TRUE,
#'   group_vars = c(CH04, NIVEL_ED),
#'   window = "semestral"
#' )
#'
#' @export

calculate_poverty <- function(base, basket, print_summary = TRUE, window = "quarter", group_vars = c()) {
  base <- base %>%
    dplyr::mutate(periodo = paste(ANO4, TRIMESTRE, sep = ".")) %>%
    dplyr::left_join(., adulto_equivalente, by = c("CH04", "CH06")) %>%
    dplyr::left_join(., basket, by = c("REGION" = "codigo", "periodo")) %>%
    dplyr::group_by(CODUSU, NRO_HOGAR, periodo) %>%
    dplyr::mutate(adequi_hogar = sum(adequi)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(
      CBA_hogar = CBA * adequi_hogar,
      CBT_hogar = CBT * adequi_hogar,
      situacion = dplyr::case_when(
        ITF < CBA_hogar ~ "indigente",
        ITF >= CBA_hogar & ITF < CBT_hogar ~ "pobre",
        ITF >= CBT_hogar ~ "no_pobre"
      ),
      # excluyo los casos que no tienen respuesta en ITF
      situacion = dplyr::case_when(
        PONDIH == 0 ~ NA_character_,
        TRUE ~ situacion
      )
    ) %>%
    dplyr::select(-tidyselect::any_of(c("adequi", "periodo", "CBA", "CBT")))

  if (print_summary) {
    if (window == "quarter") {
      Pobreza_resumen <- base %>%
        dplyr::group_by(ANO4, TRIMESTRE, dplyr::across(c({{ group_vars }}))) %>%
        dplyr::summarise(
          Tasa_pobreza = sum(PONDIH[situacion %in% c("pobre", "indigente")], na.rm = TRUE) /
            sum(PONDIH, na.rm = TRUE),
          Tasa_indigencia = sum(PONDIH[situacion == "indigente"], na.rm = TRUE) /
            sum(PONDIH, na.rm = TRUE)
        )
    } else {
      Pobreza_resumen <- base %>%
        dplyr::mutate(SEMESTRE = ifelse(TRIMESTRE %in% c(1, 2), yes = 1, no = 2)) %>%
        dplyr::group_by(ANO4, SEMESTRE, dplyr::across(c({{ group_vars }}))) %>%
        dplyr::summarise(
          Tasa_pobreza = sum(PONDIH[situacion %in% c("pobre", "indigente")], na.rm = TRUE) /
            sum(PONDIH, na.rm = TRUE),
          Tasa_indigencia = sum(PONDIH[situacion == "indigente"], na.rm = TRUE) /
            sum(PONDIH, na.rm = TRUE)
        )
    }


    print(Pobreza_resumen)
  }
  return(base)
}
