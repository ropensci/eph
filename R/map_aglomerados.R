#' Mapa de indicadores por aglomerado
#'
#' @param .data Dataframe con los datos
#' @param aglomerados Variable con los códigos de aglomerados
#' @param indicador   Variable con los indicadores
#' @param alpha Opacidad de los puntos
#' @param palette paleta de colores a utilizar, incluye "viridis", "magma", "inferno", or "plasma". Para más opciones, ver \link[leaflet]{colorNumeric}
#'
#' @examples
#'
#'toybase_individual_2016_04 %>%
#' dplyr::group_by(AGLOMERADO) %>%
#' dplyr::summarise(tasa_actividad = sum(PONDERA[ESTADO==1])/sum(PONDERA)) %>%
#' map_aglomerados(aglomerados = AGLOMERADO,indicador = tasa_actividad)
#' @export

map_aglomerados <- function(.data,aglomerados, indicador, alpha=.75, palette= 'viridis') {

  aglomerados <- rlang::enquo(aglomerados)
  indicador <- rlang::enquo(indicador)

  df <-   .data %>%
    dplyr::select('AGLOMERADO'=!!aglomerados,'indicador'=!!indicador) %>%
    dplyr::left_join(centroides_aglomerados, by = "AGLOMERADO")

  pal <- leaflet::colorNumeric(
    palette = "viridis",
    domain = df$indicador)


  labs <- purrr::pmap(list(df$nombre_aglomerado, round(df$indicador,digits = 2)), function(.x,.y) paste0( '<p>', .x, '<p></p>', dplyr::as_label(indicador),': ',.y,'</p>' )  )

  leaflet::leaflet(df %>% sf::st_as_sf()) %>%
    leaflet::addTiles() %>%
    leaflet::addProviderTiles(leaflet::providers$Wikimedia) %>%
    leaflet::addCircleMarkers(fillColor = ~pal(indicador),
                              fillOpacity = alpha,
                              stroke=F,
                              label = lapply(labs, htmltools::HTML)) %>%
    leaflet::addLegend("bottomright", pal = pal, values = ~indicador,
                       title = glue::glue("{dplyr::as_label(indicador)}"),
                       opacity = 1
    )
}
