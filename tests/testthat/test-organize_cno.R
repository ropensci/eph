test_that("checkear shape", {
  bases <- suppressWarnings(dplyr::bind_rows(toybase_individual_2016_03, toybase_individual_2016_04))
  bases_cno <- bases %>% organize_cno()
  expect_equal(ncol(bases_cno), 181)
})
