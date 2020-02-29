library(sf)
library(tidyverse)

aglos <- sf::st_read('../data/eph/georef/aglomerados_eph.json')
# entidades <- sf::st_read('../data/eph/georef/entidades_eph.json')
# radios <- sf::st_read('../data/eph/georef/radios_eph.json')


centroides_aglomerados <-  aglos %>%
  filter(!st_is_empty(geometry)) %>%
  group_by(eph_codagl) %>%
  summarise(AGLOMERADO = unique(eph_codagl),
            nombre_aglomerado = unique(eph_aglome)[1]) %>%
  st_centroid() %>%
  select(AGLOMERADO, nombre_aglomerado, geometry)

ggplot() +
  geom_sf(data = centroides_aglomerados )


usethis::use_data(centroides_aglomerados, overwrite = TRUE)


data_frame_roxygen <- function(obj) {
  if (inherits(obj, c("data.frame", "tibble"))) {
    cl <- sapply(obj, typeof)

    items <- paste0(sprintf("#'   \\item{\\code{%s}}{%s ---DESCRIPTION---}", names(cl), cl))


    items <- paste0(items, collapse = "\n")


    header <- c(
      title = paste0("#' @title ", deparse(substitute(obj))),
      description = "#' @description ---COLUMN DESCRIPTION---",
      format = sprintf("#' @format A data frame with %s rows and %s variables:", nrow(obj), length(cl))
    )

    ret <- sprintf(
      "%s\n%s\n%s",
      paste(header, collapse = "\n"),
      sprintf("#' \\describe{\n%s \n#'}", items),
      sprintf('\n"%s"', deparse(substitute(obj)))
    )
  }
  ret
}


data_frame_roxygen(centroides_aglomerados)
