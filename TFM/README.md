# BiciMad Project

# Contents 
[Introduction](master_data_science/TFM#introduction)
[Methodology and Tools](master_data_science/TFM#Methodology-and-Tools)

# Introduction
Mi interés por desarrollar un proyecto sobre la movilidad sostenible de Madrid surge porque soy aficionada a montar en bici y además por el volumen de datos que se puede manejar y analizar sobre los movimientos de los usuarios. En la búsqueda de datos encontre la base de datos abierta de [EMT Madrid](https://opendata.emtmadrid.es/Datos-estaticos/Datos-generales-(1)) en la cual tienes acceso al sistema de bicicletas públicas de Madrid conocido como BiciMad. Para obtener los datos de los puntos de estacionamientos me puse en contacto con el [Portal de datos abiertos del Ayuntamiento de Madrid](https://datos.madrid.es/sites/v/index.jsp?vgnextoid=e9b2a4059b4b7410VgnVCM2000000c205a0aRCRD&vgnextchannel=374512b9ace9f310VgnVCM100000171f5a0aRCRD) ya que los datos no estaban actualizados, fueron muy amables y a los pocos días los actualizaron. 

Después de realizar un brainstorming sobre las diferentes líneas de estudios a realizar, obtuve los siguientes objetivos:

- Análisis exploratorio de los puntos de estacionamientos.
- Análisis exploratorio del uso de bici utilizando los datos BiciMad de Enero 2018.
- Algoritmo que detecte el tipo de usuario.

# Methodology and Tools
El proyecto se ha realizado utilizando Google Colaboratory, es un entorno gratuito de Jupyter Notebook que no requiere configuración y se ejecuta en la nube. Para el desarrollo del código el lenguaje de programación que he usado ha sido Python para la limpieza, tratamiento, ejecución de datos así como las diferentes técnicas de Machine Learning. A continuación, indico las herramientas utilizadas:

- Entorno de desarrollo: Jupyter Notebook utilizandolo en Google Colaboratory
- Lenguaje de programación: Python 3.6
- Librerías para limpieza y tratamiento de datos: numpy, pandas.
- Librerías para visualización: matplotlib, seaborn, folium, bokeh, streamlit, altair.
- Librería para modelos: sklearn.

# Data Acquisition

## *Datos BiciMad de Enero 2018*
El Dataset de BiciMad recoge los datos Enero 2018, codificados en formato JSON y obtenidos en el portal de datos abiertos de la [EMT Madrid](https://opendata.emtmadrid.es/Datos-estaticos/Datos-generales-(1)). Este conjunto de datos recoge las siguientes variables:

- Identificador del trayecto
- Código del usuario. Para una misma fecha, todos los movimientos de un mismo usuario.
- Número de la estación de la que se desengancha la bicicleta.
- Número de la base de la que se desengancha la bicicleta.
- Número de la estación en la que se engancha la bicicleta.
- Número de la base en la que se engancha la bicicleta.
-  Franja horaria en la que se realiza el desenganche de la bicicleta.
- Tiempo total en segundos, entre el desenganche y el enganche de la bicicleta. 
- Detalle del trayecto realizado por la bicicleta entre la estación de partida y la de destino, en formato GeoJSON. 
- user_type: Número que indica el tipo de usuario que ha realizado el movimiento. Sus posibles valores son los siguientes:

  * 0: No se ha podido determinar el tipo de usuario
  * 1: Usuario anual (poseedor de un pase anual)
  * 2: Usuario ocasional
  * 3: Trabajador de la empresa 

- ageRange: Número que indica el rango de edad del usuario que ha realizado el movimiento. Sus posibles valores son:

  * 0: No se ha podido determinar el rango de edad del usuario
  * 1: El usuario tiene entre 0 y 16 años
  * 2: El usuario tiene entre 17 y 18 años
  * 3: El usuario tiene entre 19 y 26 años
  * 4: El usuario tiene entre 27 y 40 años
  * 5: El usuario tiene entre 41 y 65 años
  * 6: El usuario tiene 66 años o más 

- Código postal. El código postal del usuario que ha realizado el movimiento. 

## *Datos de puntos de estacionamientos*

Los datos de estacionamientos en el cual se obtiene la información de los puntos donde se pueden retirar bicicletas eléctricas. Este conjunto de datos recoge las siguientes variables: 

- Número de estación
- Gis_X
- Gis_Y
- Fecha de Alta
- Distrito
- Barrio
- Calle
- Nº de Finca
- Tipo de reserva
- Número de plazas
- Longitud
- Latitud
- Dirección





