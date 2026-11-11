COME 381 - Assignment 2

Project

University Club Management System

Description

This assignment extends the database created in Assignment 1. It adds integrity constraints, sample data, invalid-data tests, an ON DELETE policy, and relational algebra queries with their SQL equivalents.

Files

* constraints.sql: Adds NOT NULL, UNIQUE, and CHECK constraints.
* seed.sql: Inserts sample students, clubs, memberships, events, and registrations.
* violations.sql: Contains 10 tests that attempt to insert invalid data.
* violations_output.txt: Output showing that invalid data was rejected.
* on_delete.md: Explains the selected ON DELETE policy.
* algebra.md: Contains six relational algebra queries.
* algebra.sql: Contains the SQL equivalents of the six queries.

Database Setup

The database used for this assignment is PostgreSQL.

Run the SQL files in this order:

1. Run the Assignment 1 schema (sql/schema.sql) if the database has not been created yet.
2. Run week-05/constraints.sql.
3. Run week-05/seed.sql.
4. Run week-05/violations.sql to test the constraints.
5. Run week-05/algebra.sql to execute the relational algebra query equivalents.

Testing

The 10 invalid-data tests were executed against PostgreSQL. Each test was rejected by the expected database constraint.

ON DELETE Policy

The database uses the default NO ACTION behavior for foreign key relationships to prevent accidental deletion of referenced records.