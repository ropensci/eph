# rindec

<!-- badges: start -->
[![Travis-CI Build
Status](https://api.travis-ci.org/rindec/eph.svg?branch=master)](https://travis-ci.org/rindec/eph)
[![Coverage
status](https://codecov.io/gh/rindec/eph/branch/master/graph/badge.svg)](https://codecov.io/gh/rindec/eph?branch=master)
[![CRAN status](https://www.r-pkg.org/badges/version/eph)](https://cran.r-project.org/package=eph)
  <!-- badges: end -->



# Caja de Herramientas para el procesamiento de la Encuesta Permanente de Hogares

## Descripción
La librería `eph` tiene por objecto facilitar el trabajo de aquellos usuarios y usuarias de la [Encuesta Permanente de Hogares - INDEC](https://www.indec.gob.ar/bases-de-datos.asp) que deseen procesar datos de la misma mediante [R](https://www.r-project.org/).


Sus principales funciones son:

- **`get_microdata()`**: Descarga las bases de microdatos directamente de la página de INDEC

- **`organize_labels()`**: Etiqueta las bases siguiendo el último [diseño de registro](https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_registro_t218.pdf)

- **`calculate_tabulates()`**: Crea tabulados uni o bivariados con ponderacion, totales parciales y porcentajes.

- **`calculate_poverty()`**: Replica el cálculo de pobreza e indigencia del INDEC, pero para las bases trimestrales^[el calculo oficial se realiza sobre bases semestrales no publicadas]

- **`get_poverty_lines()`**: Descarga de canasta basica alimentaria y canasta basica total

- **`orgnize_panels()`**: Arma un pool de datos para trabajar con panel en la EPH continua


## Instalación

Desde Rstudio 

```

# install.packages('devtools') si no tiene instalado devtools

devtools::install_github("rindec/eph")

```

## Modo de uso.

### Descarga de microdatos -->
```

### Base de individuos
base_2016t3_ind <- get_microdata(year = 2016, trimester = 3, type = 'individual')

### Base de hogares
base_2016t3_hog <- get_microdata(year = 2016, trimester = 3, type = 'hogar')

```

### Tabulados uni / bivariados con ponderacion, totales parciales y porcentajes -->

```
calculate_tabulates(base_2016t3_ind, "ANO4", "TRIMESTRE", add.totals = "row")

 ANO4/TRIMESTRE     3
           2018 56879
          Total 56879

```

### Etiquetas [labels] de microdatos -->
```
base_2016t3 <- organize_labels(base_2016t3_ind, type='individual')

# Ejemplo 1:
calculate_tabulates(base_2016t3_ind, "ANO4", "TRIMESTRE", add.totals = "row")

 ANO4/TRIMESTRE 3er Trimestre
           2018         56879
          Total         56879
          
# Ejemplo 2:
calculate_tabulates(base_2016t3_ind, "CH04", add.totals = "row")

  CH04  Freq
 Varon 27219
 Mujer 29660
 Total 56879
 
```

### Aportes de la comunidad

Este paquete se propone incorporar cualquier función de propósitos generales que utilice como base los datos de la Encuesta Permanente de Hogares. Todos los aportes en este sentido son bienvenidos.

Si trabajas con la EPH y querés agregar tu función, te recomendamos que leas el siguiente [issue](https://github.com/pablinte/eph/issues/5#issue-407890587) con consejos de como colaborar
