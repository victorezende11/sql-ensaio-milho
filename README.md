# sql-ensaio-milho
Consultas SQL para análise de ensaios de milho: médias por híbrido e local, ranking e comparação com a testemunha

# SQL para análise de ensaios de milho

Consultas SQL que respondem perguntas comuns na análise de ensaios de
melhoramento de milho, escritas durante meus estudos de SQL.

## O que tem aqui

- `consultas.sql`: consultas comentadas, cada uma respondendo uma pergunta,
  por exemplo:
  - produtividade média de cada híbrido, do mais para o menos produtivo;
  - médias por híbrido e local (base para olhar a interação G×E);
  - checagem de balanceamento do ensaio (parcelas por híbrido e local);
  - produtividade de cada híbrido em % da testemunha em cada local.

## Dados

As consultas usam três tabelas de um ensaio **simulado** (dados de exemplo,
não são dados reais de nenhuma empresa):

| Tabela | Uma linha por | Principais colunas |
|---|---|---|
| `ensaio_vcu` | parcela | hibrido, local, bloco, prod_kg_ha, umidade, acamamento |
| `locais` | local | estado, altitude_m, chuva_safra_mm |
| `hibridos` | híbrido | ciclo, tipo_grao |

## Conceitos praticados

SELECT, WHERE, GROUP BY, HAVING, ORDER BY, funções de agregação, AS,
WITH (consultas em etapas) e JOIN.
