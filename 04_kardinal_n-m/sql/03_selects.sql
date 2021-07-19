-- 03. SELECTS

USE mydb;

-- Einzeltabellen

SELECT * FROM cats;
SELECT * FROM servants;
SELECT * FROM products;
SELECT * FROM purchases;
/*
-- Inner Join 1 / Kombi (servants / products / purchases)
SELECT
	concat(servant_name," kauft ",product_name," für ",product_price, "€.") 
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
;

-- Welche Artikel hat Georg gekauft?
SELECT
	concat(servant_name," kauft ",product_name," für ",product_price, "€.") AS "gekaufte Artikel"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servant_name = "Georg"
;
*/
-- Wieviel Produkte hat Georg gekauft?
/*SELECT
	servant_name,
	COUNT(product_name)
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servant_name = "Georg"
;*/
/*SELECT
	CONCAT(servant_name," hat ",COUNT(product_name)," Produkte gekauft.") AS Kaufmenge
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servant_name = "Georg"
;*/

-- Wieviel Geld hat Georg ausgegeben?
/*SELECT
	servant_name,
    SUM(product_price)
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servant_name = "Georg"
;*/

/*SELECT
	CONCAT(
		servant_name,
		" hat Produkte im Wert von ",
		SUM(product_price),
		"€ gekauft."
        ) AS Gesamtsumme
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servant_name = "Georg"
;

-- Alles zusammen (Kaufmenge und Gsamtpreis)
SELECT
	CONCAT(
		servant_name,
		" hat ",
		COUNT(product_name),
		" Produkte für ",
		SUM(product_price),
		"€ gekauft."
        ) AS "Käufer, Kaufmenge und Gesamtpreis"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servant_name = "Georg"
;*/


-- Kombi Aggregiert / Nicht-Aggregiert
/*
SELECT
	servant_name AS "Diener",
	#count(servant_name) AS "Artikelzahl"
    sum(product_price) AS "Gesamtpreis"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY servant_name
HAVING servant_name = "Georg"
#WHERE servant_name = "Georg"
;
*/
/*
SELECT
	servant_name AS "Diener",
	count(servant_name) AS "Artikelzahl"
    #sum(product_price) AS "Gesamtpreis"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
#GROUP BY servant_name
#HAVING servant_name = "Georg"
WHERE servant_name = "Georg"
;
*/
/*
-- Wer hat das Produkt X gekauft?
-- Irgendwas mit Lachs / irgendwas mit Soße | LIKE
SELECT
	concat(servant_name," hat ",product_name," für ",product_price,"€ gekauft.") AS "Käufer, Produkt, Kaufpreis"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE product_name LIKE "%Lachs" OR product_name LIKE "%Soße"
#WHERE servant_name = "Georg"
;

-- Wie oft wurde das Produkt X gekauft
SELECT
	product_name AS "Produkt",  # organisch
    count(product_name) AS "Anzahl"  # aggregiert
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY product_name
#HAVING product_name LIKE "%Huhn%"
ORDER BY "Anzahl" DESC
#WHERE product_name LIKE "%Lachs" OR product_name LIKE "%Soße"
#WHERE servant_name = "Georg"
;

-- Welche Umsäte hatte Produkt X?
-- Variante 1: "SUM"
SELECT
	product_name AS "Produkt",  # organisch
    sum(product_price) AS "Umsatz"  # aggregiert
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY product_name
#HAVING product_name LIKE "%Huhn%"
ORDER BY sum(product_price) DESC
#WHERE product_name LIKE "%Lachs" OR product_name LIKE "%Soße"
#WHERE servant_name = "Georg"
;

-- Variante 2a: Peter Schmidt
SELECT
	product_name AS Produkt,
    product_price AS Preis,
    count(product_name) AS "Menge",
    count(product_name) * product_price AS Umsatz
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY Produkt,Preis
ORDER BY Umsatz DESC
;
*/
/*
-- Variante 2b: Peter Schmidt | Berechnung mit tmp-Tabelle
DROP TABLE IF EXISTS tmp;
CREATE TABLE tmp
(
	product_name VARCHAR(45) NOT NULL,
    product_price DECIMAL(4,2) NOT NULL,
    anzahl INT NOT NULL
);

-- tmp: Struktur
DESCRIBE tmp;

-- Daten aus SELECT in Tabelle tmp
INSERT INTO tmp
SELECT
	product_name AS Produkt,
    product_price AS Preis,
    count(product_name) AS Anzahl
FROM purchases 
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY product_name,product_price
;

-- tmp: Inhalte
SELECT * FROM tmp;

-- Berechnung Umsätze
SELECT
	product_name AS Produkt,
    product_price AS Preis,
	Anzahl,
    Anzahl * product_price AS Umsatz
FROM tmp
ORDER BY Umsatz DESC;
*/

-- Wer bekommt den Lachs?
-- Ansatz: Produkt --> Diener : cats_id --> cats: Namen
SELECT
	concat(servant_name," kauft ",product_name," für ",cat_name," zum Preis von ",product_price,"€.") AS "Welche Katze bekommt welches Futter?"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
INNER JOIN cats ON cats.id = servants.cats_id
WHERE product_name LIKE "%Lacha%" #OR product_name LIKE "%Soße%"
;
