context("test-organize_panels")

test_that("consistencia constante", {
  lista_bases <- list(toybase_individual_2016_03, toybase_individual_2016_04)
  pool_trimestral <- suppressWarnings(organize_panels(
    bases = lista_bases,
    variables = c("P21", "ESTADO"),
    window = "trimestral"
  ))

  expect_equal(round(sum(pool_trimestral$consistencia) / nrow(pool_trimestral), 2), 0.97)
})
