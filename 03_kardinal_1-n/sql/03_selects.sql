-- 03. SELECTS

-- EINzeltabellen
SELECT * FROM cats;
SELECT * FROM kittens;

-- Inner Join 1 / Gesamte Kombi-Tabelle
SELECT
	*
FROM cats INNER JOIN kittens
ON cats.id = kittens.cats_id
;

-- Inner Join 2 / Verwandtschaft
-- "X ist die Mutter von Y"
SELECT
	cat_name AS Mutter,
    kitten_name AS Kind,
    CONCAT(cat_name, " ist die Mutter von ", kitten_name) AS Verwandtschaft
FROM cats INNER JOIN kittens
ON cats.id = kittens.cats_id
;

-- Inner Join 3 / Wieviele Kinder haben die Katzen
SELECT
	cat_name AS Katze,
    COUNT(cat_name) AS Kinderzahl
FROM cats INNER JOIN kittens
ON cats.id = kittens.cats_id
GROUP BY cat_name  # WICHTIG bei Kombination Aggr./Nicht-Aggr.
;