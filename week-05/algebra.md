Relational Algebra Queries

This document contains six relational algebra queries for the University Club Management System.

Query 1: Find all Computer Engineering students

Relational Algebra:

σ_department = ‘Computer Engineering’ (student)

Explanation: Selects students who study Computer Engineering.

Query 2: List all clubs and their members

Relational Algebra:

π_club_name, first_name, last_name (club ⋈ membership ⋈ student)

Explanation: Lists club names together with the first and last names of their members.

Query 3: Find all events organized by the Software Club

Relational Algebra:

π_event_name, event_date, location (σ_club_name = ‘Software Club’ (club ⋈ event))

Explanation: Finds the events organized by the Software Club.

Query 4: Find students registered for the SQL Workshop

Relational Algebra:

π_first_name, last_name (student ⋈ event_registration ⋈ σ_event_name = ‘SQL Workshop’ (event))

Explanation: Lists students who registered for the SQL Workshop.

Query 5: Find students who belong to both the Software Club and the Photography Club

Relational Algebra:

S = π_student_id (membership ⋈ σ_club_name = ‘Software Club’ (club))

P = π_student_id (membership ⋈ σ_club_name = ‘Photography Club’ (club))

S ∩ P

Explanation: Finds students who are members of both clubs.

Query 6: Find events with a capacity of at least 50

Relational Algebra:

π_event_name, event_date, capacity (σ_capacity >= 50 (event))

Explanation: Lists events that can accommodate at least 50 participants.