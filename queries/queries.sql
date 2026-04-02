-- 01. List all scientists

SELECT * FROM scientists;


-- 02. List all discoveries

SELECT * FROM discoveries;


-- 03. Find all discoveries made in 1905

SELECT *
FROM discoveries
WHERE year = 1905;


-- 04. Find all scientists from India

SELECT * 
FROM scientists
WHERE country = 'India';


-- 05. List all discoveries along with scientist names

SELECT 
    d.discovery_id,
    d.title,
    s.name AS scientist_name,
    d.year,
    d.impact_score
FROM discoveries d
JOIN scientists s ON d.scientist_id = s.scientist_id;


-- 06. Find all discoveries with impact_score greater than 90

SELECT 
    d.title,
    s.name AS scientist_name,
    d.impact_score
FROM discoveries d
JOIN scientists s ON d.scientist_id = s.scientist_id
WHERE d.impact_score > 90;


-- 07. Count discoveries per scientist

SELECT 
    s.name,
    COUNT(d.discovery_id) AS total_discoveries
FROM scientists s
LEFT JOIN discoveries d ON s.scientist_id = d.scientist_id
GROUP BY s.name;


-- 08. Top 3 discoveries by impact_score

SELECT 
    d.title,
    s.name AS scientist_name,
    d.impact_score
FROM discoveries d
JOIN scientists s ON d.scientist_id = s.scientist_id
ORDER BY impact_score DESC
LIMIT 3;


-- 09. Average impact score per scientist

SELECT 
    s.name,
    ROUND(AVG(d.impact_score)) AS average_impact_score
FROM scientists s
LEFT JOIN discoveries d ON s.scientist_id = d.scientist_id
GROUP BY s.name;


-- 10. Scientists with more than 3 discoveries

SELECT 
    s.name,
    COUNT(d.discovery_id) AS total_discoveries
FROM scientists s
JOIN discoveries d ON s.scientist_id = d.scientist_id
GROUP BY s.scientist_id, s.name
HAVING COUNT(d.discovery_id) > 3;


-- 11. Scientists who discovered something in the 19th century (1800-1899)

SELECT DISTINCT s.name
FROM scientists s
JOIN discoveries d ON s.scientist_id = d.scientist_id
WHERE d.year BETWEEN 1800 AND 1899;


-- 12. Average impact score by field
SELECT 
    s.field,
    ROUND(AVG(d.impact_score)) AS average_impact_score
FROM scientists s
LEFT JOIN discoveries d ON s.scientist_id = d.scientist_id
GROUP BY s.field;
