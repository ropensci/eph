#' Check if file is in github repo
#'
#' @param year el parametro de get_microdata_internal
#' @param trimester el parametro de get_microdata_internal
#' @param type el parametro de get_microdata_internal
#'
#'
#'
is_in_github <- function(year = 2018,
                         trimester = NA,
                         type='individual'){

  if (is.na(trimester)) {
    result <- TRUE # esto es porque todas las bases de la EPH puntual estan en github
  }else{

    pg <- xml2::read_html(glue::glue('https://github.com/holatam/data/tree/master/eph/{type}'))
    # req <- httr::GET("https://api.github.com/repos/holatam/data/git/trees/master?recursive=1")

    filelist <- rvest::html_nodes(pg, "a") %>%
      rvest::html_attr(name = "href" ) %>%
      stringr::str_match('.*RDS') %>%
      stats::na.omit()

    #filelist <- unlist(lapply(httr::content(req)$tree, "[", "path"), use.names = F)
    looking_for <-glue::glue('/holatam/data/blob/master/eph/{type}/base_{type}_{year}T{trimester}.RDS')

    result <- looking_for %in% filelist[,1]
  }

  result
}
