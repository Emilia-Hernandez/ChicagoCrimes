# ChicagoCrimes
Limpieza, normalización y querys sobre una base de datos del estado de Chicago sobre los crimenes cometidos.
Para descargar el dataset, seguir el siguiente link: https://drive.google.com/file/d/1JTbi51ZZEFOVVsfcCiSyaKaNvGTqHp0Z/view?usp=drive_link. 
La tabla es la que describe el sigueinte link: https://data.cityofchicago.org/Public-Safety/Crimes-One-year-prior-to-present/x2n5-8w5q/about_data
# Carga incial de datos
Para insertar los datos en bruto se debe primero correr el script *raw_data_creation*  y posteriormente ejecutar el siguiente comando en una sesión de línea de comandos de Postgres.
>\copy raw.rawCrimes FROM 'download\file\path.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');
# Limpieza
El script correspondiente es el llamado: *limpieza*
# Querys
El script correspondiente es el llamado: *querys*
