-- 1. Discoveries by Einstein

SELECT 
    title,
    year,
    impact_score 
FROM discoveries
WHERE scientist_id = (
    SELECT scientist_id
    FROM scientists
    WHERE name = 'Albert Einstein'
);


-- 2. Scientists who have any discovery with impact_score > 90

SELECT 
    name,
    field
FROM scientists
WHERE scientist_id IN (
    SELECT scientist_id
    FROM discoveries
    WHERE impact_score > 90
);


-- 3. Discoveries with impact_score above average

SELECT 
    title,
    impact_score
FROM discoveries
WHERE impact_score > (
    SELECT AVG(impact_score)
    FROM discoveries
);


-- 4. Scientists with the maximum number of discoveries

SELECT 
    name,
    field
FROM scientists
WHERE scientist_id IN (
    SELECT scientist_id
    FROM discoveries
    GROUP BY scientist_id
    HAVING COUNT(*) = (
        SELECT MAX(total)
        FROM (
            SELECT COUNT(*) AS total
            FROM discoveries
            GROUP BY scientist_id
        ) AS sub
    )
);


-- 5. Scientists with their highest-impact discovery

SELECT 
    s.name,
    d.title,
    d.impact_score
FROM scientists s
JOIN discoveries d ON s.scientist_id = d.scientist_id
WHERE d.impact_score = (
    SELECT MAX(impact_score)
    FROM discoveries
    WHERE scientist_id = s.scientist_id
)
ORDER BY d.impact_score DESC;


-- 6. Highest impact discovery per field

SELECT
    s.name AS scientist_name,
    d.title AS discovery,
    d.impact_score
FROM discoveries d
JOIN scientists s ON d.scientist_id = s.scientist_id
WHERE d.impact_score = (
    SELECT MAX(impact_score)
    FROM discoveries
    WHERE scientist_id IN (
        SELECT scientist_id
        FROM scientists
        WHERE field = s.field
    )
);


-- 7. Scientists whose discoveries are all above 85 impact_score

SELECT name
FROM scientists
WHERE scientist_id NOT IN (
    SELECT scientist_id
    FROM discoveries
    WHERE impact_score <= 85
);


-- 8. Most recent discovery of each scientist

SELECT 
    s.name AS scientist_name,
    d.title AS discovery_title,
    d.year
FROM scientists s
JOIN discoveries d ON s.scientist_id = d.scientist_id
WHERE d.year = (
    SELECT MAX(year)
    FROM discoveries
    WHERE scientist_id = s.scientist_id
);
