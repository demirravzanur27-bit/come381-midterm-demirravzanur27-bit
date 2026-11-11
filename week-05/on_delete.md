ON DELETE Policy

Chosen Policy: NO ACTION

The database uses the default NO ACTION behavior for foreign key relationships.

This policy prevents deleting a parent record when related child records still exist.

Foreign Key Relationships

* membership.student_id references student.student_id.
* membership.club_id references club.club_id.
* event.club_id references club.club_id.
* event_registration.student_id references student.student_id.
* event_registration.event_id references event.event_id.

Reason for Choosing NO ACTION

We chose NO ACTION to protect the consistency of the university club management system.

For example:

* A student cannot be deleted while membership or event registration records reference that student.
* A club cannot be deleted while it has memberships or events.
* An event cannot be deleted while students are registered for it.

Related child records must be deleted before deleting their parent record.

This policy prevents accidental data loss and orphan records.