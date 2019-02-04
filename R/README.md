# Scripts para R

## Descarga de base usuaria EPH-INDEC
Las bases usuarias de la EPH-INDEC son gratuiras y de libre acceso. Para disponer de las mismas hay que recurir a la [página del INDEC](https://www.indec.gob.ar/bases-de-datos.asp) y bajar, una por una, las bases que querramos.

Con el objetivo de facilitar este procedimiento e integrarlo directamente al procesamiento desde R, con [Natsu](https://rpubs.com/natsumi_shokida) creamos una función que permita descargar de forma automática la base usuaria, sea la de individuos o la de hogares.

A su vez, integramos en la misma función de descarga la opción para etiquetar los nombres de las variables y también el de sus  categorías.

### Modo de uso.
Se puede copiar el script de la función desde este [repositorio](https://github.com/pablinte/eph/raw/master/R/base_descarga.r) o simplemente pegar el siguiente código en R --> `source("https://github.com/pablinte/eph/raw/master/R/base_descarga.r")`. 

Al correrlo automaticamente queda cargada la función en tu ambiente de R. Para descargar la base hay que definir en la función los siguientes parámetros:
`anio = `,
`trimestre =`,
`individual = TRUE/FALSE`,
`hogar = TRUE/FALSE`,
`etiqueta = TRUE/FALSE`.

### Ejemplos.
Si quiero descargar la base de individuos de la EPH, para el año 2018, trimestre 1, el código quedaría así:
`descarga_base_eph(individual = TRUE, etiqueta = TRUE, anio = 2018, trimestre = 1)`

Si quiero descargar la base de hogares para el año 2017, trimestre 3, sin etiquetas, el código quedaría así:
`descarga_base_eph(hogar = TRUE, etiqueta = FALSE, anio = 2017, trimestre = 3)`

