-- 1. Write a function that checks if a given scientist has any discoveries.

CREATE OR REPLACE FUNCTION has_discoveries(s_id INT)
RETURNS TEXT
AS $$
DECLARE
    discovery_count INT;
BEGIN
    SELECT COUNT(*) INTO discovery_count
    FROM discoveries
    WHERE scientist_id = s_id;

    IF discovery_count > 0 THEN
        RETURN 'Scientist has ' || discovery_count || ' discoveries.';
    ELSE
        RETURN 'Scientist has no discoveries.';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- 2. Create a function to check if a scientist’s average discovery impact_score is greater than 90.

CREATE OR REPLACE FUNCTION check_impact_score(s_id INT)
RETURNS TEXT
AS $$
DECLARE
    score INT;
BEGIN
    SELECT ROUND(AVG(impact_score))
    INTO score
    FROM discoveries
    WHERE scientist_id = s_id;

    IF score IS NULL THEN
        RETURN 'No discoveries - No Score';
    ELSIF score > 90 THEN
        RETURN 'Score is '|| score || E'\n' ||'High Impact';
    ELSE
        RETURN 'Score is '|| score || E'\n' ||' - Moderate Impact';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- 3. Write a function that takes impact_score and:
--     Returns 'High Impact' if > 90
--     Else returns 'Moderate/Low Impact'


CREATE OR REPLACE FUNCTION classify_impact(score NUMERIC)
RETURNS TEXT
AS $$
BEGIN
    IF score > 90 THEN
        RETURN 'High Impact';
    ELSE
        RETURN 'Moderate/Low Impact';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- 4. Create a function that checks if a scientist is from India or not.
--     Categorize discoveries based on impact_score:
--     90 → "Excellent"
--     80-90 → "Good"
--     < 80 → "Average"

CREATE OR REPLACE FUNCTION scientist_india_impact(s_name TEXT)
RETURNS TEXT
AS $$
DECLARE
    s_country TEXT;
    avg_score NUMERIC;
    msg TEXT;
BEGIN
    SELECT country
    INTO s_country
    FROM scientists
    WHERE name = s_name;

    IF NOT FOUND THEN
        RETURN 'Scientist with Name "' || s_name || '" not found';
    END IF;

    SELECT ROUND(AVG(impact_score))
    INTO avg_score
    FROM discoveries d
    JOIN scientists s ON d.scientist_id = s.scientist_id
    WHERE s.name = s_name;

    IF s_country = 'India' THEN
        msg := s_name || ' is from "India"';
    ELSE
        msg := s_name || ' is not from "India" but from "' || s_country || '"';
    END IF;

    IF avg_score IS NULL THEN
        msg := msg || E'\n' || 'No discoveries';
    ELSIF avg_score >= 90 THEN
        msg := msg || E'\n' || 'Discovery Average Score: ' || avg_score || E'\n' || 'Impact: Excellent';
    ELSIF avg_score >= 80 AND avg_score < 90 THEN
        msg := msg || E'\n' || 'Discovery Average Score: ' || avg_score || E'\n' || 'Impact: Good';
    ELSE
        msg := msg || E'\n' || 'Discovery Average Score: ' || avg_score || E'\n' || 'Impact: Average';
    END IF;

    RETURN msg;
END;
$$ LANGUAGE plpgsql;


-- 5. Write a function that classifies scientists by number of discoveries:
--     3 → "Highly Active"
--     2-3 → "Moderately Active"
--     < 2 → "Less Active"

CREATE OR REPLACE FUNCTION classify_scientist_activity(s_name TEXT)
RETURNS TEXT
AS $$
DECLARE
    discovery_count INT;
    msg TEXT;
BEGIN
    SELECT COUNT(*)
    INTO discovery_count
    FROM discoveries d
    JOIN scientists s ON d.scientist_id = s.scientist_id
    WHERE s.name = s_name;

    IF NOT FOUND THEN
        RETURN 'Scientist "' || s_name || '" not found';
    END IF;

    IF discovery_count >= 3 THEN
        msg := s_name || E'\n' || 'Discoveries: ' || discovery_count || E'\n' ||'is Highly Active';
    ELSIF discovery_count = 2 THEN
        msg := s_name || E'\n' || 'Discoveries: ' || discovery_count || E'\n' ||'is Moderately Active';
    ELSIF discovery_count = 1 THEN
        msg := s_name || E'\n' || 'Discoveries: ' || discovery_count || E'\n' ||'is Less Active';
    ELSE
        msg := msg || E'\n' || 'No discoveries';
    END IF;

    RETURN msg;
END;
$$ LANGUAGE plpgsql;


-- 6. Write a function:
--     Check if scientist is from India
--         If yes → check if they have discoveries after 1950
--         Return appropriate message

CREATE OR REPLACE FUNCTION check_india_discoveries_after_1950(s_name TEXT)
RETURNS TEXT
AS $$
DECLARE
    s_country TEXT;
    discovery_count INT;
BEGIN
    SELECT country
    INTO s_country
    FROM scientists
    WHERE name = s_name;

    IF NOT FOUND THEN
        RETURN 'Scientist "' || s_name || '" not found';
    END IF;

    IF s_country = 'India' THEN
        SELECT COUNT(*)
        INTO discovery_count
        FROM discoveries d
        JOIN scientists s ON d.scientist_id = s.scientist_id
        WHERE s.name = s_name
            AND d.year > 1950;

        IF discovery_count > 0 THEN
            RETURN s_name || ' is from India and has '|| discovery_count ||' discoveries after 1950.';
        ELSE
            RETURN s_name || ' is from India but has no discoveries after 1950.';
        END IF;
    ELSE
        RETURN s_name || ' is not from India';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- 7. Create a function:
--     If impact_score > 85
--         Check if year > 1900
--             Return "Modern High Impact"
--         Else "Old High Impact"
--     Else "Low Impact"

CREATE OR REPLACE FUNCTION classify_discovery(d_id INT)
RETURNS TEXT
AS $$
DECLARE
    d_score NUMERIC;
    d_year INT;
BEGIN
    SELECT impact_score, year
    INTO d_score, d_year
    FROM discoveries
    WHERE discovery_id = d_id;

    IF NOT FOUND THEN
        RETURN 'Discovery with ID ' || d_id || ' not found';
    END IF;

    IF d_score > 85 THEN
        IF d_year > 1900 THEN
            RETURN 'Modern High Impact';
        ELSE
            RETURN 'Old High Impact';
        END IF;
    ELSE
        RETURN 'Low Impact';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- 8. Write a function using CASE to return field category:
-- Physics → "Core Science"
-- Chemistry → "Core Science"
-- Biology → "Life Science"
-- Others → "Applied Science"

CREATE OR REPLACE FUNCTION get_field_category(s_name TEXT)
RETURNS TEXT
AS $$
DECLARE
    s_field TEXT;
    category TEXT;
BEGIN
    SELECT TRIM(field)
    INTO s_field
    FROM scientists
    WHERE name = s_name;

    IF NOT FOUND THEN
        RETURN 'Scientist "' || s_name || '" not found';
    END IF;

    category := CASE 
        WHEN s_field IN ('Physics', 'Chemistry') THEN 'Core Science'
        WHEN s_field = 'Biology' THEN 'Life Science'
        ELSE 'Applied Science'
    END;

    RETURN s_name || ' works in ' || s_field || E'\n' || 'Category: ' || category;
END;
$$ LANGUAGE plpgsql;


-- 9. Create a function using CASE to map country:
-- India → "Asia"
-- England, Germany → "Europe"
-- USA → "America"
-- Others → "Other Region"

CREATE OR REPLACE FUNCTION map_country_region(s_name TEXT)
RETURNS TEXT
AS $$
DECLARE
    s_country TEXT;
    region TEXT;
BEGIN
    SELECT TRIM(country)
    INTO s_country
    FROM scientists
    WHERE name = s_name;

    IF NOT FOUND THEN
        RETURN 'Scientist "' || s_name || '" not found';
    END IF;

    region := CASE 
        WHEN s_country = 'India' THEN 'Asia'
        WHEN s_country IN ('England', 'Germany') THEN 'Europe'
        WHEN s_country = 'USA' THEN 'America'
        ELSE 'Other Region'
    END;

    RETURN s_name || ' is from ' || s_country || E'\n' || 'Region: ' || region;
END;
$$ LANGUAGE plpgsql;
