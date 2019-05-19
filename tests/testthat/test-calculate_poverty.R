context("test-calculate_poverty")


df <- get_microdata(year = 2016, trimester = 3)
base_pobreza <- calculate_poverty(base = df,basket = canastas_reg_example,print_summary = FALSE)


Pobreza_resumen <- base_pobreza %>%
  dplyr::group_by(ANO4,TRIMESTRE) %>%
  dplyr::summarise(Tasa_pobreza    = sum(PONDIH[situacion %in% c('pobre', 'indigente')],na.rm = TRUE)/
                     sum(PONDIH,na.rm = TRUE),
                   Tasa_indigencia = sum(PONDIH[situacion == 'indigente'],na.rm = TRUE)/
                     sum(PONDIH,na.rm = TRUE))

test_that("Test pobreza", {
  expect_equal(round(Pobreza_resumen$Tasa_pobreza, 2), 0.31)
})


test_that("Test indigencia", {
  expect_equal(round(Pobreza_resumen$Tasa_indigencia, 2), 0.07)
})
