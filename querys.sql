DROP VIEW IF EXISTS horConCrimen CASCADE;
CREATE OR REPLACE VIEW horaConCrimen AS
SELECT CAST(cleaning.crimeslimpia.fecha AS time) as hora,
       cleaning.location.direccion as direccion, cleaning.icur.primarydescription as primarydescription,
       cleaning.icur.secondarydescription, cleaning.crimeslimpia.domestic,
       cleaning.location.ward as ward
FROM cleaning.crimeslimpia
INNER JOIN cleaning.location on cleaning.crimeslimpia.id_location = cleaning.location.id
INNER JOIN cleaning.icur   ON cleaning.icur.icur = cleaning.crimeslimpia.icur;

SELECT *
FROM horaConCrimen;

--HACER CON FUNCOINES DE VENATNA UNA TABLA QUE LE AGREGRA SEGUN EL WARD  A POSICION EN INSEGUIDAD

--DISTRITO MAS PELIGROSO
DROP VIEW IF EXISTS ranking_inseguridad_distrios;
CREATE or replace view ranking_inseguridad_distrios AS
SELECT  ward, COUNT(*) numero_crimenes, ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS ranking_distiro_mas_inseguro
FROM horaConCrimen
GROUP BY ward
ORDER BY count(*) desc;

SELECT *
FROM ranking_inseguridad_distrios;

DROP VIEW IF EXISTS horaLugarDomPrimDes CASCADE;
CREATE OR REPLACE VIEW horaLugarDomPrimDes AS
SELECT  EXTRACT(HOUR from hora) as hora, ward, domestic, primarydescription
FROM horaConCrimen;

SELECT *
FROM horaLugarDomPrimDes;

--ranking horas mas peligrosa por ward
DROP VIEW IF EXISTS ranking_hora_mas_peligrosa_por_ward CASCADE;
CREATE OR REPLACE VIEW ranking_hora_mas_peligrosa_por_ward AS
SELECT  ward, hora, count(*) as numero_crimenes, ROW_NUMBER() OVER (PARTITION BY ward ORDER BY count(*) DESC) AS ranking_hora
FROM horaLugarDomPrimDes
GROUP BY ward, hora;
--HORA MÁS PIGROSA POR WARD
SELECT ward, hora, numero_crimenes
FROM ranking_hora_mas_peligrosa_por_ward
WHERE ranking_hora = 1;

--CRIMEN MÁS FRECUENTE
DROP VIEW IF EXISTS ranking_frecuencia_tipo_de_crimen;
CREATE or replace view ranking_frecuencia_tipo_de_crimen AS
SELECT primarydescription, COUNT(*) numero_crimenes, ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS ranking_crimen_mas_popular
FROM horaConCrimen
GROUP BY primarydescription
ORDER BY count(*) desc;

SELECT *
FROM ranking_frecuencia_tipo_de_crimen;

--ranking horas mas comunes por crimen
DROP VIEW IF EXISTS ranking_hora_mas_peligrosa_por_crimen CASCADE;
CREATE OR REPLACE VIEW ranking_hora_mas_peligrosa_por_crimen AS
SELECT primarydescription, hora, count(*) as numero_crimenes, ROW_NUMBER() OVER (PARTITION BY primarydescription ORDER BY count(*) DESC) AS ranking_hora
FROM horaLugarDomPrimDes
GROUP BY primarydescription, hora;

SELECT *
FROM ranking_hora_mas_peligrosa_por_crimen
WHERE ranking_hora=1
ORDER BY primarydescription;

--hora mas común si es o no domestico ranking_hora_mas_peligrosa_domesticidad
DROP VIEW IF EXISTS ranking_hora_mas_peligrosa_domesticidad ;
CREATE OR REPLACE VIEW ranking_hora_mas_peligrosa_domesticidad AS
SELECT domestic, hora, count(*) as numero_crimenes, ROW_NUMBER() OVER (PARTITION BY domestic ORDER BY count(*) DESC) AS ranking_hora
FROM horaLugarDomPrimDes
GROUP BY domestic, hora;

--TOP 5 HORAS EN LAS QUE MAS SE COMETEN CRIMENES domesticos y no domesticos
SELECT domestic, HORA, NUMERO_CRIMENES
FROM ranking_hora_mas_peligrosa_domesticidad
WHERE ranking_hora <=5;

--RELACIÓN DOMESTICIDAD CON ARRESTO
DROP VIEW IF EXISTS relacion_arresto_domesticidad ;
CREATE OR REPLACE VIEW relacion_arresto_domesticidad AS
SELECT domestic,arrest,  count(*) as numero_crimenes
FROM cleaning.crimeslimpia
GROUP BY domestic, arrest;

SELECT *
FROM relacion_arresto_domesticidad
ORDER BY domestic,arrest;
