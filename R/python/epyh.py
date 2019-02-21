import requests, zipfile, io
import pandas as pd
import json

def epyh(anio = 2018, trimestre = 2,individual = False):

    url = 'https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_usu_'+str(trimestre)+'_Trim_'+str(anio)+'_txt.zip'

    #decarga zip
    r = requests.get(url)
    z = zipfile.ZipFile(io.BytesIO(r.content))

    if individual:
        nombre_archivo = 'usu_individual_t'+str(trimestre)+str(anio)[2:]+'.txt'
        etiquetas = json.load(open("eph/diccionario_individual.txt"))

    else:
        nombre_archivo = 'usu_hogar_t'+str(trimestre)+str(anio)[2:]+'.txt'
        etiquetas = json.load(open("eph/diccionario_hogar.txt"))

    #leer datos
    dt = pd.read_csv(z.open(nombre_archivo),sep=';',dtype=str)
    #etiquetar
    dt = dt.replace(etiquetas)
    return dt

dt = epyh(anio = 2018, trimestre = 2,individual = False)
dt.head()
