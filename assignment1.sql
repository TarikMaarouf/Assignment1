-- Task I1
BEGIN;

UPDATE book_read
SET status = 'read'
WHERE profile_id = 1
AND book_id = 1;

SELECT *
FROM book_read
WHERE profile_id = 1
AND book_id = 1;

ROLLBACK;

SELECT *
FROM book_read
WHERE profile_id = 1
AND book_id = 1;

-- Forklaring:
-- Her starter jeg en transaction med BEGIN.
-- Jeg opdaterer status til 'read' for en bestemt række.
-- Derefter laver jeg en SELECT for at se ændringen.
-- ROLLBACK fortryder ændringen.
-- Den sidste SELECT viser at ændringen ikke blev gemt i databasen.99;