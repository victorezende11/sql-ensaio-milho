-- !preview conn=DBI::dbConnect(RSQLite::SQLite())

-- Produtividade média de cada híbrido, do mais para o menos produtivo
SELECT hibrido, AVG(prod_kg_ha) AS media_prod
FROM ensaio_vcu
GROUP BY hibrido
ORDER BY media_prod DESC;

--Para cada local, mostre a diferença entre a parcela mais produtiva e a menos produtiva. 
SELECT local, MAX(prod_kg_ha) - MIN(prod_kg_ha) AS amplitude
FROM ensaio_vcu   
GROUP BY local
ORDER BY amplitude

-- Mostre os 3 híbridos mais produtivos em Sorriso, com o tipo de grão e a produtividade média, do primeiro para o terceiro.
SELECT e.hibrido, h.tipo_grao, AVG(e.prod_kg_ha) AS media_prod
FROM ensaio_vcu AS e
JOIN hibridos AS h ON e.hibrido = h.hibrido
WHERE e.local = 'Sorriso'
GROUP BY e.hibrido, h.tipo_grao
ORDER BY media_prod DESC

-- Mostre os híbridos que tiveram pelo menos 3 parcelas com acamamento de 10% ou mais
SELECT hibrido, COUNT(parcela)
FROM ensaio_vcu
WHERE acamamento >= 10
GROUP BY hibrido

-- Para cada local, qual foi a maior média de produtividade entre os híbridos?
WITH medias AS ( 
SELECT hibrido, local, AVG(prod_kg_ha) AS media
FROM ensaio_vcu
GROUP BY hibrido, local
  )
SELECT local, MAX(media)
FROM medias
GROUP BY local