# Scientific Discoveries Database

This project contains a PostgreSQL database designed to store and query information about prominent scientists and their notable discoveries. It provides a structured way to explore scientific achievements across different fields, countries, and time periods.  

---

## Database Structure

The database `scientific_discoveries` has two main tables:

### `scientists`
Stores information about scientists.  

| Column       | Type        | Description         |
| ------------ | ----------- | ------------------- |
| scientist_id | SERIAL      | Primary key         |
| name         | VARCHAR(50) | Scientist's name    |
| field        | VARCHAR(50) | Scientific field    |
| country      | VARCHAR(50) | Scientist's country |

### `discoveries`
Stores information about scientific discoveries.  

| Column       | Type         | Description                            |
| ------------ | ------------ | -------------------------------------- |
| discovery_id | SERIAL       | Primary key                            |
| title        | VARCHAR(150) | Name of the discovery                  |
| scientist_id | INT          | Foreign key referencing `scientists`   |
| year         | INT          | Year of the discovery                  |
| impact_score | INT          | Score representing impact/significance |

---

## Setup Instructions

1. **Create the database:**  
```sql
CREATE DATABASE scientific_discoveries;
```

2. **Create tables:**
- Run the SQL commands in `table.sql`.

3. **Insert sample data:**
- Run the commands in `insert.sql` to populate scientists and discoveries.

4. **Run queries:**
- Use `queries.sql` to explore the data. Subqueries are included in `subqueries.sql`.

---

## SQL Scripts

- `db.sql` – Creates the database.
- `table.sql` – Defines tables and relationships.
- `insert.sql` – Inserts sample data for scientists and discoveries.
- `queries.sql` – Common queries to retrieve and analyze data.
- `subqueries.sql` – Advanced queries using subqueries.

