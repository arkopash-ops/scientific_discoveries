-- 1. Write a function to display all scientists.

CREATE OR REPLACE FUNCTION get_all_scientists()
RETURNS TABLE (
    scientist_id INT,
    name VARCHAR,
    field VARCHAR,
    country VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM scientists;
END;
$$ LANGUAGE plpgsql;


-- 2. Create a function to return the total number of scientists.

CREATE OR REPLACE FUNCTION count_scientists()
RETURNS INT 
AS $$
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM scientists
    );
END;
$$ LANGUAGE plpgsql;


-- 3. Write a function that takes scientist_id and returns their name.

CREATE OR REPLACE FUNCTION get_scientist_name(s_id INT)
RETURNS VARCHAR
AS $$
BEGIN
    RETURN (
        SELECT name
        FROM scientists
        WHERE scientist_id = s_id
    );
END;
$$ LANGUAGE plpgsql;


-- 4. Create a function to list all discoveries made after a given year.

CREATE OR REPLACE FUNCTION get_discoveries(y INT)
RETURNS  TABLE (
    title VARCHAR,
    scientist_name VARCHAR,
    year INT
) AS $$
BEGIN
    return query
    SELECT 
        d.title AS title,
        s.name AS scientist_name,
        d.year As year
    FROM discoveries d
    JOIN scientists s ON d.scientist_id = s.scientist_id
    WHERE d.year > y
    ORDER BY d.year;
END;
$$ LANGUAGE plpgsql;


-- 5. Write a function to calculate the average impact_score.

CREATE OR REPLACE FUNCTION average_impact()
RETURNS INT
AS $$
BEGIN
    RETURN (
        SELECT ROUND(AVG(impact_score))
        FROM discoveries
    );
END;
$$ LANGUAGE plpgsql;
