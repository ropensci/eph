library(tidyverse)
library(readxl)


rama_caes <- function(variable = rama){
  rama.caes <- case_when(
    ## A --> Agricultura, caza, silvicultura y pesca.
    (variable %in% c("01", "0101", "0102", "0103", "0104", "0105",
                     "02", "0200", "03", "0300")) ~ 'A',
    ## B --> Explotación de minas y canteras.
    (variable %in% c("05", "0500", "500", "06", "0600", "07", "0700", "08",
                     "0800", "09", "0900")) ~ 'B',
    ## C --> Industria Manufacturera.
    (variable %in% c("10", "1001", "1002", "1003", "1009", "11", "1100", "12",
                     "1200", "13", "1300", "14", "1400", "15", "1501", "1502",
                     "16", "1600", "17", "1700", "18", "1800", "19", "1901",
                     "1902", "20", "2001", "2002", "2009", "21", "2100", "22",
                     "2201", "2202", "23", "2301", "2309", "24", "2400", "25",
                     "2500", "26", "2601", "2602", "2603", "2604", "27", "2701",
                     "2709", "28", "2800", "29", "2900", "30", "3001", "3002",
                     "3003", "3009", "31", "3100", "32", "3200", "33", "3300")) ~ 'C',
    ## D --> Suministro de electricidad, gas, vapor y aire acondicionado.
    (variable %in% c("35", "3501", "3502")) ~ 'D',
    ## E --> Suministro de agua; alcantarillado, gestión de desechos y actividades de saneamiento.
    (variable %in% c("36", "3600", "37", "3700", "38", "3800", "39", "3900")) ~ 'E',
    ## F --> Construcción.
    (variable %in% c("40", "4000")) ~ 'F',
    ## G --> Comercio al por mayor y al por menor; reparaciòn de vehículos automotores y motocicletas.
    (variable %in% c("45", "4501", "4502", "4503", "4504", "48", "4801", "4802",
                     "4803", "4804", "4805", "4806", "4807", "4808",
                     "4809", "4810", "4811")) ~ 'G',
    ## H --> Transporte y almacenamiento.
    (variable %in% c("49", "4901", "4902", "4903", "4904", "4905", "4909", "50",
                     "5000", "51", "5100", "52", "5201", "5202", "53", "5300")) ~ 'H',
    ## I --> Alojamiento y servicios de comidas.
    (variable %in% c("55", "5500", "56", "5601", "5602")) ~ 'I',
    ## J --> Información y comunicación.
    (variable %in% c("58", "5800", "59", "5900", "60", "6000", "61", "6100",
                     "62", "6200", "63", "6300")) ~ 'J',
    ## K --> Actividades financieras y de seguros.
    (variable %in% c("64", "6400", "65", "6500", "66", "6600")) ~ 'K',
    ## L --> Actividades inmobiliarias.
    (variable %in% c("68", "6800")) ~ 'L',
    ## M --> Actividades profesionales, científicas y ténicas.
    (variable %in% c("69", "6900", "70", "7000", "71", "7100", "72", "7200", "73",
                     "7301", "7302", "74", "7400", "75", "7500")) ~ 'M',
    ## N --> Actividades administrativas y servicios de apoyo.
    (variable %in% c("77", "7701", "7702", "78", "7800", "79", "7900", "80", "8000",
                     "81", "8101", "8102", "82", "8200")) ~ 'N',
    ## O --> Administración pública y defensa; planes de seguro social obligatorio.
    (variable %in% c("83", "8300","84", "8401", "8402", "8403")) ~ 'O',
    ## P --> Enseñanza.
    (variable %in% c("85", "8501", "8509")) ~ 'P',
    ## Q --> Salud humana y servicios sociales.
    (variable %in% c("86", "8600", "87", "8700", "88", "8800")) ~ 'Q',
    ## R --> Artes, entretenimiento y recreación.
    (variable %in% c("90", "9000", "91", "9100", "92", "9200", "93", "9301", "9302")) ~ 'R',
    ## S --> Otras actividades de servicios.
    (variable %in% c("94", "9401", "9402", "9409", "95", "9501", "9502", "9503",
                     "96", "9601", "9602", "9603", "9606", "9609")) ~ 'S',
    ## T --> Actividades de los hogares como empleadores de personal doméstico; actividades de los hogares como productores de bienes o servicios para uso propio.
    (variable %in% c("97", "9700", "98", "9800")) ~ 'T',
    ## U --> Actividades de organizaciones y organismos extraterritoriales.
    (variable %in% c("99", "9900")) ~ 'U',
    ## V-Z --> Descripción de Actividad Vacía / Actividad no Especificada claramente.
    variable == "9999" ~ 'Z')
}

rama_caes_eph <- function(variable = rama.caes){
  rama.eph <- case_when(
    variable == 'A' | variable == 'B' ~ 1,   # Actividades primarias
    variable == 'C' ~ 2,                     # Industria manufacturera
    variable == 'F' ~ 3,                     # Construcción
    variable == 'G' ~ 4,                     # Comercio
    variable == 'I' ~ 5,                     # Hoteles y restaurantes
    variable == 'H' | variable == 'J' ~ 6,   # Transporte, almacenamiento y comunicaciones
    variable %in% c('K', 'L', 'M', 'N') ~ 7, # Servicios financieros, de alquiler y empresariales
    variable == 'O' ~ 8,                     # Administración pública, defensa y seguridad social
    variable == 'P' ~ 9,                     # Enseñanza
    variable == 'Q' ~ 10,                    # Servicios sociales y de salud
    variable == 'T' ~ 11,                    # Servicio doméstico
    variable == 'R' | variable == 'S' ~ 12,  # Otros servicios comunitarios, sociales y personales
    variable == 'E' | variable == 'U' ~ 13,  # Otras ramas
    variable == 'Z' | variable == 'D' ~ 14)  # Actividades no bien especificadas
}

rama_caes_eph_label <- function(variable = rama.eph){
  rama.nombre <- case_when(
    variable == 1  ~ "Actividades primarias",
    variable == 2  ~ "Industria manufacturera",
    variable == 3  ~ "Construccion",
    variable == 4  ~ "Comercio",
    variable == 5  ~ "Hoteles y restaurantes",
    variable == 6  ~ "Transporte, almacenamiento y comunicaciones",
    variable == 7  ~ "Servicios financieros, de alquiler y empresariales",
    variable == 8  ~ "Administracion publica, defensa y seguridad social",
    variable == 9  ~ "Ensenanza",
    variable == 10 ~ "Servicios sociales y de salud",
    variable == 11 ~ "Servicio domestico",
    variable == 12 ~ "Otros servicios comunitarios, sociales y personales",
    variable == 13 ~ "Otras ramas",
    variable == 14 ~ "Actividades no bien especificadas")

  rama.nombre <- factor(rama.nombre,
                        levels = c("Actividades primarias",
                                   "Industria manufacturera",
                                   "Construccion",
                                   "Comercio",
                                   "Hoteles y restaurantes",
                                   "Transporte, almacenamiento y comunicaciones",
                                   "Servicios financieros, de alquiler y empresariales",
                                   "Administracion publica, defensa y seguridad social",
                                   "Ensenanza",
                                   "Servicios sociales y de salud",
                                   "Servicio domestico",
                                   "Otros servicios comunitarios, sociales y personales",
                                   "Otras ramas",
                                   "Actividades no bien especificadas"))

}

# https://www.indec.gob.ar/ftp/cuadros/menusuperior/clasificadores/caes_v2018.xls
caes <- read_excel('../data/eph/CAES/caes_v2018.xls')
caesv0 <- read_excel('../data/eph/CAES/CAESv0.xlsx')


caes <- caes %>%
  distinct(cod,.keep_all = TRUE) %>%
    add_row(cod='9999',label='Descripción de Actividad Vacía / Actividad no Especificada claramente.') %>%
  filter(str_detect(cod,'\\d{2,}')) %>%
  mutate(caes_seccion_cod = rama_caes(variable = cod)) %>%
  left_join(caes %>% rename(caes_seccion_cod = cod, caes_seccion_label = label),
            by = 'caes_seccion_cod') %>%
  mutate(caes_division_cod = substr(cod,1,2)) %>%
  left_join(caes %>% rename(caes_division_cod = cod, caes_division_label = label),
            by = 'caes_division_cod') %>%
  rename(PP04B_COD = cod,
         PP04B_label = label) %>%
  mutate(caes_eph_cod = rama_caes_eph(caes_seccion_cod),
         caes_eph_label = rama_caes_eph_label(caes_eph_cod),
         caes_eph_cod = as.character(caes_eph_cod))

#####caes_v0####
caesv0 <- caesv0 %>%
  mutate(caes_seccion_cod = NA,
         caes_seccion_label = NA,
         caes_division_cod = NA,
         caes_division_label = NA)

#Asigno Letra y su etiqueta #
for(i in seq_len(nrow(caesv0))){
  if(caesv0$Codigo[i] %in% LETTERS) {
    letra <- caesv0$Codigo[i]
    label <- caesv0$Descripcion[i]
  }
  caesv0$caes_seccion_cod[i] <- letra
  caesv0$caes_seccion_label[i] <- label

}



#Asigno Letra y su etiqueta #
for(i in seq_len(nrow(caesv0))){
  if(nchar(caesv0$Codigo[i]) %in% 1:2) {
    cod <- caesv0$Codigo[i]
    label <- caesv0$Descripcion[i]
  }
  caesv0$caes_division_cod[i] <- cod
  caesv0$caes_division_label[i] <- label

}

caesv0 <- caesv0 %>%
  filter(!(str_sub(Codigo,1,1) %in% LETTERS)) %>%
  rename(PP04B_COD = Codigo,
         PP04B_label = Descripcion) %>%
  mutate(PP04B_COD   =  case_when(nchar(PP04B_COD) == 1 ~ paste0("0", PP04B_COD),
                                  nchar(PP04B_COD) == 2 ~ PP04B_COD,
                                  nchar(PP04B_COD) == 3 ~ paste0("0", PP04B_COD),
                                  nchar(PP04B_COD) == 4 ~ PP04B_COD),
         caes_division_cod = case_when(
           nchar(caes_division_cod) == 1 ~ paste0("0", caes_division_cod),
           nchar(caes_division_cod) == 2 ~ caes_division_cod))

caes <- caes %>%
  mutate(caes_version = "1.0") %>%
  bind_rows(caesv0 %>% mutate(caes_version = "0"))

usethis::use_data(caes, overwrite = TRUE)

data_frame_roxygen(caes)

