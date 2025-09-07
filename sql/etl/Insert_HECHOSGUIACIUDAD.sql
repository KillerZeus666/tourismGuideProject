SET SERVEROUTPUT ON
DECLARE
  v_rows    NUMBER := 10000;
  v_before  NUMBER;
  v_after   NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_before FROM HECHOSGUIACIUDAD;

  INSERT INTO HECHOSGUIACIUDAD (IDGUIA, IDCIUDAD, IDTIEMPO, VALORDIA)
  SELECT
    /* IDGUIA existente */
    (SELECT idguia FROM (
        SELECT idguia, ROW_NUMBER() OVER (ORDER BY idguia) rn FROM guia
      ) WHERE rn = MOD(ABS(DBMS_RANDOM.RANDOM), (SELECT COUNT(*) FROM guia)) + 1),
    /* IDCIUDAD existente */
    (SELECT idciudad FROM (
        SELECT idciudad, ROW_NUMBER() OVER (ORDER BY idciudad) rn FROM ciudad
      ) WHERE rn = MOD(ABS(DBMS_RANDOM.RANDOM), (SELECT COUNT(*) FROM ciudad)) + 1),
    /* IDTIEMPO existente */
    (SELECT idtiempo FROM (
        SELECT idtiempo, ROW_NUMBER() OVER (ORDER BY idtiempo) rn FROM tiempo
      ) WHERE rn = MOD(ABS(DBMS_RANDOM.RANDOM), (SELECT COUNT(*) FROM tiempo)) + 1),
    ROUND(DBMS_RANDOM.VALUE(0, 500000)) AS valordia
  FROM dual
  CONNECT BY LEVEL <= v_rows;

  COMMIT;

  SELECT COUNT(*) INTO v_after FROM HECHOSGUIACIUDAD;
  DBMS_OUTPUT.PUT_LINE('Filas insertadas en esta corrida: ' || (v_after - v_before));
END;
/
