#' Mapa de indicadores por aglomerado
#'
#' @param .data Dataframe con los datos
#' @param agglomerates Variable con los codigos de aglomerados
#' @param indicator   Variable con los indicadores
#' @param alpha Opacidad de los puntos
#' @param palette Paleta de colores a utilizar, incluye "viridis", "magma", "inferno", or "plasma". Para mas opciones, ver \link[leaflet]{colorNumeric}
#'
#' @return Devuelve un mapa de indicadores por aglomerado
#'
#' @examples
#'
#' toybase_individual_2016_04 %>%
#'   dplyr::group_by(AGLOMERADO) %>%
#'   dplyr::summarise(tasa_actividad = sum(PONDERA[ESTADO == 1]) / sum(PONDERA)) %>%
#'   map_agglomerates(
#'     agglomerates = AGLOMERADO,
#'     indicator = tasa_actividad
#'   )
#' @export

map_agglomerates <- function(.data, agglomerates, indicator, alpha = .75, palette = "viridis") {
  agglomerates <- rlang::enquo(agglomerates)
  indicator <- rlang::enquo(indicator)

  df <- .data %>%
    dplyr::select("AGLOMERADO" = !!agglomerates, "indicator" = !!indicator) %>%
    dplyr::left_join(centroides_aglomerados, by = "AGLOMERADO")

  pal <- leaflet::colorNumeric(
    palette = palette,
    domain = df$indicator
  )


  labs <- purrr::pmap(list(df$nombre_aglomerado, round(df$indicator, digits = 2)), function(.x, .y) paste0("<p>", .x, "<p></p>", dplyr::as_label(indicator), ": ", .y, "</p>"))

  leaflet::leaflet(df) %>%
    leaflet::addTiles() %>%
    #leaflet::addProviderTiles(leaflet::providers$Wikimedia) %>%
    leaflet::addCircleMarkers(
      fillColor = ~ pal(indicator),
      fillOpacity = alpha,
      stroke = FALSE,
      label = lapply(labs, htmltools::HTML)
    ) %>%
    leaflet::addLegend("bottomright",
      pal = pal, values = ~indicator,
      title = sprintf("%s", dplyr::as_label(indicator)),
      opacity = 1
    )
}
