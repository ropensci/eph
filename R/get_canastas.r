#'Descarga de canasta basica alimentaria y canasta basica total
#'@description
#'Función que descarga la CBA y CBT a partir de 2016
#'@param update: TRUE/FALSE, opcion actualizar las canastas con los ultimos informes publicados (lleva tiempo)
#'@details
#'disclaimer: El script no es un producto oficial de INDEC.
#'
#'@examples
#'
#'canasta <- get_canastas(update=FALSE)
#'
#'@export

get_canastas <- function(update=F){
  get_new_links <- function(mes='01', anio='19'){
    tryCatch({

      base <- 'https://www.indec.gob.ar'
      link_ref <- 'https://www.indec.gob.ar/informesdeprensa_anteriores.asp?id_tema_1=4&id_tema_2=27&id_tema_3=65'

      nodes <- xml2::read_html(link_ref) %>%
        rvest::html_nodes(".a-tematico")
      data.frame(link= rvest::html_attr(nodes, "href")) %>%
        dplyr::slice(0:which(stringr::str_detect(link,glue::glue('canasta_{mes}_{anio}')))) %>%
        dplyr::mutate(link = xml2::url_absolute(link,base))

    },error = function(err) {err})
  }
  get_last_data <- function(link){
    tryCatch({
      anio_publicacion <- paste0('20',stringr::str_extract(link,'(?<=canasta_...)..'))
      out <- tabulizer::extract_tables(link)

      out <- purrr::map(out, as.data.frame)
      df <- out[[which(purrr::map(out, ncol)==5)]]

      df <- df %>%
        dplyr::slice(n()) %>%
        dplyr::select(-2)
      names(df) <- c('mes', 'cba', 'ice', 'cbt')
      df <- df %>%
        dplyr:: mutate(cba = as.numeric(gsub(",", ".", gsub("\\.", "", cba))),
                       ice = as.numeric(gsub(",", ".", gsub("\\.", "", ice))),
                       cbt = as.numeric(gsub(",", ".", gsub("\\.", "", cbt))),
                       mes= dplyr::case_when(mes == "Enero" ~ 1,
                                             mes == "Febrero" ~ 2,
                                             mes == "Marzo" ~ 3,
                                             mes == "Abril" ~ 4,
                                             mes == "Mayo" ~ 5,
                                             mes == "Junio" ~ 6,
                                             mes == "Julio" ~ 7,
                                             mes == "Agosto" ~ 8,
                                             mes == "Septiembre" ~ 9,
                                             mes == "Octubre" ~ 10,
                                             mes == "Noviembre" ~ 11,
                                             mes == "Diciembre" ~ 12),
                       anio= dplyr::case_when(mes%in%1:11 ~as.numeric(paste(anio_publicacion)),
                                              mes==12 ~as.numeric(paste(anio_publicacion))-1)) %>%
        dplyr::select(anio, mes, cba,ice,cbt) %>%
        dplyr::arrange(anio, mes)
      df

    },error = function(err) {glue::glue("error_in_link: {link}")})
  }
  update_canasta <- function(series_historica, save= T){

    links <- get_new_links()
    new_data <- purrr::map(links$link,get_last_data)
    new_data <- dplyr::bind_rows(new_data)
    all_data <- dplyr::bind_rows(series_historica,new_data)

    if (save) {
      all_data %>% save('data/canastas.rda')
    }
    all_data
  }
  if (update) {
    canastas <- update_canasta(canastas,save = F)
  }
  canastas
}
