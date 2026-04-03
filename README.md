# Scientific Discoveries Database

This project contains a PostgreSQL database designed to store and query information about prominent scientists and their notable discoveries. It provides a structured way to explore scientific achievements across different fields, countries, and time periods. The project now also includes PL/pgSQL blocks for procedural logic and advanced database operations.

---

## Folder Structure
```text
ScienceDB/
│
├── schema/
│   ├── db.sql                  # Database creation commands
│   └── table.sql               # Table creation scripts
│
├── data/
│   └── insert.sql              # Insert statements
│
├── queries/
│   ├── queries.sql             # Simple queries
│   ├── cte_queries.sql         # CTE (Common Table Expression) queries
│   └── subquery.sql            # Subqueries
│
├── plpgsql/
│   ├── basic.sql               # Basic PL/pgSQL blocks
│   ├── conditional.sql         # Conditional statements
│   └── loop.sql                # Loop examples
│
└── README.md
```

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
- Run the SQL commands in `schema/table.sql`.

3. **Insert sample data:**
- Run the commands in `data/insert.sql` to populate scientists and discoveries.

4. **Run queries:**
- Use the scripts in the `queries/` folder for queries examples:
    - `queries.sql` - to explore the data.
    - `subqueries.sql` - for queries using subqueries.
    - `cte_queries.sql` - for queries using Common Table Expressions (CTEs).

5. **Run PL/pgSQL blocks:**
- Use the scripts in the `plpgsql/` folder for procedural examples:
    - `basic.sql` – Basic PL/pgSQL block examples.
    - `conditional.sql` – Examples of conditional logic (IF, CASE).
    - `loop.sql` – Examples of loops (FOR, WHILE, DO WHILE) for iterative operations.

---

## SQL Scripts

- `db.sql` – Creates the database.
- `table.sql` – Defines tables and relationships.
- `insert.sql` – Inserts sample data for scientists and discoveries.
- `queries.sql` – Common queries to retrieve and analyze data.
- `subqueries.sql` – Advanced queries using subqueries.
- `cte_queries.sql` – Queries demonstrating Common Table Expressions (CTEs).
- `basic.sql` - Basic PL/pgSQL procedural blocks.
- `conditional.sql` - Conditional logic examples in PL/pgSQL.
- `loop.sql` - Loop examples in PL/pgSQL.
