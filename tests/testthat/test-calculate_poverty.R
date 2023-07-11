context("test-calculate_poverty")


test_that("Test pobreza e indigencia trimestre", {
  base_pobreza <- calculate_poverty(base = eph::toybase_individual_2016_03,
                                    basket = canastas_reg_example,
                                    print_summary = FALSE)

  expect_equal(ncol(base_pobreza), 182)

  Pobreza_resumen <- base_pobreza %>%
    dplyr::group_by(ANO4, TRIMESTRE) %>%
    dplyr::summarise(
      Tasa_pobreza = sum(PONDIH[situacion %in% c("pobre", "indigente")], na.rm = TRUE) /
        sum(PONDIH, na.rm = TRUE),
      Tasa_indigencia = sum(PONDIH[situacion == "indigente"], na.rm = TRUE) /
        sum(PONDIH, na.rm = TRUE)
    )

  expect_equal(round(Pobreza_resumen$Tasa_pobreza[1], 2), 0.03)
  expect_equal(round(Pobreza_resumen$Tasa_indigencia[1], 2), 0.01)
})

test_that("Test pobreza e indigencia semestre", {
  bases <- dplyr::bind_rows(
    toybase_individual_2016_03,
    toybase_individual_2016_04
  )

  base_pobreza <- calculate_poverty(
    base = bases,
    basket = canastas_reg_example,
    print_summary = TRUE,
    group_vars = c(CH04, NIVEL_ED),
    window = "semestral"
  )

  expect_equal(ncol(base_pobreza), 182)
  expect_equal(nrow(base_pobreza), nrow(bases))

  Pobreza_resumen <- base_pobreza %>%
    dplyr::mutate(SEMESTRE = ifelse(TRIMESTRE %in% c(1, 2), yes = 1, no = 2)) %>%
    dplyr::group_by(ANO4, SEMESTRE, CH04, NIVEL_ED) %>%
    dplyr::summarise(
      Tasa_pobreza = sum(PONDIH[situacion %in% c("pobre", "indigente")], na.rm = TRUE) /
        sum(PONDIH, na.rm = TRUE),
      Tasa_indigencia = sum(PONDIH[situacion == "indigente"], na.rm = TRUE) /
        sum(PONDIH, na.rm = TRUE)
    )

  expect_equal(round(Pobreza_resumen$Tasa_pobreza[1], 2), 0.07)
  expect_equal(round(Pobreza_resumen$Tasa_indigencia[1], 4), 0.0043)
})
