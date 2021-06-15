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

tablas <- tibble(aglomerados) %>%
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

tablas_clean <- list()
for (i in 1:nrow(tablas)) {

  print(tablas$aglomerados[i])
  tmp_table <- tablas$table[i]
  tablas_clean <- c(tablas_clean,list(clean_table(tmp_table)))
}

tablas <- tablas %>%
  mutate(tables_clean = tablas_clean[row_number()]) %>%
  select(-table) %>%
  unnest(cols = tables_clean)
