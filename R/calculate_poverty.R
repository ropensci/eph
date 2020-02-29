#'Calculo de Pobreza e Indigencia
#'@description
#'Función para calcular la pobreza e indigencia siguiendo la metodología de línea.
#'@param base Base individual de uno o más períodos
#'@param basket basket basica alimentaria y total, con la siguiente estructura:
#'# A tibble: N x 5
#'   region    periodo   CBA   CBT codigo
#'   <chr>     <chr>   <dbl> <dbl>  <dbl>
#' 1 Cuyo      2016.3  1509. 3872.     42
#' 2 Cuyo      2016.4  1570. 4030.     42
#' 3 GBA       2016.3  1684. 4053.      1
#' . ...      .....   .....   ....    ...
#'@param print_summary TRUE/FALSE, opcion para imprimir las tasas de pobreza e indigencia
#'@details #'disclaimer: El script no es un producto oficial de INDEC.
#'
#'@examples
#'
#'#'
#'bases <- dplyr::bind_rows(toybase_individual_2016_03,toybase_individual_2016_04)
#'base_pobreza <- calculate_poverty(base = bases, basket = canastas_reg_example,print_summary=TRUE)
#'

#'@export

calculate_poverty <- function(base,basket,print_summary=TRUE ){

    base <- base %>%
      dplyr::mutate(periodo = paste(ANO4, TRIMESTRE, sep='.')) %>%
      dplyr::left_join(., adulto_equivalente, by = c("CH04", "CH06")) %>%
      dplyr::left_join(., basket, by = c('REGION'="codigo", "periodo")) %>%
      dplyr::group_by(CODUSU, NRO_HOGAR, periodo)                          %>%
      dplyr::mutate(adequi_hogar = sum(adequi))                            %>%
      dplyr::ungroup() %>%
      dplyr::mutate(CBA_hogar = CBA*adequi_hogar,
             CBT_hogar = CBT*adequi_hogar,
             situacion = dplyr::case_when(ITF<CBA_hogar            ~ 'indigente',
                                   ITF>=CBA_hogar & ITF<CBT_hogar ~ 'pobre',
                                   ITF>=CBT_hogar           ~ 'no_pobre'),
             situacion = dplyr::case_when(PONDIH==0 ~ "NA", #excluyo los casos que no tienen respuesta en ITF
                                          TRUE ~ situacion)) %>%
      dplyr::select(-adequi,-periodo,-CBA, -CBT)

    if (print_summary) {
      Pobreza_resumen <- base %>%
        dplyr::group_by(ANO4,TRIMESTRE) %>%
        dplyr::summarise(Tasa_pobreza    = sum(PONDIH[situacion %in% c('pobre', 'indigente')],na.rm = TRUE)/
                    sum(PONDIH,na.rm = TRUE),
                  Tasa_indigencia = sum(PONDIH[situacion == 'indigente'],na.rm = TRUE)/
                    sum(PONDIH,na.rm = TRUE))

      print(Pobreza_resumen)

    }
    return(base)
}


