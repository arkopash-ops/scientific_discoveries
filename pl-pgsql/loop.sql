-- 1. Write a loop to print all scientist names one by one.

CREATE OR REPLACE FUNCTION print_scientists()
RETURNS void
AS $$
DECLARE
    scientist_name TEXT;
BEGIN
    FOR scientist_name IN SELECT name FROM scientists LOOP
        RAISE NOTICE '%', scientist_name;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- 2. Create a loop that exits when a scientist with field = 'Biology' is found.

CREATE OR REPLACE FUNCTION find_biologist()
RETURNS void
AS $$
DECLARE
    sci RECORD;
BEGIN
    FOR sci IN SELECT * FROM scientists LOOP
        IF sci.field = 'Biology' THEN
            RAISE NOTICE 'Found a biologist: %', sci.name;
            EXIT;
        END IF;
        RAISE NOTICE 'Checked scientist: %', sci.name;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- 3. Write a FOR loop to display all discoveries with impact_score > 90.

CREATE OR REPLACE FUNCTION print_high_impact_discoveries()
RETURNS void
AS $$
DECLARE
    disc RECORD;
BEGIN
    FOR disc IN
        SELECT title, impact_score FROM discoveries WHERE impact_score > 90
    LOOP
        RAISE NOTICE 'Discovery: %, Impact Score: %', disc.title, disc.impact_score;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- 4. Create a function that loops through all scientists and counts discoveries. Use FOR loop.

CREATE OR REPLACE FUNCTION count_discoveries_per_scientist()
RETURNS void
AS $$
DECLARE
    sci RECORD;
    discovery_count INT;
BEGIN
    FOR sci IN SELECT * FROM scientists LOOP
        SELECT COUNT(*) INTO discovery_count
        FROM discoveries
        WHERE scientist_id = sci.scientist_id;

        RAISE NOTICE 'Scientist: %, Discoveries: %', sci.name, discovery_count;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- 5. Use FOR loop to print discoveries between two years.

CREATE OR REPLACE FUNCTION print_discoveries_between_years(start_year INT, end_year INT)
RETURNS void
AS $$
DECLARE
    disc RECORD;
BEGIN
    FOR disc IN 
        SELECT * 
        FROM discoveries 
        WHERE year BETWEEN start_year AND end_year
        ORDER BY year
    LOOP
        RAISE NOTICE 'Discovery: %, Scientist ID: %, Year: %, Impact: %', 
                     disc.title, disc.scientist_id, disc.year, disc.impact_score;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- 6. Write a WHILE loop to fetch scientists one by one using a counter.

CREATE OR REPLACE FUNCTION fetch_scientists_while()
RETURNS void
AS $$
DECLARE
    counter INT := 1;
    total_scientists INT;
    sci_name TEXT;
BEGIN
    SELECT COUNT(*) INTO total_scientists FROM scientists;

    WHILE counter <= total_scientists LOOP
        SELECT name INTO sci_name
        FROM scientists
        ORDER BY scientist_id
        LIMIT 1 OFFSET counter - 1;

        RAISE NOTICE 'Scientist %: %', counter, sci_name;

        counter := counter + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- 7. Create a function that loops until total discoveries exceed 10. Use WHILE loop.

CREATE OR REPLACE FUNCTION loop_until_discoveries_exceed_10()
RETURNS void
AS $$
DECLARE
    counter INT := 0;
    idx INT := 0;
    total_discoveries INT;
    disc_title TEXT;
BEGIN
    SELECT COUNT(*) INTO total_discoveries FROM discoveries;

    WHILE counter <= 10 AND idx < total_discoveries LOOP
        idx := idx + 1;

        SELECT title INTO disc_title
        FROM discoveries
        ORDER BY discovery_id
        LIMIT 1 OFFSET idx - 1;

        counter := counter + 1;

        RAISE NOTICE 'Discovery %: % (Total counted: %)', idx, disc_title, counter;
    END LOOP;

    RAISE NOTICE 'Loop ended. Total discoveries counted: %', counter;
END;
$$ LANGUAGE plpgsql;

-- 8. Write a loop:
--     Skip discoveries with impact_score < 85 (CONTINUE)
--     Stop when impact_score > 95 (EXIT)

CREATE OR REPLACE FUNCTION loop_with_continue_exit()
RETURNS void
AS $$
DECLARE
    disc RECORD;
BEGIN
    FOR disc IN SELECT * FROM discoveries ORDER BY discovery_id LOOP

        IF disc.impact_score < 85 THEN
            CONTINUE;
        END IF;

        IF disc.impact_score > 95 THEN
            RAISE NOTICE 'Stopping loop: discovery % has impact_score %', disc.title, disc.impact_score;
            EXIT;
        END IF;

        RAISE NOTICE 'Discovery: %, Impact Score: %', disc.title, disc.impact_score;

    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- 9. Simulate a do-while loop:
--     Print discoveries until year > 1950.

CREATE OR REPLACE FUNCTION do_while_discoveries()
RETURNS void
AS $$
DECLARE
    idx INT := 0;
    total_discoveries INT;
    disc RECORD;
BEGIN
    SELECT COUNT(*) INTO total_discoveries FROM discoveries;

    LOOP
        idx := idx + 1;

        SELECT * INTO disc
        FROM discoveries
        ORDER BY discovery_id
        LIMIT 1 OFFSET idx - 1;

        IF NOT FOUND THEN
            EXIT;
        END IF;

        RAISE NOTICE 'Discovery: %, Year: %, Impact: %', disc.title, disc.year, disc.impact_score;

        EXIT WHEN disc.year > 1950;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
