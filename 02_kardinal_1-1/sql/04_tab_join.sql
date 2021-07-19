-- SELECTS

-- Einzeltabellen
SELECT * FROM mydb.cats;
SELECT * FROM mydb.servants;

-- Kreuzprodukt (Kartesisches Produkt)
/*SELECT * FROM mydb.cats JOIN mydb.servants;
*/
-- Inner Join 1 / Gesammte Tabelle
/*SELECT
	*
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id;
*/
-- Inner Join 2 / ausgewählte Spalten (wer dient wem?)
-- Wer dient Alonzo?
-- Wem dient Kall?
/*SELECT
	cat_name AS Katze,
    servant_name AS Diener
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
#WHERE cat_name = "Alonzo"
WHERE servant_name = "Kall";
*/
-- Inner Join 2a / (wer dient wem?)
-- X ist der Diener von Y
/*
SELECT
	concat(servant_name ," ist der Diener von ", cat_name, ".",max(yrs_served)) AS Dienstverhältnis
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
#WHERE cat_name = "Alonzo"
WHERE cat_name = "Grizabella"
#WHERE servant_name = "Kall"
;*/

-- Inner Join 3 / Dienstzeit
/*
SELECT
	servant_name AS Diener,
    yrs_served AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
ORDER BY yrs_served DESC
;*/
/*
SELECT
MAX(yrs_served) AS "Dienstzeit in Jahren",
CONCAT(servant_name, " der diener von ", cat_name," ist der Diener mit der Längsten Dienstzeit.") AS "Dienstzeit Veteran"
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
;*/

-- Inner Join 4 / Dienstzeit
-- "X - der Diener von Y - ist der Diener mit der längsten Dienstzeit" // MAX()
SELECT
	#MAX(yrs_served) AS "Dienstzeit",
    CONCAT(servant_name, " - der Diener von ", cat_name, " - ist der Diener mit der längsten Dienstzeit.") AS "Dienst"
FROM mydb.cats INNER JOIN mydb.servants
ON cats.id = servants.cats_id
GROUP BY servant_name,cat_name
HAVING yrs_served = (SELECT MAX(yrs_served) FROM mydb.servants)
;
