# Database Schema (DDL)

This directory contains the SQL script that defines the schema for the **Airbnb Clone database**.

## Files

- `schema.sql`: SQL script with `CREATE TABLE` statements, constraints, and indexes.
- `README.md`: Documentation of the schema design.

## Entities & Relationships

- **Users**: Stores user information.
- **Listings**: Represents properties listed by users.
- **Bookings**: Stores booking information linking users and listings.
- **Reviews**: Users can review bookings.

## Constraints

- Primary keys on all tables.
- Foreign keys with `ON DELETE CASCADE`.
- Unique constraint on `users.email`.
- Indexes for email, listing price, and booking dates.

## Usage

Run the following command to create the schema in PostgreSQL:

```bash
psql -U username -d airbnb_db -f schema.sql
```
