#' Check if file is in github repo
#'
#' @param year el parametro de get_microdata_internal
#' @param period el parametro de get_microdata_internal
#' @param type el parametro de get_microdata_internal
#'
#'
#' @noRd
is_in_github <- function(year = 2018,
                         period = 1,
                         type = "individual") {
  if (year < 2023) {
    result <- TRUE
    # esto es porque todas las bases de la EPH hasta 2022 estan en github
  } else {

    # old version #
    # pg <- xml2::read_html(sprintf('https://github.com/holatam/data/tree/master/eph/%s',type))

    # filelist <- rvest::html_nodes(pg, "a") %>%
    #   rvest::html_attr(name = "href" ) %>%
    #   stringr::str_match('.*RDS') %>%
    #   stats::na.omit()
    # looking_for <-sprintf('/holatam/data/blob/master/eph/%s/base_%s_%sT%s.RDS',type,type,year,period)
    # result <- looking_for %in% filelist[,1]

    result <- tryCatch(
      {
        req <- httr::GET("https://api.github.com/repos/holatam/data/git/trees/master?recursive=1")

        filelist <- unlist(lapply(httr::content(req)$tree, "[", "path"), use.names = FALSE)

        looking_for <- sprintf("eph/%s/base_%s_%sT%s.RDS", type, type, year, period)

        result <- looking_for %in% filelist
      },
      error = function(err) {
        FALSE
      }
    )
  }

  result
}
