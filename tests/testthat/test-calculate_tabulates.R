context("test-calculate_tabulates")

### descargo la base para el ejemplo ###

test_that("tabla simple", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03,x = 'REGION', y = 'CH04',weights = 'PONDERA')
  expect_equal(tab[1,2], 259235)
})

test_that("totales por fila", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03,x = 'REGION', y = 'CH04',weights = 'PONDERA', add.totals = 'row')
  expect_equal(tab[nrow(tab),2], 465265)
})

test_that("totales por columna", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03,x = 'REGION', y = 'CH04', weights = 'PONDERA', add.totals = 'col')
  expect_equal(tab$Total[1], 514813)
})


test_that("porcentaje por fila", {
  tab <- calculate_tabulates(base = toybase_individual_2016_03,x = 'REGION', y = 'CH04', weights = 'PONDERA', add.percentage ='row')
  expect_equal(tab[1,2], '50.4%')
})
