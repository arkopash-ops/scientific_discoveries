-- Table for storing information about scientists
CREATE TABLE scientists (
    scientist_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    field VARCHAR(50),
    country VARCHAR(50)
);


-- Table for storing information about discoveries
CREATE TABLE discoveries (
    discovery_id SERIAL PRIMARY KEY,
    title VARCHAR(150),
    scientist_id INT,
    year INT,
    impact_score INT,
    FOREIGN KEY (scientist_id) REFERENCES scientists(scientist_id)
);
