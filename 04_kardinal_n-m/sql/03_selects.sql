-- 03. SELECTS
USE mydb;

-- Einzeltabellen

SELECT * FROM cats;
SELECT * FROM servants;
SELECT * FROM products;
SELECT * FROM purchases;

-- Inner Join 1 / Kombi (servants / products / purchases)
SELECT
	*
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
;

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
		) AS Produktzahl
FROM purchases
INNER JOIN servants ON servants.id = purchases.servants_id
INNER JOIN products ON products.id = purchases.products_id
WHERE servant_name = "Dieter"
;




