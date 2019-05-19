context("test-organize_panels")

test_that("consistencia constante", {

  base_1t_2018 <- get_microdata(year = 2018, trimester = 1,type='individual')
  base_2t_2018 <- get_microdata(year = 2018, trimester = 2,type='individual')
  lista_bases <- list(base_1t_2018,base_2t_2018)
  pool_trimestral <- suppressWarnings(organize_panels(bases = lista_bases,
                                                      variables =c("P21","ESTADO"),
                                                      window = "trimestral"))

  expect_equal(round(sum(pool_trimestral$consistencia)/nrow(pool_trimestral),2), 0.94)
})


