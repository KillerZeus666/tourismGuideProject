OPTIONS (SKIP=1, DIRECT=TRUE)
LOAD DATA
INFILE 'tempcarga.csv'
BADFILE 'tempcarga.bad'
DISCARDFILE 'tempcarga.dsc'
APPEND
INTO TABLE TempCarga
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  nombreGuia          CHAR(100),
  genero              CHAR(1),
  cedula              INTEGER EXTERNAL,
  nombreCiudad        CHAR(100),
  nombrePais          CHAR(100),
  fecha               DATE "YYYY-MM-DD",
  valorDia            INTEGER EXTERNAL
)
