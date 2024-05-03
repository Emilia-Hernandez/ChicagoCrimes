DROP SCHEMA IF EXISTS raw CASCADE ;
CREATE SCHEMA raw;

DROP TABLE IF EXISTS raw.rawCrimes ;
CREATE TABLE raw.rawCrimes
(
    id                   text,
    fecha                text,
    direccion            text,
    icur                 text,
    primaryDescription   text,
    secondaryDescription text,
    locationDescription  text,
    arrest               text,
    domestic             text,
    beat                 numeric,
    ward                 numeric,
    clasifiacionFBI      text,
    xCoordinate          text,
    yCoordinate          text,
    latitude             numeric,
    longitude            numeric,
    location            text
);
