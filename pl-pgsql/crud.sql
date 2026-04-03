-- CRUD function for scientist table.

-- INSERT
CREATE OR REPLACE FUNCTION insert_scientist(
    p_name VARCHAR,
    p_field VARCHAR,
    p_country VARCHAR
)
RETURNS VOID 
AS $$
BEGIN
    INSERT INTO scientists(name, field, country)
    VALUES (p_name, p_field, p_country);
END;
$$ LANGUAGE plpgsql;


-- UPDATE
CREATE OR REPLACE FUNCTION update_scientist(
    p_id INT,
    p_name VARCHAR,
    p_field VARCHAR,
    p_country VARCHAR
)
RETURNS VOID 
AS $$
BEGIN
    UPDATE scientists
    SET name = p_name,
        field = p_field,
        country = p_country
    WHERE scientist_id = p_id;
END;
$$ LANGUAGE plpgsql;


-- DELETE
CREATE OR REPLACE FUNCTION delete_scientist(p_id INT)
RETURNS VOID 
AS $$
BEGIN
    DELETE FROM scientists
    WHERE scientist_id = p_id;
END;
$$ LANGUAGE plpgsql;


-- READ
CREATE OR REPLACE FUNCTION read_scientists(p_id INT DEFAULT NULL)
RETURNS TABLE(
    scientist_id INT,
    name VARCHAR,
    field VARCHAR,
    country VARCHAR
) AS $$
BEGIN
    IF p_id IS NULL THEN
        RETURN QUERY SELECT * FROM scientists;
    ELSE
        RETURN QUERY SELECT * FROM scientists WHERE scientist_id = p_id;
    END IF;
END;
$$ LANGUAGE plpgsql;



-- CRUD function for discoveries table.

-- INSERT
CREATE OR REPLACE FUNCTION insert_discovery(
    p_title VARCHAR,
    p_scientist_id INT,
    p_year INT,
    p_impact_score INT
)
RETURNS VOID
AS $$
BEGIN
    INSERT INTO discoveries(title, scientist_id, year, impact_score)
    VALUES (p_title, p_scientist_id, p_year, p_impact_score);
END;
$$ LANGUAGE plpgsql;


-- UPDATE
CREATE OR REPLACE FUNCTION update_discovery(
    p_id INT,
    p_title VARCHAR,
    p_scientist_id INT,
    p_year INT,
    p_impact_score INT
)
RETURNS VOID
AS $$
BEGIN
    UPDATE discoveries
    SET title = p_title,
        scientist_id = p_scientist_id,
        year = p_year,
        impact_score = p_impact_score
    WHERE discovery_id = p_id;
END;
$$ LANGUAGE plpgsql;


-- DELETE
CREATE OR REPLACE FUNCTION delete_discovery(p_id INT)
RETURNS VOID
AS $$
BEGIN
    DELETE FROM discoveries
    WHERE discovery_id = p_id;
END;
$$ LANGUAGE plpgsql;


-- READ
CREATE OR REPLACE FUNCTION read_discoveries(p_id INT DEFAULT NULL)
RETURNS TABLE(
    discovery_id INT,
    title VARCHAR,
    scientist_id INT,
    year INT,
    impact_score INT
) AS $$
BEGIN
    IF p_id IS NULL THEN
        RETURN QUERY SELECT * FROM discoveries;
    ELSE
        RETURN QUERY SELECT * FROM discoveries WHERE discovery_id = p_id;
    END IF;
END;
$$ LANGUAGE plpgsql;
