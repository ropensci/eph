context("test-calculate_tabulates")

### descargo la base para el ejemplo ###

base_2016t3 <-  get_microdata(year = 2016, trimester = 3,type='individual')

test_that("tabla simple", {
  tab <- calculate_tabulates(base = base_2016t3,x = 'REGION', y = 'CH04',weights = 'PONDERA')
  expect_equal(tab[1,2], 7024139)
})

test_that("totales por fila", {
  tab <- calculate_tabulates(base = base_2016t3,x = 'REGION', y = 'CH04',weights = 'PONDERA', add.totals = 'row')
  expect_equal(tab[nrow(tab),2], 13020918)
})

test_that("totales por columna", {
  tab <- calculate_tabulates(base = base_2016t3,x = 'REGION', y = 'CH04', weights = 'PONDERA', add.totals = 'col')
  expect_equal(tab$Total[1], 14737991)
})


test_that("porcentaje por fila", {
  tab <- calculate_tabulates(base = base_2016t3,x = 'REGION', y = 'CH04', weights = 'PONDERA', add.percentage ='row')
  expect_equal(tab[1,2], '47.7%')
})

