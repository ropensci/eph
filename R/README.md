# Descarga de base usuaria EPH

Las bases usuarias de la EPH-INDEC son gratuiras y de libre acceso. Para descargarlas tenemos que recurir a la [página del INDEC](https://www.indec.gob.ar/)
y bajar, una por una, las bases que querramos.

Para facilitar este procedimiento e integrarlo directamente al procesamiento desde R, creamos una función que permita
descargar de forma automática la base usuaria de la EPH, sea la de individuos o la de hogares. 

A su vez, integramos en la misma función de descarga la opción del etiquetado de los nombres de las variables 
como también el de los valores (categorías) de las mismas
