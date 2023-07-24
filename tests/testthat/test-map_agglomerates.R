context("test-map_agglomerates")

test_that("mapeo tabla simple", {
  mapa <- toybase_individual_2016_04 %>%
    dplyr::group_by(AGLOMERADO) %>%
    dplyr::summarise(tasa_actividad = sum(PONDERA[ESTADO == 1]) / sum(PONDERA)) %>%
    map_agglomerates(agglomerates = AGLOMERADO, indicator = tasa_actividad)

  expect_equal(class(mapa), c("leaflet", "htmlwidget"))
  expect_equal(dim(attributes(mapa$x)$leafletData), c(32,5))
  expect_equal(mapa$sizingPolicy$defaultWidth, "100%")
  expect_equal(mapa$sizingPolicy$defaultHeight, 400)
  expect_equal(mapa$sizingPolicy$viewer$fill, TRUE)
  expect_equal(mapa$sizingPolicy$knitr$figure, TRUE)
})




