
DROP SCHEMA IF EXISTS cleaning CASCADE;
CREATE SCHEMA cleaning;

DROP TABLE IF EXISTS cleaning.crimesJuego;
CREATE TABLE cleaning.crimesJuego(
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
INSERT INTO cleaning.crimesJuego
select *
FROM raw.rawCrimes
LIMIT 50000;

UPDATE cleaning.crimesJuego
SET direccion = UPPER(direccion),
    primaryDescription = upper(primaryDescription),
    secondaryDescription = UPPER(secondaryDescription),
    locationDescription = UPPER(locationDescription),
    arrest = upper(arrest),
    domestic = upper(domestic),
    clasifiacionFBI = upper(clasifiacionFBI);
DROP TABLE IF EXISTS cleaning.crimes2;
CREATE TABLE cleaning.crimes2 (
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
INSERT INTO cleaning.crimes2
SELECT DISTINCT id, fecha, direccion, icur, primaryDescription, secondaryDescription, locationDescription, arrest, domestic, beat, ward, clasifiacionFBI,xCoordinate, yCoordinate, latitude, longitude
FROM cleaning.crimesJuego;

DROP TABLE IF EXISTS cleaning.crimesjuego;

UPDATE cleaning.crimes2
SET locationdescription =
    CASE
        WHEN locationdescription ILIKE '%PARKING LOT%' THEN 'PARKING LOT'
        WHEN locationdescription ILIKE '%AIRPORT%' THEN 'AIRPORT'
        WHEN locationdescription ILIKE '%AUTO%' THEN 'AUTO'
        WHEN locationdescription ILIKE '%COLLEGE%' THEN 'COLLEGE'
        WHEN locationdescription ILIKE '%APARTMENT%' THEN 'APARTMENT'
        WHEN locationdescription ILIKE '%HALLWAY%' THEN 'HALLWAY'
        WHEN locationdescription ILIKE '%BUS%'  THEN 'BUS'
        WHEN locationdescription ILIKE '%PLATFORM%' THEN 'PLATFORM'
        WHEN locationdescription ILIKE '%STATION%' THEN 'STATION'
        WHEN locationdescription ILIKE '%TRACKS%' THEN 'TRACKS'
        WHEN locationdescription ILIKE '%TRAIN%' THEN 'TRAIN'
        WHEN locationdescription ILIKE '%DRIVEWAY%' THEN 'DRIVEWAY'
        WHEN locationdescription ILIKE '%OTHER%' THEN 'OTHER'
        WHEN locationdescription ILIKE '%RESIDENCE%' OR locationdescription ILIKE '%PORCH%' THEN 'RESIDENCE'
        WHEN locationdescription ILIKE '%MEDICAL%' OR locationdescription ILIKE '%HOSPITAL%' THEN 'HOSPITAL'
        WHEN locationdescription ILIKE '%SCHOOL%' THEN 'SCHOOL'
        WHEN locationdescription ILIKE '%STORE%'  THEN 'STORE'
        WHEN locationdescription ILIKE '%VEHICLE%' THEN 'VEHICLE'
        WHEN locationdescription ILIKE '%LOT%' THEN 'LOT'
        WHEN locationdescription ILIKE '%OTHER%' THEN 'OTHER'
        ELSE locationdescription
    END;

DROP TABLE IF EXISTS cleaning.crimes3;
CREATE TABLE cleaning.crimes3 (
    id                   varchar(10),
    fecha                text,
    direccion            varchar(100),
    icur                 varchar(4),
    primaryDescription   varchar(50),
    secondaryDescription varchar(100),
    locationDescription  varchar(100),
    arrest               varchar(1),
    domestic             varchar(1),
    beat                 smallint,
    ward                 smallint,
    clasifiacionFBI      varchar(5),
    xCoordinate          integer,
    yCoordinate          integer,
    latitude             numeric,
    longitude            numeric
) ;
INSERT INTO cleaning.crimes3
SELECT id, fecha, direccion, icur, primarydescription, secondarydescription, locationdescription, arrest, domestic, CAST(beat as smallint), CAST(ward as smallint),
                clasifiacionfbi, CAST(xcoordinate AS integer), CAST(ycoordinate as integer), latitude,longitude
FROM cleaning.crimes2;
DROP TABLE IF EXISTS cleaning.crimes2;


--LIMPIEZA TABLA ICUR
UPDATE cleaning.crimes3
SET secondarydescription=
    CASE
        WHEN clasifiacionfbi ILIKE '08A' or clasifiacionfbi ILIKE '08B' THEN 'AGGRAVATED NO INJURY'
        WHEN primaryDescription ILIKE '%ARSON%' THEN 'BY FIRE'
        WHEN icur ILIKE '0498' or icur ILIKE '0462' THEN 'AGGRAVATED SERIOUS INJURY'
        WHEN clasifiacionfbi ILIKE '04A' or clasifiacionfbi ILIKE '04B' THEN 'AGGRAVATED'
        WHEN icur ILIKE '0630' or icur  ILIKE '0610' or icur ILIKE '0620' then 'FORCIBLE AND UNLAWFUL ENTRY'
        WHEN icur ILIKE '1480' or icur ILIKE '1478'  then 'PROHIBITED PLACES'
        WHEN icur ILIKE '1375' OR icur ILIKE '1345' OR icur ILIKE '1310' or icur ILIKE '1340' or icur ILIKE '1320' then 'TO PROPERTY / VANDALISM'
        WHEN icur ILIKE '0261' or icur ILIKE '0263' or icur ILIKE '0265' or icur ILIKE '0264' or icur ILIKE '0262' or icur ILIKE '0271' or icur ILIKE '0273' or icur ILIKE '0275' THEN 'AGGRAVATED WITH DANGEROUS WEAPON'
        WHEN icur ILIKE '0291' or icur ILIKE '0281' THEN 'NON-AGGRAVATED'
        WHEN clasifiacionfbi ILIKE '10' THEN 'FORGERY AND COUNTERFEIT'
        WHEN icur ILIKE '1155' or icur ILIKE '1156' or icur ILIKE '1154' or icur ILIKE '1153' THEN 'IDENTITY THEFT'
        WHEN icur ILIKE '1110' or icur ILIKE '1242' or icur ILIKE '1150' or icur ILIKE '1130' or icur ILIKE '1135' THEN 'FRAUD'
        WHEN clasifiacionfbi ILIKE '%08A%' AND primarydescription ILIKE 'INTIMIDATION' THEN 'INTIMIDATION'
        WHEN icur ILIKE '0920' or icur ILIKE '0927' or icur  ILIKE '0925' THEN 'ATTEMPT'
        WHEN icur ILIKE '0918' or icur ILIKE '0917' THEN 'CYCLE, SCOOTER, BIKE'
        WHEN icur ILIKE '0930' or icur ILIKE '0937' or icur ILIKE '0935' THEN 'THEFT/RECOVERY'
        WHEN secondarydescription ILIKE '%MANUFACTURE / DELIVER%' AND clasifiacionfbi ILIKE '18' THEN 'MANUFACTURE / DELIVERY OF DRUGS'
        WHEN secondarydescription ILIKE '%POSSES%' AND clasifiacionfbi ILIKE'18' THEN 'POSSESSION OF DRUGS'
        WHEN ICUR ILIKE '1535' OR icur ILIKE '1540' THEN 'OBSCENE MATTER'
        WHEN icur ILIKE '1725' or icur ILIKE '1720' THEN 'CONTRIBUTE TO THE DELINQUENCY OF CHILD'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE '%GUN OFFENDER%' THEN 'GUN OFFENDER'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE '%HARASSMENT%' THEN 'HARASSMENT'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE '%SEX OFFENDER%' THEN 'SEX OFFENDER'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE '%VIOLENT OFFENDER%' THEN 'VIOLENT OFFENDER'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE '%AGGRAVATED%' THEN 'AGGRAVATED'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE 'ARMED%' THEN 'ARMED'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE 'ATTEMPT%' THEN 'ATTEMPT ARMED'
        WHEN icur ILIKE '1590' or icur ILIKE '5004' THEN 'ATTEMPT CRIMINAL SEXUAL ABUSE'
        WHEN clasifiacionfbi ILIKE '15' and secondarydescription ILIKE 'UNLAWFUL POSSESSION%' THEN 'UNLAWFUL POSSESSION'
        WHEN clasifiacionfbi ILIKE '15' and secondarydescription ILIKE 'UNLAWFUL USE%' THEN 'UNLAWFUL USE'
        else secondarydescription
    END;
UPDATE cleaning.crimes3
SET icur=
    CASE
        WHEN clasifiacionfbi ILIKE '08A' AND primarydescription ilike 'ASSAULT' THEN '0554'
        WHEN clasifiacionfbi ILIKE '08B' AND primarydescription ilike 'BATTERY' THEN '0484'
        WHEN primaryDescription ILIKE '%ARSON%' THEN '1025'
        WHEN clasifiacionfbi ILIKE '04A' AND primarydescription ilike 'ASSAULT'THEN '051A'
        WHEN clasifiacionfbi ILIKE '04B'AND primarydescription ilike 'BATTERY' AND secondarydescription ilike 'AGGRAVATED' THEN '0497'
        WHEN icur ILIKE '0630' or icur  ILIKE '0610' or icur ILIKE '0620' then '0630'
        WHEN icur ILIKE '1480' or icur ILIKE '1478'  then '1480'
        WHEN icur ILIKE '1375' OR icur ILIKE '1345' OR icur ILIKE '1310' or icur ILIKE '1340' or icur ILIKE '1320' then '1375'
        WHEN icur ILIKE '0261' or icur ILIKE '0263' or icur ILIKE '0265' or icur ILIKE '0264' or icur ILIKE '0262' or icur ILIKE '0271' or icur ILIKE '0273' or icur ILIKE '0275' THEN '0261'
        WHEN icur ILIKE '0291' or icur ILIKE '0281' THEN '0291'
        WHEN clasifiacionfbi ILIKE '10' THEN '1122'
        WHEN icur ILIKE '1155' or icur ILIKE '1156' or icur ILIKE '1154' or icur ILIKE '1153'  THEN '1155'
        WHEN icur ILIKE '1110' or icur ILIKE '1242' or icur ILIKE '1150' or icur ILIKE '1130' or icur ILIKE '1135'  THEN '1110'
        WHEN clasifiacionfbi ILIKE '%08A%' AND primarydescription ILIKE 'INTIMIDATION' THEN '3960'
        WHEN icur ILIKE '0920' or icur ILIKE '0927' or icur  ILIKE '0925' THEN '0920'
        WHEN icur ILIKE '0918' or icur ILIKE '0917' THEN '0918'
        WHEN secondarydescription ILIKE '%MANUFACTURE / DELIVER%' AND clasifiacionfbi ILIKE'18' THEN '2014'
        WHEN secondarydescription ILIKE '%POSSES%' AND clasifiacionfbi ILIKE'18' THEN '2020'
        WHEN ICUR ILIKE '1535'  THEN '1535'
        WHEN icur ILIKE '1540' THEN '1540'
        WHEN icur ILIKE '1725' or icur ILIKE '1720' THEN '1725'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE '%GUN OFFENDER%' THEN '5111'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE '%HARASSMENT%' THEN '2826'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE 'SEX OFFENDER%' THEN '4650'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE 'VIOLENT OFFENDER%' THEN '5131'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE 'AGGRAVATED%' AND primarydescription ILIKE 'ROBBERY' THEN '0330'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE 'ARMED%' AND primarydescription ILIKE 'ROBBERY' THEN '031A'
        WHEN clasifiacionfbi ILIKE '26' and secondarydescription ILIKE 'ATTEMPT%' AND primarydescription ILIKE 'ROBBERY'THEN '033A'
        WHEN icur ILIKE '1590' or icur ILIKE '5004' THEN '1590'
        WHEN clasifiacionfbi ILIKE '15' and secondarydescription ILIKE 'UNLAWFUL POSSESSION%' THEN '143C'
        WHEN clasifiacionfbi ILIKE '15' and secondarydescription ILIKE 'UNLAWFUL USE%' THEN '141A'
        else icur
    END;

DROP TABLE IF EXISTS cleaning.icur;
CREATE TABLE cleaning.icur(
     icur                 varchar(4) PRIMARY KEY,
    primaryDescription   varchar(50) NOT NULL,
    secondaryDescription varchar(100) NOT NULL,
    clasifiacionFBI      varchar(5) NOT NULL
);
DROP INDEX IF EXISTS cleaning.icur_index;
CREATE INDEX IF NOT EXISTS icur_index ON cleaning.icur USING BTREE (icur);
INSERT INTO cleaning.icur
SELECT DISTINCT icur, primarydescription, secondarydescription, clasifiacionfbi
FROM cleaning.crimes3;


--LIMPIEZA PARA CREAR LA TABLA LOCATION
UPDATE cleaning.crimes3
SET beat=813
WHERE (xcoordinate, ycoordinate, locationdescription)= (1145740,1861084,'STREET');
UPDATE cleaning.crimes3
SET beat=132
WHERE (xcoordinate, ycoordinate)= (1177540, 1890161);
UPDATE cleaning.crimes3
SET beat=1021
WHERE (xcoordinate, ycoordinate)= (1154616,1892209);
UPDATE cleaning.crimes3
SET beat=2522
WHERE (xcoordinate, ycoordinate)= (1146651, 1912925);
UPDATE cleaning.crimes3
SET beat=323
WHERE (xcoordinate, ycoordinate)= (1179854,1858023);
UPDATE cleaning.crimes3
SET beat=713
WHERE (xcoordinate, ycoordinate)= (1166686, 1865425);
UPDATE cleaning.crimes3
SET beat=235
WHERE (xcoordinate, ycoordinate)= (1182571, 1866562);
UPDATE cleaning.crimes3
SET beat=511, ward = 9
WHERE (xcoordinate, ycoordinate)= (1177703, 1841947);
UPDATE cleaning.crimes3
SET direccion = '0000X E 110TH PL'
WHERE (xcoordinate, ycoordinate)= (1178617, 1831874);
UPDATE cleaning.crimes3
SET BEAT = 632
WHERE (xcoordinate, ycoordinate)= (1183474, 1850149);
UPDATE cleaning.crimes3
SET BEAT = 1923
WHERE (xcoordinate, ycoordinate)= (1170200, 1924134);
UPDATE cleaning.crimes3
SET ward = 8
WHERE (xcoordinate, ycoordinate)= (1182971, 1851239);
UPDATE cleaning.crimes3
SET ward = 1
WHERE (xcoordinate, ycoordinate)= (1160114, 1910738);
UPDATE cleaning.crimes3
SET beat = 1021
WHERE (xcoordinate, ycoordinate)= (1153720, 1894499);
UPDATE cleaning.crimes3
SET ward = 28
WHERE (xcoordinate, ycoordinate)= (1173303, 1895451);
UPDATE cleaning.crimes3
SET ward = 16
WHERE (xcoordinate, ycoordinate)= (1170858, 1858243);
UPDATE cleaning.crimes3
SET ward = 2
WHERE (xcoordinate, ycoordinate)= (1170858, 1858243);
UPDATE cleaning.crimes3
SET ward = 2
WHERE (xcoordinate, ycoordinate)= (1178915, 1904276);
UPDATE cleaning.crimes3
SET direccion = '009XX W RANDOLPH ST'
WHERE (xcoordinate, ycoordinate)= (1170233, 1901231);
UPDATE cleaning.crimes3
SET beat = 1122
WHERE (xcoordinate, ycoordinate)= (1149754, 1898946);
UPDATE cleaning.crimes3
SET beat = 1011
WHERE (xcoordinate, ycoordinate)= (1152561, 1894367);
UPDATE cleaning.crimes3
SET beat = 624
WHERE (xcoordinate, ycoordinate)= (1180632, 1855387);
UPDATE cleaning.crimes3
SET ward = 34
WHERE (xcoordinate, ycoordinate)= (1175696, 1895352);
UPDATE cleaning.crimes3
SET ward = 34
WHERE (xcoordinate, ycoordinate)= (1176352, 1900927);
UPDATE cleaning.crimes3
SET BEAT = 532
WHERE (xcoordinate, ycoordinate)= (1179714, 1828756);
UPDATE cleaning.crimes3
SET WARD = 6
WHERE (xcoordinate, ycoordinate)= (1177935, 1843153);
UPDATE cleaning.crimes3
SET beat = 713
WHERE (xcoordinate, ycoordinate)= (1166617, 1867978);
UPDATE cleaning.crimes3
SET beat = 2535
WHERE (xcoordinate, ycoordinate)= (1151973, 1913049);
UPDATE cleaning.crimes3
SET ward = 44
WHERE (xcoordinate, ycoordinate)= (1170273, 1924431);
UPDATE cleaning.crimes3
SET ward = 25
WHERE (xcoordinate, ycoordinate)=(1156761, 1887172);
UPDATE cleaning.crimes3
SET ward = 12
WHERE (xcoordinate, ycoordinate)=(1155395, 1888239);
UPDATE cleaning.crimes3
SET ward = 4
WHERE (xcoordinate, ycoordinate)=(1181568, 1872009);
UPDATE cleaning.crimes3
SET ward = 37
WHERE (xcoordinate, ycoordinate)=(1150569, 1905375);
UPDATE cleaning.crimes3
SET ward = 8
WHERE (xcoordinate, ycoordinate)=(1183009, 1849965);
UPDATE cleaning.crimes3
SET beat = 1523
WHERE (xcoordinate, ycoordinate)=(1141617, 1900253);
UPDATE cleaning.crimes3
SET direccion = '023XX S LAKE SHORE DR NB'
WHERE (xcoordinate, ycoordinate)=(1180536, 1888993);
UPDATE cleaning.crimes3
SET ward = 15
WHERE (xcoordinate, ycoordinate)=(1159302, 1865423) ;
UPDATE cleaning.crimes3
SET ward = 46
WHERE (xcoordinate, ycoordinate)=(1167057, 1932694) ;
UPDATE cleaning.crimes3
SET beat = 424
WHERE (xcoordinate, ycoordinate)=(1197730, 1845034) ;
UPDATE cleaning.crimes3
SET ward = 47
WHERE (xcoordinate, ycoordinate)=(1159771, 1922681) ;
UPDATE cleaning.crimes3
SET ward = 28
WHERE (xcoordinate, ycoordinate)=(1173336, 1893976) ;
UPDATE cleaning.crimes3
SET beat = 1833
WHERE (xcoordinate, ycoordinate)=(1177936, 1905411)  ;
UPDATE cleaning.crimes3
SET beat = 1124
WHERE (xcoordinate, ycoordinate)=(1154889, 1899837);
UPDATE cleaning.crimes3
SET beat = 1722
WHERE (xcoordinate, ycoordinate)=(1148778, 1931597);
UPDATE cleaning.crimes3
SET ward = 25
WHERE (xcoordinate, ycoordinate)=(1170936, 1892684);
UPDATE cleaning.crimes3
SET ward = 27
WHERE (xcoordinate, ycoordinate)=(1170815, 1900748);
UPDATE cleaning.crimes3
SET ward = 8
WHERE (xcoordinate, ycoordinate)=(1181947, 1847437);
UPDATE cleaning.crimes3
SET ward = 1113
WHERE (xcoordinate, ycoordinate)=(1147062, 1899564);
UPDATE cleaning.crimes3
SET ward = 1421
WHERE (xcoordinate, ycoordinate)=(1158043, 1910528);
UPDATE cleaning.crimes3
SET ward = 34
WHERE (xcoordinate, ycoordinate)=(1176963, 1894850) ;
UPDATE cleaning.crimes3
SET beat = 1233
WHERE (xcoordinate, ycoordinate)=(1167717, 1894825);
UPDATE cleaning.crimes3
SET beat = 111
WHERE (xcoordinate, ycoordinate)=(1177257, 1901899);
UPDATE cleaning.crimes3
SET ward = 19
WHERE (xcoordinate, ycoordinate)=(1166969, 1841705);
UPDATE cleaning.crimes3
SET beat = 923
WHERE (xcoordinate, ycoordinate)=(1166541, 1870734);
UPDATE cleaning.crimes3
SET ward = 4
WHERE (xcoordinate, ycoordinate)=(1177749, 1884891);
UPDATE cleaning.crimes3
SET ward = 6
WHERE (xcoordinate, ycoordinate)=(1182717, 1860597);
UPDATE cleaning.crimes3
SET ward = 34
WHERE (xcoordinate, ycoordinate)=(1175316, 1898354);
UPDATE cleaning.crimes3
SET ward = 34
WHERE (xcoordinate, ycoordinate)=(1176400, 1899863);
UPDATE cleaning.crimes3
SET ward = 21
WHERE (xcoordinate, ycoordinate)=(1172930, 1832289);
UPDATE cleaning.crimes3
SET ward = 4
WHERE (xcoordinate, ycoordinate)=(1175947, 1898054);
UPDATE cleaning.crimes3
SET ward = 4, direccion = '0000X W CONGRESS PKWY'
WHERE (xcoordinate, ycoordinate)=(1175947, 1898054);
UPDATE cleaning.crimes3
SET beat = 915
WHERE (xcoordinate, ycoordinate)=(1175287, 1884420);
UPDATE cleaning.crimes3
SET beat = 1421
WHERE (xcoordinate, ycoordinate)=(1158043, 1910528);
UPDATE cleaning.crimes3
SET ward = 6
WHERE (xcoordinate, ycoordinate)=(1183068, 1847963);
UPDATE cleaning.crimes3
SET ward = 13
WHERE (xcoordinate, ycoordinate)=(1145654, 1866253) ;
UPDATE cleaning.crimes3
SET ward = 15
WHERE (xcoordinate, ycoordinate)=(1171750, 1874033);
UPDATE cleaning.crimes3
SET ward = 35
WHERE (xcoordinate, ycoordinate)=(1150290, 1916515);
UPDATE cleaning.crimes3
SET ward = 17
WHERE (xcoordinate, ycoordinate)=(1172199, 1857618);
UPDATE cleaning.crimes3
SET ward = 17, beat = 733
WHERE (xcoordinate, ycoordinate)=(1172199, 1857618);
UPDATE cleaning.crimes3
SET ward =1125
WHERE (xcoordinate, ycoordinate)=(1160159, 1899944);
UPDATE cleaning.crimes3
SET ward = 27,  beat =1125
WHERE (xcoordinate, ycoordinate)=(1160159, 1899944);
UPDATE cleaning.crimes3
SET beat =1113
WHERE (xcoordinate, ycoordinate)=(1144364, 1900336);
UPDATE cleaning.crimes3
SET ward = 10
WHERE (xcoordinate, ycoordinate)=(1195510, 1836845);
UPDATE cleaning.crimes3
SET beat = 114
WHERE (xcoordinate, ycoordinate)=(1177258, 1901852);
UPDATE cleaning.crimes3
SET beat = 2412
WHERE (xcoordinate, ycoordinate)=(1158696, 1942407);
UPDATE cleaning.crimes3
SET beat = 1033, ward = 25
WHERE (xcoordinate, ycoordinate)=(1155527, 1883726);
UPDATE cleaning.crimes3
SET ward = 48
WHERE (xcoordinate, ycoordinate)=(1167411, 1933405);
UPDATE cleaning.crimes3
SET beat = 1022
WHERE (xcoordinate, ycoordinate)=(1155395, 1894538);
UPDATE cleaning.crimes3
SET ward = 16
WHERE (xcoordinate, ycoordinate)=(1166799, 1861252);
UPDATE cleaning.crimes3
SET beat = 311
WHERE (xcoordinate, ycoordinate)=(1179992, 1863712);
UPDATE cleaning.crimes3
SET beat = 331
WHERE (xcoordinate, ycoordinate)=(1190703, 1860780);
UPDATE cleaning.crimes3
SET beat = 1914
WHERE (xcoordinate, ycoordinate)=(1167774, 1931289);
UPDATE cleaning.crimes3
SET ward = 42
WHERE (xcoordinate, ycoordinate)=(1176038, 1905723);
UPDATE cleaning.crimes3
SET beat = 1221
WHERE (xcoordinate, ycoordinate)=(1163960, 1905374);
UPDATE cleaning.crimes3
SET ward = 31, beat = 1523
WHERE (xcoordinate, ycoordinate)=(1139022, 1900588);
UPDATE cleaning.crimes3
SET ward = 31, beat = 1523
WHERE (xcoordinate, ycoordinate)=(1139022, 1900588);
UPDATE cleaning.crimes3
SET ward = 31, beat = 1523
WHERE (xcoordinate, ycoordinate)=(1139022, 1900588);
UPDATE cleaning.crimes3
SET ward = 34
WHERE (xcoordinate, ycoordinate)=(1174331, 1900398);
UPDATE cleaning.crimes3
SET ward = 17
WHERE (xcoordinate, ycoordinate)=(1168764, 1850052);
UPDATE cleaning.crimes3
SET beat = 723
WHERE (xcoordinate, ycoordinate)=(1171308, 1863061);
UPDATE cleaning.crimes3
SET ward = 21, beat = 2222
WHERE (xcoordinate, ycoordinate)=(1170729, 1847123);
UPDATE cleaning.crimes3
SET beat = 1731
WHERE (xcoordinate, ycoordinate)=(1143721, 1923926);
UPDATE cleaning.crimes3
SET beat = 2522
WHERE (xcoordinate, ycoordinate)=(1141845, 1912826);
UPDATE cleaning.crimes3
SET ward = 42
WHERE (xcoordinate, ycoordinate)=(1176405, 1899625);
UPDATE cleaning.crimes3
SET beat = 1831
WHERE (xcoordinate, ycoordinate)=(1176000, 1904188);
UPDATE cleaning.crimes3
SET beat = 1731
WHERE (xcoordinate, ycoordinate)=(1193556, 1853551);
UPDATE cleaning.crimes3
SET ward = 21, beat = 613
WHERE (xcoordinate, ycoordinate)=(1172423, 1849658);
UPDATE cleaning.crimes3
SET beat = 1821
WHERE (xcoordinate, ycoordinate)=(1175314, 1908524);
UPDATE cleaning.crimes3
SET beat = 931
WHERE (xcoordinate, ycoordinate)=(1166467, 1873388);
UPDATE cleaning.crimes3
SET beat = 213
WHERE (xcoordinate, ycoordinate)=(1178941, 1876568);
UPDATE cleaning.crimes3
SET beat = 922
WHERE (xcoordinate, ycoordinate)=(1161186, 1872062);
UPDATE cleaning.crimes3
SET ward = 28
WHERE (xcoordinate, ycoordinate)=(1151008, 1901614);
UPDATE cleaning.crimes3
SET beat = 1511
WHERE (xcoordinate, ycoordinate)=(1137347, 1907404);
UPDATE cleaning.crimes3
SET ward = 10
WHERE (xcoordinate, ycoordinate)=(1194553, 1834880);
UPDATE cleaning.crimes3
SET beat = 1712
WHERE (xcoordinate, ycoordinate)=(1150106, 1931625);
UPDATE cleaning.crimes3
SET beat = 1423
WHERE (xcoordinate, ycoordinate)=(1154735, 1910259);
UPDATE cleaning.crimes3
SET ward = 28
WHERE (xcoordinate, ycoordinate)=(1168413, 1894846);
UPDATE cleaning.crimes3
SET beat = 1112
WHERE (xcoordinate, ycoordinate)=(1150061, 1904387);
UPDATE cleaning.crimes3
SET beat = 212
WHERE (xcoordinate, ycoordinate)=(1179988, 1881891);
UPDATE cleaning.crimes3
SET ward = 36
WHERE (xcoordinate, ycoordinate)=(1159224, 1906566);
UPDATE cleaning.crimes3
SET beat = 112
WHERE (xcoordinate, ycoordinate)=(1176634, 1899472);
UPDATE cleaning.crimes3
SET ward = 17
WHERE (xcoordinate, ycoordinate)=(1155810, 1862669);
UPDATE cleaning.crimes3
SET ward = 16
WHERE (xcoordinate, ycoordinate)=(1171188, 1858219);
UPDATE cleaning.crimes3
SET direccion = '002XX N MICHIGAN AVE'
WHERE (xcoordinate, ycoordinate)=(1177258, 1901852);
UPDATE cleaning.crimes3
SET ward = 7
WHERE (xcoordinate, ycoordinate)=(1194566, 1834239);
UPDATE cleaning.crimes3
SET beat = 1931
WHERE (xcoordinate, ycoordinate)=(1165266, 1916100);
UPDATE cleaning.crimes3
SET beat = 1034
WHERE (xcoordinate, ycoordinate)=(1161087, 1889344);
UPDATE cleaning.crimes3
SET ward = 6 , beat = 622
WHERE (xcoordinate, ycoordinate)=(1172388, 1850831);
UPDATE cleaning.crimes3
SET ward = 27
WHERE (xcoordinate, ycoordinate)=(1173757, 1906353);
UPDATE cleaning.crimes3
SET ward = 21
WHERE (xcoordinate, ycoordinate)=(1177810, 1847135);
UPDATE cleaning.crimes3
SET ward = 21
WHERE (xcoordinate, ycoordinate)=(1173478, 1824983);
UPDATE cleaning.crimes3
SET ward = 20
WHERE (xcoordinate, ycoordinate)=(1179710, 1871806);
UPDATE cleaning.crimes3
SET ward = 36
WHERE (xcoordinate, ycoordinate)=(1157530, 1907056);
UPDATE cleaning.crimes3
SET ward = 38, beat = 1632
WHERE (xcoordinate, ycoordinate)=(1131110, 1920530);
UPDATE cleaning.crimes3
SET beat = 1021
WHERE (xcoordinate, ycoordinate)=(1154560, 1894195);
UPDATE cleaning.crimes3
SET ward = 8
WHERE (xcoordinate, ycoordinate)=(1192241, 1852855);
UPDATE cleaning.crimes3
SET ward = 28, beat = 1023
WHERE (xcoordinate, ycoordinate)=(1157932, 1892551);
UPDATE cleaning.crimes3
SET beat = 2433
WHERE (xcoordinate, ycoordinate)=(1167566, 1939682);
UPDATE cleaning.crimes3
SET beat = 2024
WHERE (xcoordinate, ycoordinate)=(1168554, 1932051);
UPDATE cleaning.crimes3
SET beat = 1115
WHERE (xcoordinate, ycoordinate)=(1149756, 1898890);
UPDATE cleaning.crimes3
SET beat = 2424
WHERE (xcoordinate, ycoordinate)=(1163566, 1945922);
UPDATE cleaning.crimes3
SET beat = 111
WHERE (xcoordinate, ycoordinate)=(1177246, 1902350);
UPDATE cleaning.crimes3
SET beat = 113
WHERE (xcoordinate, ycoordinate)=(1176689, 1899474);
UPDATE cleaning.crimes3
SET beat = 815
WHERE (xcoordinate, ycoordinate)=(1145161, 1872678);
UPDATE cleaning.crimes3
SET ward = 17, beat = 614
WHERE (xcoordinate, ycoordinate)=(1168413, 1850809);
UPDATE cleaning.crimes3
SET ward = 7, beat = 324
WHERE (xcoordinate, ycoordinate)=(1189944, 1857944);
UPDATE cleaning.crimes3
SET beat = 2423
WHERE (xcoordinate, ycoordinate)=(1163243, 1947985);
UPDATE cleaning.crimes3
SET ward = 34
WHERE (xcoordinate, ycoordinate)=(1173115, 1826528);
UPDATE cleaning.crimes3
SET ward = 37, beat = 1524
WHERE (xcoordinate, ycoordinate)=(1138890, 1904424);
UPDATE cleaning.crimes3
SET beat = 532
WHERE (xcoordinate, ycoordinate)=(1178373, 1826647);
UPDATE cleaning.crimes3
SET beat = 2423
WHERE (xcoordinate, ycoordinate)=(1163408, 1946794);
UPDATE cleaning.crimes3
SET ward = 34
WHERE (xcoordinate, ycoordinate)=(1176790, 1901377);
UPDATE cleaning.crimes3
SET ward = 20
WHERE (xcoordinate, ycoordinate)=(1174724, 1875288);
UPDATE cleaning.crimes3
SET ward = 21
WHERE (xcoordinate, ycoordinate)=(1172764, 1828586);
UPDATE cleaning.crimes3
SET beat = 1433
WHERE (xcoordinate, ycoordinate)=(1165109, 1908650);
UPDATE cleaning.crimes3
SET ward = 36
WHERE (xcoordinate, ycoordinate)=(1135916, 1915323);
UPDATE cleaning.crimes3
SET ward = 37, beat = 1524
WHERE (xcoordinate, ycoordinate)=(1138891, 1904389);
UPDATE cleaning.crimes3
SET ward = 22
WHERE (xcoordinate, ycoordinate)=(1154478, 1889179);
UPDATE cleaning.crimes3
SET  beat = 622
WHERE (xcoordinate, ycoordinate)=(1176368, 1847206);
UPDATE cleaning.crimes3
SET beat = 1723
WHERE (xcoordinate, ycoordinate)=(1152753, 1931684);
UPDATE cleaning.crimes3
SET ward = 17
WHERE (xcoordinate, ycoordinate)=(1175681, 1851681);
UPDATE cleaning.crimes3
SET beat = 735
WHERE (xcoordinate, ycoordinate)=(1166876, 1858796);
UPDATE cleaning.crimes3
SET ward = 37
WHERE (xcoordinate, ycoordinate)=(1143956, 1903552);
UPDATE cleaning.crimes3
SET ward = 32
WHERE (xcoordinate, ycoordinate)=(1160867, 1917657);
UPDATE cleaning.crimes3
SET BEAT = 1134
WHERE (xcoordinate, ycoordinate)=(1155131, 1894531);
UPDATE cleaning.crimes3
SET ward = 29
WHERE (xcoordinate, ycoordinate)=(1138892, 1904360);
UPDATE cleaning.crimes3
SET beat = 922
WHERE (xcoordinate, ycoordinate)=(1155835, 1873178);
UPDATE cleaning.crimes3
SET ward = 35, beat = 2525
WHERE (xcoordinate, ycoordinate)=(1149252, 1915654);
UPDATE cleaning.crimes3
SET beat = 612
WHERE (xcoordinate, ycoordinate)=(1171041, 1851551);
UPDATE cleaning.crimes3
SET beat = 1233
WHERE (xcoordinate, ycoordinate)=(1168644, 1891779);
UPDATE cleaning.crimes3
SET ward = 15
WHERE (xcoordinate, ycoordinate)=(1156477, 1862446);
UPDATE cleaning.crimes3
SET ward = 42
WHERE (xcoordinate, ycoordinate)=(1171763, 1900767);
UPDATE cleaning.crimes3
SET beat = 132
WHERE (xcoordinate, ycoordinate)=(1177528, 1890620);
UPDATE cleaning.crimes3
SET ward = 36, beat = 2512
WHERE (xcoordinate, ycoordinate)=(1134109, 1917944);
UPDATE cleaning.crimes3
SET ward = 18
WHERE (xcoordinate, ycoordinate)=(1164404, 1852184);
UPDATE cleaning.crimes3
SET beat = 1925
WHERE (xcoordinate, ycoordinate)=(1170273, 1924431);
UPDATE cleaning.crimes3
SET beat = 1413
WHERE (xcoordinate, ycoordinate)=(1154615, 1916523);
UPDATE cleaning.crimes3
SET beat = 1424
WHERE (xcoordinate, ycoordinate)=(1163696, 1908020);
UPDATE cleaning.crimes3
SET beat = 2412
WHERE (xcoordinate, ycoordinate)=(1156420, 1942336);
UPDATE cleaning.crimes3
SET beat = 1232
WHERE (xcoordinate, ycoordinate)=(1168424, 1899132);
UPDATE cleaning.crimes3
SET ward = 16
WHERE (xcoordinate, ycoordinate)=(1166358, 1865343);
UPDATE cleaning.crimes3
SET beat = 215
WHERE (xcoordinate, ycoordinate)=(1179581, 1876320);
UPDATE cleaning.crimes3
SET beat = 2511
WHERE (xcoordinate, ycoordinate)=(1135663, 1920649);
UPDATE cleaning.crimes3
SET beat = 2413
WHERE (xcoordinate, ycoordinate)=(1163069, 1941495);
UPDATE cleaning.crimes3
SET ward = 36
WHERE (xcoordinate, ycoordinate)=(1147025, 1910941);
UPDATE cleaning.crimes3
SET ward = 12
WHERE (xcoordinate, ycoordinate)=(1155361, 1886557);
UPDATE cleaning.crimes3
SET ward = 20
WHERE (xcoordinate, ycoordinate)=(1175476, 1873816);
UPDATE cleaning.crimes3
SET beat = 2424
WHERE (xcoordinate, ycoordinate)=(1160660, 1948887);
UPDATE cleaning.crimes3
SET beat = 1924
WHERE (xcoordinate, ycoordinate)=(1170360, 1921560);
UPDATE cleaning.crimes3
SET beat = 1112
WHERE (xcoordinate, ycoordinate)=(1151394, 1907743);

DROP TABLE IF EXISTS cleaning.location;
CREATE TABLE cleaning.location(
    id                   bigserial PRIMARY KEY,
    direccion            varchar(100) NOT NULL,
    beat                 smallint NOT NULL,
    ward                 smallint NOT NULL,
    xcoordinate          integer,
    ycoordinate          integer,
    latitude             numeric,
    longitude            numeric

);
DROP INDEX IF EXISTS cleaning.location_index;
CREATE INDEX IF NOT EXISTS location_index ON cleaning.location USING BTREE (id);
INSERT INTO cleaning.location (direccion, beat, ward, xcoordinate, ycoordinate, latitude, longitude)
SELECT  DISTINCT direccion,  beat, ward, xcoordinate, ycoordinate, latitude, longitude
FROM cleaning.crimes3;

DROP TABLE IF EXISTS cleaning.type_location;
CREATE TABLE cleaning.type_location(
    id smallserial PRIMARY KEY ,
    location_description  varchar(100)
);
DROP INDEX IF EXISTS cleaning.type_location_index;
CREATE INDEX type_location_index ON cleaning.type_location USING BTREE (id);
INSERT INTO cleaning.type_location(location_description)
SELECT  DISTINCT locationdescription
FROM cleaning.crimes3;

DROP TABLE IF EXISTS cleaning.crimesLimpia;
CREATE TABLE cleaning.crimesLimpia(
    id                   bigserial PRIMARY KEY,
    caseNumber            varchar(10),
    fecha                timestamp,
    icur                 varchar(4) REFERENCES cleaning.icur(icur),
    arrest               varchar(1) NOT NULL,
    domestic             varchar(1) NOT NULL,
    id_location          bigint REFERENCES cleaning.location ON DELETE CASCADE ON UPDATE CASCADE,
    id_type_location      smallint REFERENCES cleaning.type_location ON DELETE CASCADE ON UPDATE CASCADE
);
DROP INDEX IF EXISTS cleaning.limpia_index;
CREATE INDEX IF NOT EXISTS limpia_index ON cleaning.crimesLimpia USING BTREE (id);
WITH crimes_con_idExt AS(
    SELECT cleaning.crimes3.*, L.id AS idLoc, TP.id AS idTypeLoc
    FROM cleaning.crimes3
    INNER JOIN cleaning.location AS L ON cleaning.crimes3.beat = L.beat
    AND cleaning.crimes3.ward = L.ward
    AND cleaning.crimes3.xcoordinate = L.xcoordinate
    AND cleaning.crimes3.ycoordinate = L.ycoordinate
    AND cleaning.crimes3.direccion = L.direccion
    INNER JOIN cleaning.type_location AS TP ON cleaning.crimes3.locationdescription = TP.location_description
)
INSERT INTO cleaning.crimesLimpia(caseNumber, fecha, icur, arrest, domestic, id_location, id_type_location)
SELECT  DISTINCT id, cast(fecha as timestamp), icur, arrest, domestic, idLoc, idTypeLoc
FROM crimes_con_idExt;
DROP TABLE IF EXISTS cleaning.crimes3;
