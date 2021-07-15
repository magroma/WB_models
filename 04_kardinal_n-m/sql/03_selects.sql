-- 03. SELECTS
USE mydb;

/*
-- Einzeltabellen

SELECT * FROM cats;
SELECT * FROM servants;
SELECT * FROM products;
SELECT * FROM purchases;
*/

-- Inner Join 1 / Kombi (servants / products / purchases)
SELECT
	*
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
;

/*
-- Welche Artikel hat Dieter gekauft?
SELECT
	#servant_name AS "Diener"
    #servant_name AS Diener -- Variante 1
    #servant_name  Diener -- Variante 2
    #product_name AS "Von Dieter gekaufte Artikel"
    concat(servant_name, " kauft ", product_name, ".") AS "Kaufhandlung"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
#WHERE servant_name = "Dieter"
WHERE servant_name = "Peter"
#WHERE servants_id = 2
;

-- Wieviel Produkte hat Dieter gekauft?
-- Wieviel Geld hat Dieter ausgegeben?

-- Variante Christine
SELECT
concat	(
		servant_name, 
        " hat ", 
		count(product_name), 
		" Produkte gekauft und insgesamt EURO ", 
		sum(product_price), " ausgegeben." 
		) AS "Dieters Einkäufe"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servant_name = "Dieter"
;

-- Variante Jan
SELECT
	CONCAT(
			servant_name, 
            " kauft ", 
            COUNT(product_name), 
            " Produkte."
            ) AS "Kaufhandlung"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servant_name ="Dieter";

-- Kombi Aggregiert / Nicht Aggregiert
SELECT
	servant_name AS "Diener",
    count(servant_name) AS "Artikelanzahl",
    sum(product_price) AS "Gesamtkosten"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY servant_name
HAVING servant_name = "Dieter"
#WHERE servant_name = "Dieter"
;


-- Wer hat das Produkt X gekauft?  
-- Irgendwas mit Lachs / Irgendwas mit Sauce LIKE
-- Spalten --> Diener / Produkt
-- Variante Jan
SELECT
	servant_name AS "DIENER",
	product_name AS "Produkte mit Soße oder Lachs"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE product_name LIKE "%Lachs%" OR product_name LIKE "%Sauce%";

-- Wie oft wurde das Produkt X gekauft?
SELECT
	product_name AS "Produkt", # organisch / nicht aggregiert
    count(product_name) AS "Anzahl" #aggregiert
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY product_name
ORDER BY count(product_name) DESC
;

-- Welche Umsätze hatte das Produkt X?
-- Variante 1: Sven
SELECT
	product_name AS Produkt,
	count(product_name) AS "Wie häufig wurde das Produkt gekauft",
	sum(product_price) AS " Umsätze des Produktes"
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY product_name
ORDER BY sum(product_price) DESC
;
*/
-- Lösung A: Berechnung in gleicher Tabelle
SELECT
	product_name AS Produkt,
    product_price AS Preis,
    count(product_name) AS Anzahl,
    count(product_name) * product_price AS Umsatz
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
GROUP BY Produkt,Preis
ORDER BY Umsatz DESC
;

-- Lösung B: Berechnung mit tmp-Tabelle
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

-- Wer bekommt den Lachs?
-- Ansatz: Produkt --> Diener : cats_id --> cats: Namen
