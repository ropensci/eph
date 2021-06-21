#install.packages('tabulizer')
library(tabulizer)
library(tidyverse)
library(stringr)

path <- "https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_errores_muestreo_3t2014.pdf"

#areas <- extract_areas(path)

raw_tables <- extract_tables(path)
raw_text <- extract_text(path)


aglomerados <- str_extract_all(raw_text, 'Aglomerado.*(?=\n)')[[1]]

aglomerados <- c('Total 31 aglomerados urbanos',aglomerados)

raw_tables <- raw_tables[1:33]

errores_muestrales <- tibble(aglomerados) %>%
  mutate(table = raw_tables[row_number()])

clean_table <- function(df){
  df <- as_tibble(df[[1]],.name_repair = 'minimal')
  names(df) <- c('tmp','cv')
  df <- df %>%
    slice(-(1:3)) %>%
    separate(col = 'tmp',into = c('x', 'ds'),sep = ' ') %>%
    mutate(x = str_remove_all(x, '\\.') %>% as.numeric(),
           ds = str_remove_all(ds, '\\.')%>% as.numeric(),
           cv = str_replace_all(cv, ',','\\.')%>% as.numeric()
    )
}

errores_muestrales_clean <- list()
for (i in 1:nrow(errores_muestrales)) {

  print(errores_muestrales$aglomerados[i])
  tmp_table <- errores_muestrales$table[i]
  errores_muestrales_clean <- c(errores_muestrales_clean,list(clean_table(tmp_table)))
}

errores_muestrales <- errores_muestrales %>%
  mutate(tables_clean = errores_muestrales_clean[row_number()]) %>%
  select(-table) %>%
  unnest(cols = tables_clean)

errores_muestrales$aglomerados <- errores_muestrales$aglomerados %>%
  str_remove_all("Aglomerad(o|os)\\b") %>%
  str_trim(., "both")

errores_muestrales <-
  left_join(errores_muestrales, eph::diccionario_aglomerados,
            by = c("aglomerados" = "aglo"))

reparacion_aglo <- errores_muestrales %>%
  filter(is.na(errores_muestrales$codigo)) %>%
  select("aglomerados") %>%
  unique()

reparacion_aglo$codigo <- c("Total", 32, 33, 26, 29, 19, 18, 3, 5,
                       34, 30, 38, 9, 17, 31, 91, 93)

for (i in seq_along(reparacion_aglo$aglomerados)) {
  errores_muestrales <- errores_muestrales %>%
    mutate(codigo = case_when(
      aglomerados == reparacion_aglo$aglomerados[i] ~ reparacion_aglo$codigo[i],
      TRUE ~ as.character(codigo)
    ))
}

errores_muestrales <- errores_muestrales %>%
  select(codigo, x, ds, cv) %>%
  rename("aglomerado" = "codigo")

usethis::use_data(errores_muestrales, overwrite = TRUE)

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


data_frame_roxygen(errores_muestrales) %>% stringr::str_split("\n")
