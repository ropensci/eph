
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eph <img src='man/figures/logo.png' align="right" height="200" style="float:right; height:200px;" />

<!-- badges: start -->

[![R build
status](https://github.com/holatam/eph/workflows/R-CMD-check/badge.svg)](https://github.com/holatam/eph/actions)
[![Coverage
status](https://codecov.io/gh/holatam/eph/branch/master/graph/badge.svg)](https://app.codecov.io/gh/holatam/eph?branch=master)
[![CRAN
status](https://www.r-pkg.org/badges/version/eph)](https://cran.r-project.org/package=eph)
[![](http://cranlogs.r-pkg.org/badges/grand-total/eph?color=blue)](https://cran.r-project.org/package=eph)
[![](http://cranlogs.r-pkg.org/badges/last-month/eph?color=blue)](https://cran.r-project.org/package=eph)
[![DOI](https://zenodo.org/badge/142294444.svg)](https://zenodo.org/badge/latestdoi/142294444)

<!-- badges: end -->

# Caja de Herramientas para el procesamiento de la Encuesta Permanente de Hogares

## Descripción

Si querés procesar datos de la [Encuesta Permanente de Hogares -
INDEC](https://www.indec.gob.ar/bases-de-datos.asp) mediante el lenguaje
de programación [R](https://www.r-project.org/), la librería `eph` tiene
por objeto facilitar tu trabajo.

El paquete cumple un rol fundamental en la democratización de la
posibilidad de procesar los datos publicados por INDEC y así obtener
conclusiones independientes de aquellas publicadas en los informes
elaborados por el organismo. Dado que la información de la EPH
constituye una de las principales fuentes para el análisis de las
problemáticas sociales presentes en Argentina, el paquete no sólo
posibilita investigaciones académicas y periodísticas, sino que también
contribuye a la formulación de políticas públicas fundamentadas en
evidencia.

Algunas de sus funciones son:

- **`get_microdata()`**: Descarga las bases de microdatos,

- **`organize_panels()`**: Permite armar un pool de datos en panel de la
  EPH continua,

- **`organize_cno()`**: Clasifica las ocupaciones según el CNO 2001

- **`organize_caes()`**: Clasifica las actividades económicas según CAES
  Mercosur 1.0 y CAES Mercosur

- **`organize_labels()`**: Etiqueta las bases siguiendo el último
  [diseño de
  registro](https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_registro_t218.pdf)

- **`map_agglomerates()`**: Mapa de indicadores por aglomerado

El paquete también cuenta con dataframes útiles para el trabajo con la
EPH. Algunos de estos son:

- **`diccionario_regiones`**
- **`diccionario_aglomerados`**
- **`centroides_aglomerados`**
- **`adulto_equivalente`**

## Instalación

Para la versión estable

``` r
install.packages("eph")
```

Para la versión en desarrollo

``` r
# install.packages('devtools')
# si no tiene instalado devtools

devtools::install_github("holatam/eph")
```

## Modo de uso

Ejemplo de descarga de microdatos

``` r
# Cargo la libreria
library(eph)

base_individual <- get_microdata(
  year = 2018:2019, # especifco el año
  trimester = 1, # el trimestre
  type = "individual", # y el tipo de base
  vars = c("PONDERA", "ESTADO", "CAT_OCUP")
) # opcionalmente, puedo especificar las variables que deseo utilizar.

base_individual
#> # A tibble: 117,320 × 3
#>    PONDERA ESTADO CAT_OCUP
#>      <int>  <int>    <int>
#>  1     684      4        0
#>  2    1008      3        0
#>  3    1008      1        1
#>  4    1008      2        0
#>  5     886      1        2
#>  6     594      3        0
#>  7     594      3        0
#>  8     546      3        0
#>  9     509      1        3
#> 10     509      1        3
#> # … with 117,310 more rows
```

## Cómo citar este paquete

Podés citar este paquete como “se obtuvieron y/o normalizaron los datos
de la Encuesta Permanente de Hogares (EPH-INDEC) utilizando el paquete
de R ‘eph’ (Kozlowski et al, 2020)”.

La referencia completa para incluir en la bibliografía es:

    Diego Kozlowski, Pablo Tiscornia, Guido Weksler, German Rosati and Natsumi Shokida (2020). eph: Argentina's Permanent Household Survey Data and Manipulation Utilities. R package version https://doi.org/10.5281/zenodo.3462677

Si necesitás la entrada bib:

``` bib

@Manual{kozlowski2020,
    title = {eph: Argentina's Permanent Household Survey Data and Manipulation Utilities},
    author = {Diego Kozlowski and Pablo Tiscornia and Guido Weksler and German Rosati and Natsumi Shokida},
    year = {2020},
    doi = {10.5281/zenodo.3462677},
    url = {https://holatam.github.io/eph/},
  }
  
```

## Aportes de la comunidad

Este paquete se propone incorporar cualquier función de propósitos
generales que utilice como base los datos de la Encuesta Permanente de
Hogares. Todos los aportes en este sentido son bienvenidos.

Si trabajas con la EPH y querés agregar tu función, te recomendamos que
leas los siguientes
[consejos](https://github.com/holatam/eph/blob/master/docs/CONTRIBUTING.md)
sobre cómo como colaborar
