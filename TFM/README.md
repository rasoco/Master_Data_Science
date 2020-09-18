# BiciMad Project

# Contents 

[Introduction](#introduction)

[Methodology and Tools](#Methodology-and-Tools)

[Data Acquisition](#Data-Acquisition)

[Data Exploration](#Data-Exploration)

[Models](#Models)

[Visualization](#Visualization)



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



# Data Exploration 

*Datos de puntos de estacionamientos*

- Dimensión del dataframe. Tiene 216 filas y 17 columnas.

` df.shape
   (216, 17)`

- Visualizamos las primeras cinco líneas del dataframe.

```python
df.head(3)

id	Gis_X	Gis_Y	Fecha de Alta	Distrito	Barrio	Calle	Nº Finca	Tipo de Reserva	Anclajes	Unnamed: 10	LONGITUD	LATITUD	DIRECCION	Year	ids	Locationlist
0	001 a	440443,61	4474290,65	04/12/2019	01  CENTRO	01-06 SOL	ALCALA, CALLE, DE	2	BiciMAD	30	NaN	-3.701998	40.417111	CALLE DE ALCALA, 2	2019	1	[40.417110795315295, -3.70199802576925]
1	001 b	440480,56	4474301,74	06/02/2020	01  CENTRO	01-06 SOL	ALCALA, CALLE, DE	6	BiciMAD	30	NaN	-3.701564	40.417213	CALLE DE ALCALA, 6	2020	1	[40.4172133427666, -3.7015635605662203]
2	2	440134,83	4474678,23	23/06/2014	01  CENTRO	01-05 UNIVERSIDAD	MIGUEL MOYA, CALLE, DE	1	BiciMAD	24	NaN	-3.705674	40.420580	CALLE DE MIGUEL MOYA, 1	2014	2	[40.4205801410996, -3.7056738708445]
```


*Datos de  BiciMad de Enero 2018*

- Dimensión del dataframe. Tiene 263701 registro y 11 columnas.

` df.shape
   (263701, 11)`

- Visualizamos las primeras cinco líneas del dataframe.

```python
df.head(3)

id	user_day_code	idunplug_station	idunplug_base	idplug_station	idplug_base	user_type	travel_time	unplug_hourTime	ageRange	zip_code
0	5a505acd2f384319304ed614	b00665a845be18ed9f036c2d72def1ef2fa2c49365cb64...	6	14	7	1	1	284	{'$date': '2018-01-01T00:00:00.000+0100'}	5	28010
1	5a505acd2f384319304ed615	65a82ac6353d9e8b25c17a49bb46d09426757b40946370...	24	21	117	4	1	666	{'$date': '2018-01-01T00:00:00.000+0100'}	0	
2	5a505acd2f384319304ed616	51b7da733980586e1f847b61cc4af9c0268fc2d09df63e...	24	19	117	19	1	662	{'$date': '2018-01-01T00:00:00.000+0100'}	0	

```








# Modeling


# Visualization






