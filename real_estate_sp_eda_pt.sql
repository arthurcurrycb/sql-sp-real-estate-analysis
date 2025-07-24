-- Entendendo a base de dados (primeiras 5 linhas)

SELECT *
FROM apartamentos_sp
LIMIT 5;


-- Contanto valores nulos

-- Resultado → Não há valores nulos para nenhuma coluna

SELECT 
	COUNT(*) AS total_registros,
	COUNT(*) - COUNT(id) AS id_nulos,
	COUNT(*) - COUNT(created_date) AS created_date_nulos,
	COUNT(*) - COUNT(price) AS price_nulos,
	COUNT(*) - COUNT(below_price) AS below_price_nulos,
	COUNT(*) - COUNT(area) AS area_nulos,
	COUNT(*) - COUNT(adress) AS adress_nulos,
	COUNT(*) - COUNT(bedrooms) AS bedrooms_nulos,
	COUNT(*) - COUNT(bathrooms) AS bathrooms_nulos,
	COUNT(*) - COUNT(parking_spaces) AS parking_spaces_nulos,
	COUNT(*) - COUNT(extract_date) AS extract_date_nulos
FROM apartamentos_sp;


-- Contando o total de apartamentos 

-- Resultado → 27.828 apartamentos

SELECT COUNT(*) AS total_registros
FROM  apartamentos_sp;


-- Entendendo as variáveis (máximo, mínimo e média)


-- Preço

-- Resultado:
--  	max_preco = R$ 122.028.988 
--		min_preco = R$ 100.000,00 
--		avg_preco = 2.037.172,47

SELECT 
	MAX(price) AS max_preco, 
	MIN(price) AS min_preco, 
	ROUND(AVG(price),2) AS avg_preco
FROM apartamentos_sp;

	
-- Tamanho

-- Resultado:
--		max_tamanho = 3.367m²
-- 		min_tamanho = 10m²
--		avg_tamanho = 136,29m² 
	
SELECT
	MAX(area) AS max_tamanho,
	MIN(area) AS min_tamanho,
	ROUND(AVG(area),2) AS avg_tamanho
FROM apartamentos_sp
	
	
-- Número de quartos

-- Resultado:
-- 		max_quartos = 20
-- 		min_quartos = 1
-- 		avg_quartos = 2,74

SELECT
	MAX(bedrooms) AS max_quartos,
	MIN(bedrooms) AS min_quartos,
	ROUND(AVG(bedrooms),2) AS avg_quartos
FROM apartamentos_sp;

	
-- Número de banheiros

-- Resultado: 
-- 		max_banheiros = 20
-- 		min_banheiros = 1
-- 		avg_banheiros = 2,83
	
SELECT
	MAX(bathrooms) AS max_banheiros,
	MIN(bathrooms) AS min_banheiros,
	ROUND(AVG(bathrooms),2) AS avg_banheiros
FROM apartamentos_sp;


-- Vagas de garagem

-- Resultado:
-- 		max_vagas = 350
-- 		min_vagas = 0
--  	avg_vagas = 2,15
	
SELECT
	MAX(parking_spaces) AS max_vagas,
	MIN(parking_spaces) AS min_vagas,
	ROUND(AVG(parking_spaces),2) AS avg_vagas
FROM apartamentos_sp;


/* Calculando o máximo e mínimo das variáveis, percebemos a presença de outliers na base de dados.
 * Para seguir com a análise, vejo que o sensato a fazer é criarmos uma visualização que corte alguns outliers (percentis de 1% e 99%).
 * Para preço e área, faz sentido cortar tanto inferiores (percentil 1%) quanto superiores (percentil 99%).
 * Para número de quartos, banheiros e vagas de garagem, podemos cortar apenas os superiores (percentil 99%)
 * já que é normal ter apenas o valor 1 (quartos e banheiros) ou 0 (vagas de garagem) nessas variáveis.
*/


-- Criando visualização que remove outliers

CREATE OR REPLACE VIEW apartamentos_filtrados AS
WITH limites AS(
	SELECT
		PERCENTILE_CONT(0.01) WITHIN GROUP (ORDER BY price) AS p01_price,
		PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY price) AS p99_price,
		PERCENTILE_CONT(0.01) WITHIN GROUP (ORDER BY area) AS p01_area,
		PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY area) AS p99_area,
		PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY bedrooms) AS p99_bed,
		PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY bathrooms) AS p99_bath,
		PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY parking_spaces) AS p99_vaga
	FROM apartamentos_sp
)
SELECT a.*
FROM apartamentos_sp a
JOIN limites b ON TRUE -- Utilizando JOIN sem condição para adicionar colunas de limite na tabela apartamentos_sp
WHERE -- Excluindo outliers (registros fora dos limites)
	a.price BETWEEN b.p01_price AND b.p99_price AND
	a.area BETWEEN b.p01_area AND b.p99_area AND
	a.bedrooms < b.p99_bed AND
	a.bathrooms < b.p99_bath AND
	a.parking_spaces < b.p99_vaga
ORDER BY a.id;


-- Contando o total de apartamentos pós remoção de outliers

-- Resultado → 21.550 apartamentos

SELECT COUNT(*) AS total_registros
FROM  apartamentos_filtrados;


-- Entendendo as variáveis (máximo, mínimo e média) após a remoção dos outliers


-- Preço

-- Resultado: 
--  	max_preco = R$ 13.000.000 
--		min_preco = R$ 260.000 
--		avg_preco = R$ 1.548.734,63

SELECT 
	MAX(price) AS max_preco, 
	MIN(price) AS min_preco, 
	ROUND(AVG(price),2) AS avg_preco
FROM apartamentos_filtrados;

	
-- Tamanho

-- Resultado:
--		max_tamanho = 452m²
-- 		min_tamanho = 35m²
--		avg_tamanho = 111,90m² 

SELECT
	MAX(area) AS max_tamanho,
	MIN(area) AS min_tamanho,
	ROUND(AVG(area),2) AS avg_tamanho
FROM apartamentos_filtrados
	
	
-- Número de quartos

-- Resultado:
-- 		max_quartos = 3
-- 		min_quartos = 1
-- 		avg_quartos = 2,44
	
SELECT
	MAX(bedrooms) AS max_quartos,
	MIN(bedrooms) AS min_quartos,
	ROUND(AVG(bedrooms),2) AS avg_quartos
FROM apartamentos_filtrados;
	

-- Número de banheiros

-- Resultado:
-- 		max_banheiros = 5
-- 		min_banheiros = 1
-- 		avg_banheiros = 2,52
	
SELECT
	MAX(bathrooms) AS max_banheiros,
	MIN(bathrooms) AS min_banheiros,
	ROUND(AVG(bathrooms),2) AS avg_banheiros
FROM apartamentos_filtrados;

	
-- Vagas de garagem

-- Resultado:
-- 		max_vagas = 5
-- 		min_vagas = 0
--  	avg_vagas = 1,86
	
SELECT
	MAX(parking_spaces) AS max_vagas,
	MIN(parking_spaces) AS min_vagas,
	ROUND(AVG(parking_spaces),2) AS avg_vagas
FROM apartamentos_filtrados;


/* Agora, podemos ver que os números estão mais "sensatos".
 * Acredito que a análise, principalmente utilizando medidas agregadoras como média, rankings, etc. vai ficar mais coerente.
 */


-- Análise bivariada

	
-- Preço médio por número de quartos

-- Resultado:
--  	1 quarto → R$ 1.107.803,78 
-- 		2 quartos → R$ 1.275.497,15
-- 		3 quartos → R$ 1.803.643,61
	
SELECT 
	bedrooms, 
	COUNT(*) AS total_apartamentos,
	ROUND(AVG(price),2) AS avg_preco
FROM apartamentos_filtrados
GROUP BY  bedrooms
ORDER BY  bedrooms;


-- Preço médio por número de banheiros

-- Resultado:
--  	1 banheiro → R$ 835.773,76 
-- 		2 banheiros → R$ 1.117.789,79
-- 		3 banheiros → R$ 1.731.796,21
-- 		4 banheiros → R$ 2.493.335,25
-- 		5 banheiros → R$ 3.226.032,15
	
SELECT 
	bathrooms,
	COUNT(*) AS total_apartamentos,
	ROUND(AVG(price),2) AS avg_preco
FROM apartamentos_filtrados
GROUP BY bathrooms
ORDER BY bathrooms;


-- Preço médio por tamanho (em faixas)

-- Resultado:
-- 		000-050m² → R$ 587.979,83
-- 		051-100m² → R$ 892.627,46
-- 		101-150m² → R$ 1.652.775,67
-- 		151-200m² →	R$ 2.624.935,75
-- 		201-300m² → R$ 3.904.304,59
-- 		301-500m² →	R$ 5.574.109,70

WITH faixa_area AS(
	SELECT
		*,
		CASE
			WHEN area BETWEEN 0 AND 50 THEN '0-50m²'
			WHEN area BETWEEN 51 AND 100 THEN '51-100m²'
			WHEN area BETWEEN 101 AND 150 THEN '101-150m²'
			WHEN area BETWEEN 151 AND 200 THEN '151-200m²'
			WHEN area BETWEEN 201 AND 300 THEN '201-300m²'
			WHEN area BETWEEN 301 AND 500 THEN '301-500m²'
			WHEN area BETWEEN 501 AND 1000 THEN '501-1000m²'
			WHEN area > 1000 THEN '1000+m²'
			ELSE 'Sem área'
		END AS faixa
	FROM apartamentos_filtrados
),
contagem AS(
	SELECT 
		faixa, 
		ROUND(AVG(price), 2) AS avg_preco, 
		COUNT(*) AS total_apartamentos
	FROM faixa_area
	GROUP BY faixa
)
SELECT
	faixa,
	avg_preco,
	total_apartamentos,
	ROUND(100.0 * total_apartamentos / sum(total_apartamentos) OVER (),2) AS percentual_apartamentos
FROM contagem
ORDER BY 
	CASE faixa
		WHEN '0-50m²' THEN 1
		WHEN '51-100m²' THEN 2
		WHEN '101-150m²' THEN 3
		WHEN '151-200m²' THEN 4
		WHEN '201-300m²' THEN 5
		WHEN '301-500m²' THEN 6
		WHEN '501-1000m²' THEN 7
		WHEN '1000+m²' THEN 8
		ELSE 9
	END;


-- Preço médio por vaga de garagem

-- Resultado:
-- 		1 → R$ 913.682,06
-- 		2 → R$ 1.463.829,94
-- 		3 → R$ 2.559.110,25
-- 		4 → R$ 3.785.699,07
-- 		5 →	R$ 4.921.570,19

SELECT
	parking_spaces,
	COUNT(*) AS total_apartamentos,
	ROUND(AVG(price),2) AS avg_preco
FROM apartamentos_filtrados
GROUP BY parking_spaces
ORDER BY parking_spaces;


-- Preço/m² médio

-- Resultado → R$ 13.122,70
	
SELECT
	ROUND(AVG(price / area),2) AS avg_preco_m2
FROM apartamentos_filtrados;
	

-- Preço/m² médio em 2024

-- Resultado → R$ 12.449,21
	
SELECT
	ROUND(AVG(price / area),2) AS avg_preco_m2
FROM apartamentos_filtrados
WHERE created_date >= '2024-01-01';


-- Preço médio e preço/m² médio ano a ano

-- Resultado:
-- 2018 → R$ 1.520.950,40 e R$ 12.853,95/m²
-- 2019 → R$ 1.542.328,36 e	R$ 13.110,41/m²
-- 2020	→ R$ 1.535.589,67 e R$ 13.607,82/m²
-- 2021	→ R$ 1.735.933,49 e R$ 14.665,50/m²
-- 2022	→ R$ 1.700.554,91 e R$ 14.210,74/m²
-- 2023	→ R$ 1.572.073,75 e R$ 13.117,31/m²
-- 2024	→ R$ 1.437.485,65 e R$ 12.449,21/m²

SELECT 
	TO_CHAR(EXTRACT(YEAR FROM created_date), '9999') AS ano,
	COUNT(*) AS total_apartamentos,
	ROUND(AVG(price),2) AS avg_preco,
	ROUND(AVG(price / area),2) AS avg_preco_m2
FROM apartamentos_filtrados
GROUP BY ano
ORDER BY ano;


-- Preço médio e preço por m² médio por mês

-- Resultado:
-- 		Jan → R$ 1.500.979,54 e R$ 13.334,97/m²
-- 		Fev → R$ 1.752.548,14 e R$ 14.729,20/m²
-- 		Mar → R$ 1.507.052,02 e R$ 12.764,97/m²
-- 		Abr → R$ 1.226.662,60 e R$ 11.419,79/m²
-- 		Mai → R$ 1.418.501,62 e R$ 12.321,56/m²
-- 		Jun → R$ 1.575.067,87 e R$ 13.306,22/m²
-- 		Jul → R$ 1.609.329,04 e R$ 13.758,23/m²
-- 		Ago → R$ 1.480.482,31 e	R$ 13.769,99/m²
-- 		Set → R$ 1.703.377,37 e	R$ 14.084,42/m²
--  	Out → R$ 1.608.833,54 e	R$ 13.125,90/m²
-- 		Nov → R$ 1.960.388,41 e	R$ 14.586,66/m²
--		Dez → R$ 1.733.556,41 e R$ 14.748,70/m²
--
-- 		Todos os meses com > 200 registros (boa representatividade estatística)

SELECT
	EXTRACT(MONTH FROM created_date) AS mes,
	COUNT(*) AS total_apartamentos,
	ROUND(AVG(price),2) AS avg_preco,
	ROUND(AVG(price / area),2) AS avg_preco_m2
FROM apartamentos_filtrados
GROUP BY mes
ORDER BY mes;
		

-- Ranquear os apartamentos mais caros dentro de cada faixa de área

-- Resultado:
-- 000-050m² → R$ 2.690.000
-- 051-100m² → R$ 8.480.000
-- 101-150m² → R$ 9.500.001
-- 151-200m² → R$ 10.400.000
-- 201-300m² → R$ 13.000.000
-- 301-500m² → R$ 13.000.000 -- Mesmo preço que da faixa anterior

WITH faixa_area AS(
	SELECT
		*,
		CASE
			WHEN area BETWEEN 0 AND 50 THEN '0-50m²'
			WHEN area BETWEEN 51 AND 100 THEN '51-100m²'
			WHEN area BETWEEN 101 AND 150 THEN '101-150m²'
			WHEN area BETWEEN 151 AND 200 THEN '151-200m²'
			WHEN area BETWEEN 201 AND 300 THEN '201-300m²'
			WHEN area BETWEEN 301 AND 500 THEN '301-500m²'
			WHEN area BETWEEN 501 AND 1000 THEN '501-1000m²'
			WHEN area > 1000 THEN '1000+m²'
			ELSE 'Sem área'
		END AS faixa
	FROM apartamentos_filtrados
),
ranking_faixa AS (
	SELECT
		id,
		area,
		price,
		faixa,
		ROW_NUMBER () OVER(
			PARTITION BY faixa
			ORDER BY price DESC
		) AS ranking_preco
		FROM faixa_area
)
SELECT
	faixa,
	id,
	area,
	price		
	FROM ranking_faixa
	WHERE ranking_preco = 1
	ORDER BY
		CASE faixa
			WHEN '0-50m²' THEN 1
			WHEN '51-100m²' THEN 2
			WHEN '101-150m²' THEN 3
			WHEN '151-200m²' THEN 4
			WHEN '201-300m²' THEN 5
			WHEN '301-500m²' THEN 6
			WHEN '501-1000m²' THEN 7
			WHEN '1000+m²' THEN 8
			ELSE 9
		END;

-- Preço do m² por bairro (ordenado por bairros mais caros e tirando bairros com menos de 3 apartamentos)

-- Resultado:
-- 1º lugar: Ibirapuera → 4 apartamentos, média de R$ 44.218,50/m²
-- 2º lugar: Jardim América → 21 apartamentos, média de	R$ 30.509,38m²
-- 3º lugar: Jardim Panorama → 11 apartamentos, média de R$ 29.900,91m²
-- 4º lugar: Cidade Jardim → 8 apartamentos, média de R$ 28.548,38m²
-- 5º lugar: Jardim Catanduva → 4 apartamentos, média de R$ 27.963,75m²

-- Inicialmente, fiz sem filtrar por total_apartamentos, porém apareceram alguns bairros com apenas 1 apartamento no top 5.
-- Acrescentei o HAVING com total_apartamentos >= 3 justamente para aumentar a representatividade estatística.

WITH apartamentos_filtrados_bairro AS (
	SELECT
		*,
		TRIM(
			CASE
				WHEN adress ILIKE '%,%' THEN SPLIT_PART(SPLIT_PART(adress, ',', 2), '-', 1) 
				ELSE SPLIT_PART(ADRESS, '-', 1)
			END
		) AS bairro
	FROM apartamentos_filtrados
)
SELECT
	bairro,
	COUNT(*) AS total_apartamentos,
	ROUND(AVG(price / area), 2) AS avg_preco_m2
FROM apartamentos_filtrados_bairro
GROUP BY bairro
HAVING COUNT(*) >= 3 -- Filtrar bairros com poucos apartamentos (1 ou 2)
ORDER BY avg_preco_m2 DESC;


-- Preço do m² por bairro (ordenado por bairros mais baratos e tirando bairros com menos de 3 apartamentos)

-- Resultado:
-- 1º lugar: Guapira → 6 apartamentos, média de R$ 3.741,50/m²
-- 2º lugar: Jardim Patente → 4 apartamentos, média de	R$ 4.026,75m²
-- 3º lugar: Jardim Botucatu → 3 apartamentos, média de R$ 4.326,00m²
-- 4º lugar: Vila Cachoeira → 4 apartamentos, média de R$ 4.332,75m²
-- 5º lugar: Jaraguá → 5 apartamentos, média de R$ 4.582,00m²

-- Aqui, também testei sem filtrar e o top 5 consistiu por bairros com apenas 1 apartamento.
-- Acrescentei o HAVING e assim temos um top 5 com maior rpresentatividade estatística. 

WITH apartamentos_filtrados_bairro AS (
	SELECT
		*,
		TRIM(
			CASE
				WHEN adress ILIKE '%,%' THEN SPLIT_PART(SPLIT_PART(adress, ',', 2), '-', 1) 
				ELSE SPLIT_PART(ADRESS, '-', 1)
			END
		) AS bairro
	FROM apartamentos_filtrados
)
SELECT
	bairro,
	COUNT(*) AS total_apartamentos,
	ROUND(AVG(price / area), 2) AS avg_preco_m2
FROM apartamentos_filtrados_bairro
GROUP BY bairro
HAVING COUNT(*) >= 3 -- Filtrar bairros com poucos apartamentos (1 ou 2)
ORDER BY avg_preco_m2 ASC;

-- Tamanho por bairro

WITH apartamentos_filtrados_bairro AS (
	SELECT
		*,
		TRIM(
			CASE
				WHEN adress ILIKE '%,%' THEN SPLIT_PART(SPLIT_PART(adress, ',', 2), '-', 1) 
				ELSE SPLIT_PART(ADRESS, '-', 1)
			END
		) AS bairro
	FROM apartamentos_filtrados
)
SELECT
	bairro,
	COUNT(*) AS total_apartamentos,
	ROUND(AVG(area), 2) AS avg_area
FROM apartamentos_filtrados_bairro
GROUP BY bairro
HAVING COUNT(*) >= 3 -- Filtrar bairros com poucos apartamentos (1 ou 2)
ORDER BY avg_area DESC;


-- Conclusão da análise:

/* 

A análise foi conduzida com base em dados filtrados para remoção de outliers, 
o que possibilitou uma leitura mais fiel da média dos preços praticados em São Paulo.

A média geral de preço absoluto e preço por m² alcançou seu pico em 2021 
(R$ 1.735.933,49 e R$ 14.665,50/m², respectivamente) e está em queda desde então.

Em 2024, esses valores caíram de R$ 1.437.485,65 e R$ 12.449,21/m².
Isso representa uma redução de aproximadamente 18% em relação a 2021.

Também foram notadas variações sazonais: 
os menores preços médios ocorrem em abril e os maiores em fevereiro, novembro e dezembro. 
Essas variações podem refletir ciclos de compra e estratégias de precificação do mercado.

Os bairros mais valorizados, com base no preço médio por metro quadrado, são:
-- 1º lugar: Ibirapuera
-- 2º lugar: Jardim América
-- 3º lugar: Jardim Panorama
-- 4º lugar: Cidade Jardim
-- 5º lugar: Jardim Catanduva

Já os bairros mais acessíveis são:
-- 1º lugar: Guapira
-- 2º lugar: Jardim Patente
-- 3º lugar: Jardim Botucatu
-- 4º lugar: Vila Cachoeira
-- 5º lugar: Jaraguá

Também vale pontuar que o preço médio de apartamentos com < 50m² (frequentemente chamados de "estúdios")
gira em torno de R$ 587.979,83, podendo ultrapassar R$ 2 milhões.

Por fim, a análise reforça o "senso comum" de que quanto maior o número de quartos, banheiros, 
vagas e área total, maiores tendem a ser seus preços.

Como próximos passos, recomenda-se calcular a correlação entre essas variáveis e o preço (variável target),
para quantificar essas relações. 

Além disso, há espaço para evolução com a construção de um modelo preditivo de preços, com base nas variáveis dispoíveis.

*/
