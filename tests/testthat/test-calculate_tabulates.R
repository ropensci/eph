context("test-calculate_tabulates")

### descargo la base para el ejemplo ###

test_that("tabla simple", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03, x = "REGION", y = "CH04", weights = "PONDERA") %>% as.data.frame(.)
  expect_equal(tab[1, 2], 259235)
})

test_that("totales por fila", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03, x = "REGION", y = "CH04", weights = "PONDERA", add.totals = "row") %>% as.data.frame(.)
  expect_equal(tab[nrow(tab), 2], 465265)
})

test_that("totales por columna", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03, x = "REGION", y = "CH04", weights = "PONDERA", add.totals = "col") %>% as.data.frame(.)
  expect_equal(tab$Total[1], 514813)
})


test_that("porcentaje por fila", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03, x = "REGION", y = "CH04", weights = "PONDERA", add.percentage = "row") %>% as.data.frame(.)
  expect_equal(tab[1, 2], 50.4)
})

test_that("porcentaje por columna", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03, x = "REGION", y = "CH04", weights = "PONDERA", add.percentage = "col") %>% as.data.frame(.)
  expect_equal(tab[1, 2], 55.7)
})


test_that("affix", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03, x = "REGION", y = "CH04", weights = "PONDERA", add.percentage = "col", affix_sign = TRUE) %>% as.data.frame(.)
  expect_equal(tab[1, 2], "55.7%")
  expect_equal(class(tab[, 2]), "character")
})

test_that("digits", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03, x = "REGION", y = "CH04", weights = "PONDERA", add.percentage = "col", digits = 8, affix_sign = TRUE) %>% as.data.frame(.)
  expect_equal(tab[1, 2], "55.71770926%")
  expect_equal(class(tab[, 2]), "character")
})


test_that("tabulado univariado", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03, x = "REGION", weights = "PONDERA") %>% as.data.frame(.)
  expect_equal(tab[1, 2], 514813)
})

test_that("tabulado univariado porcentaje fila", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03, x = "REGION", weights = "PONDERA", add.percentage = "row") %>% as.data.frame(.)
  expect_equal(tab[1, 2], 100)
})

test_that("tabulado univariado porcentaje columna", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03, x = "REGION", weights = "PONDERA", add.percentage = "col") %>% as.data.frame(.)
  expect_equal(tab[1, 2], 54.9)
})
