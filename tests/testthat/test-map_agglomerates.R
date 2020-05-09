context("test-map_agglomerates")

### descargo la base para el ejemplo ###

test_that("tabla simple", {
  mapa <- toybase_individual_2016_04 %>%
    dplyr::group_by(AGLOMERADO) %>%
    dplyr::summarise(tasa_actividad = sum(PONDERA[ESTADO==1])/sum(PONDERA)) %>%
    map_agglomerates(agglomerates = AGLOMERADO,indicator = tasa_actividad)
  expect_equal(class(mapa), c("leaflet", "htmlwidget"))
})
