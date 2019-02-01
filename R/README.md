# Scripts para R

## Descarga de base usuaria EPH-INDEC
Las bases usuarias de la EPH-INDEC son gratuiras y de libre acceso. Para disponer de las mismas hay que recurir a la [página del INDEC](https://www.indec.gob.ar/) y bajar, una por una, las bases que querramos.

Con el objetivo de facilitar este procedimiento e integrarlo directamente al procesamiento desde R, creamos una función que permita
descargar de forma automática la base usuaria, sea la de individuos o la de hogares.

A su vez, integramos en la misma función de descarga la opción del etiquetado de los nombres de las variables como también el de sus  categorías.

### Modo de uso
Se puede copiar el script de la función desde el [repositorio](https://github.com/pablinte/eph/raw/master/R/base_descarga.r) o, mejor aún, podés simplemente pegar el siguiente código en R --> `source("https://github.com/pablinte/eph/raw/master/R/base_descarga.r")`. Al correrlo automaticamente cargamos la función.

Por último, para descargar la base tenemos que definir en la función los siguientes parámetros:
`anio = `,
`trimestre =`,
`individual = TRUE/FALSE`,
`hogar = TRUE/FALSE`,
`etiqueta = TRUE/FALSE`.

