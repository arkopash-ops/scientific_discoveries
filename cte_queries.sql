-- 1. Simple CTE to list scientists and their discoveries

WITH scientist_discoveries AS (
    SELECT 
        s.name AS scientist, 
        d.title AS discovery
    FROM scientists s
    JOIN discoveries d ON s.scientist_id = d.scientist_id
)
SELECT *
FROM scientist_discoveries;


-- 2. CTE to calculate total impact per scientist

with impact_per_scientist AS (
    SELECT
        s.name AS scientist,
        SUM(d.impact_score) AS total_impact
    FROM scientists s
    JOIN discoveries d ON s.scientist_id = d.scientist_id
    GROUP BY s.name
)
SELECT *
FROM impact_per_scientist;


-- 3. CTE to find scientists with average impact score over 90

WITH avg_impact AS (
    SELECT
        s.name AS scientist,
        s.field,
        ROUND(AVG(d.impact_score)) AS average_impact
    FROM scientists s
    JOIN discoveries d ON s.scientist_id = d.scientist_id
    GROUP BY s.name, s.field
)
SELECT *
FROM avg_impact
WHERE average_impact > 90;


-- 4. CTE to list discoveries made in the last 100 years

WITH recent_discoveries AS (
    SELECT
        d.title AS discovery,
        s.name AS scientist,
        d.year
    FROM discoveries d
    JOIN scientists s ON d.scientist_id = s.scientist_id
    WHERE d.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 100
)
SELECT * 
FROM recent_discoveries;


-- 5. CTE to find the most impactful discovery for each scientist

WITH max_impact_discoveries AS (
    SELECT
        s.name AS scientist,
        d.title AS discovery,
        d.impact_score
    FROM scientists s
    JOIN discoveries d ON s.scientist_id = d.scientist_id
    WHERE d.impact_score = (
        SELECT MAX(impact_score)
        FROM discoveries
        WHERE scientist_id = s.scientist_id
    )
    ORDER BY s.name
)
SELECT *
FROM max_impact_discoveries
where rank <= 2;


-- 6. CTE chaining - Find scientists with total impact > 200

WITH 
-- Step 1: Calculate total impact per scientist
total_impact AS (
    SELECT 
        scientist_id,
        SUM(impact_score) AS total_score
    FROM discoveries
    GROUP BY scientist_id
),

-- Step 2: Filter only high-impact scientists
filtered_scientists AS (
    SELECT *
    FROM total_impact
    WHERE total_score > 200
)
SELECT s.name, f.total_score
FROM filtered_scientists f
JOIN scientists s ON s.scientist_id = f.scientist_id;
