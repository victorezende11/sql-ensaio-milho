-- =====================================================================
-- Pipeline de análise de ensaio de milho no Databricks (dados simulados)
-- Arquitetura medalhão: bronze -> prata -> ouro
--   Bronze: workspace.default.ensaio_vcu (dados brutos, como chegaram)
--   Prata:  dados validados, com produtividade em t/ha
--   Ouro:   médias por híbrido x local e % da testemunha
-- =====================================================================

-- Camada prata: remove parcelas sem produtividade e cria a coluna em t/ha
CREATE OR REPLACE TABLE workspace.default.prata_ensaio AS
SELECT *, prod_kg_ha / 1000 AS prod_t_ha
FROM workspace.default.ensaio_vcu
WHERE prod_kg_ha IS NOT NULL;

-- Camada ouro: produtividade de cada híbrido em % da testemunha, por local
CREATE OR REPLACE TABLE workspace.default.ouro_medias AS
WITH medias AS (            -- média de cada híbrido em cada local
  SELECT hibrido, local, AVG(prod_t_ha) AS media_hibrido
  FROM workspace.default.prata_ensaio
  GROUP BY hibrido, local
),
test AS (                   -- média da testemunha em cada local
  SELECT local, AVG(prod_t_ha) AS media_testemunha
  FROM workspace.default.prata_ensaio
  WHERE hibrido = 'TESTEMUNHA'
  GROUP BY local
)
SELECT m.hibrido, m.local,
       ROUND(100 * m.media_hibrido / t.media_testemunha, 1) AS YLDCK
FROM medias AS m
JOIN test AS t ON m.local = t.local;

-- Vantagem sobre a testemunha (base do gráfico de barras)
CREATE OR REPLACE TABLE workspace.default.ouro_vantagem AS
SELECT hibrido, local,
       CONCAT(hibrido, ' · ', local) AS hibrido_local,
       ROUND(YLDCK - 100, 1) AS vantagem_pct
FROM workspace.default.ouro_medias
WHERE hibrido != 'TESTEMUNHA';

-- Histórico de versões da tabela ouro (Delta Lake)
DESCRIBE HISTORY workspace.default.ouro_medias;