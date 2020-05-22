context("test-organize_caes")

test_that("checkear shape", {

  bases <- suppressWarnings(dplyr::bind_rows(toybase_individual_2016_03,toybase_individual_2016_04))
  expect_warning(bases_caes <- bases %>% organize_caes())
  expect_equal(ncol(bases_caes), 185)
})


