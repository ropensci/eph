#'Descarga de canasta basica alimentaria y canasta basica total
#'@description
#'Funcion que descarga la CBA y CBT a partir de abril 2016
#'@details
#'Disclaimer: El script no es un producto oficial de INDEC.
#'
#'La funcion descarga la serie provista por indec en
#'https://www.indec.gob.ar/indec/web/Nivel4-Tema-4-43-149
#'
#'@examples
#'
#'canasta <- get_poverty_lines()
#'
#'@export

get_poverty_lines <- function(){

  temp = tempfile(fileext = ".xls")
  dataURL <- "https://www.indec.gob.ar/ftp/cuadros/sociedad/serie_cba_cbt.xls"
  utils::download.file(dataURL, destfile=temp, mode='wb')

  suppressWarnings({canasta <- readxl::read_excel(temp, sheet =1, skip = 6,col_names = c('periodo', 'CBA', 'ICE', 'CBT'),
                     col_types = c('date','numeric','numeric','numeric')) %>% stats::na.omit()})
  unlink(temp)
  canasta
  }
