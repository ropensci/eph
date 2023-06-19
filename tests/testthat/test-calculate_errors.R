test_that("checkear shape", {

  tabla <- eph::toybase_individual_2016_03 %>%
    eph::organize_labels() %>%
    dplyr::filter(AGLOMERADO == 32) %>%
    calculate_tabulates(x = "CH03",
                        weights = "PONDERA",
                        add.totals = "row")

  tabla_errors <- tabla %>%
    dplyr::mutate(ds = calculate_errors(Freq, codigo_aglo = "32",
                                        periodo_eph = "2014.03", measure = "ds"))

  expect_equal(ncol(tabla_errors), 3)
  expect_equal(nrow(tabla_errors), nrow(tabla))
})

