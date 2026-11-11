AI Usage Log

Purpose

ChatGPT was used as an assistant during the development of the University Club Management System database assignments.

How AI Was Used

* To understand database design concepts, primary keys, and foreign keys.
* To receive guidance while creating SQL table definitions.
* To understand NOT NULL, UNIQUE, and CHECK constraints.
* To prepare sample data for testing the database.
* To develop invalid-data test cases and understand PostgreSQL error messages.
* To understand the NO ACTION deletion policy.
* To prepare relational algebra queries and their SQL equivalents.
* To receive help with organizing project files and using Git.

Verification

SQL statements were executed and tested using PostgreSQL. The database structure, sample data, and constraint violations were checked by the student.

Responsibility

AI was used as a learning and assistance tool. The student reviewed the generated content and executed the SQL commands in the database.


Assignment 2 - AI Usage Log

How AI Was Used

ChatGPT was used to:

* Create and review SQL constraint definitions.
* Prepare test cases for NOT NULL, UNIQUE, CHECK, and FOREIGN KEY constraints.
* Understand PostgreSQL SQLSTATE error codes.
* Explain ON DELETE CASCADE and RESTRICT behavior.
* Develop relational algebra expressions and their SQL equivalents.
* Prepare sample data for testing relational algebra queries.

D6 - Relational Division

Prompt given to AI:

“Write an SQL query using relational division logic to find students who have attended all Sports events. Use nested NOT EXISTS and explain how it works.”

AI-generated query:

SELECT s.student_id, s.first_name, s.last_name
FROM student s
WHERE NOT EXISTS (
    SELECT 1
    FROM event e
    WHERE e.category = 'Sports'
      AND NOT EXISTS (
          SELECT 1
          FROM event_registration er
          WHERE er.student_id = s.student_id
            AND er.event_id = e.event_id
            AND er.status = 'attended'
      )
)
ORDER BY s.student_id;

Testing and Verification

The query was executed in PostgreSQL using the sample data created for this assignment.

The result contained:

* Student 1: Ayse Yilmaz
* Student 2: Mehmet Demir

Both students had attended all Sports events.

Misleading Case

Student 3, Zeynep Kaya, had attended one Sports event but had not attended the other one. At first, this could make her appear as a successful candidate. However, the division query correctly excluded her because she had not attended every Sports event.

Responsibility

The AI-generated SQL was reviewed and tested by the student. The student executed the queries using PostgreSQL and checked whether the results matched the expected data.