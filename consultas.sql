-- !preview conn=DBI::dbConnect(RSQLite::SQLite())

-- Produtividade média de cada híbrido, do mais para o menos produtivo
SELECT hibrido, AVG(prod_kg_ha) AS media_prod
FROM ensaio_vcu
GROUP BY hibrido
ORDER BY media_prod DESC;
