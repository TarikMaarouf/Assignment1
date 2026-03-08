SET search_path TO goodreads_v2;

--Task 1
SELECT
    id AS book_id,
    title,
    year_published AS pub_year
FROM book;

-- Forklaring:
-- Denne forespørgsel henter id, title og year_published fra book-tabellen.
-- id vises som book_id og year_published vises som pub_year ved hjælp af alias.

--Task 2
SELECT DISTINCT page_count
FROM book;

-- Forklaring:
-- DISTINCT bruges til at fjerne dubletter, så hvert page_count kun vises én gang.


-- Task A3
SELECT
    title,
    page_count,
    page_count + 10 AS pages_plus_ten
FROM book;

-- Forklaring:
-- Her laver jeg et calculated field ved at tage page_count og lægge 10 til.
-- Resultatet bliver vist som en ny kolonne der hedder pages_plus_ten.
-- Det ændrer ikke noget i databasen, det er kun noget der bliver beregnet i resultatet.

-- Task B1
SELECT *
FROM book_read
WHERE EXTRACT(YEAR FROM date_finished) = 2020;

-- Forklaring:
-- Her filtrerer jeg rækkerne så kun bøger der er færdiglæst i 2020 bliver vist.
-- EXTRACT bruges til at hente året fra date_finished kolonnen.

-- Task B2
SELECT title
FROM book
WHERE title LIKE 'The%';

-- Forklaring:
-- Her filtrerer jeg titlerne så kun dem der starter med "The" bliver vist.
-- LIKE bruges til at søge i tekst, og % betyder at der kan stå hvad som helst efter "The".

-- Task B3
SELECT *
FROM book
WHERE isbn IS NULL;

-- Forklaring:
-- Her finder jeg bøger hvor ISBN mangler.
-- IS NULL bruges til at finde rækker hvor værdien i en kolonne ikke er sat.

-- Task C1
SELECT COUNT(*) AS total_books
FROM book;

-- Forklaring:
-- Her bruger jeg COUNT til at tælle hvor mange rækker der er i book-tabellen.
-- Resultatet bliver vist som total_books.

-- Task C2
SELECT
    MIN(page_count) AS min_pages,
    MAX(page_count) AS max_pages,
    AVG(page_count) AS avg_pages
FROM book;

-- Forklaring:
-- Her bruger jeg MIN til at finde det mindste page_count,
-- MAX til at finde det største page_count,
-- og AVG til at beregne gennemsnittet af page_count i book-tabellen.

-- Task D1
-- Forklaring:
-- Når man bruger GROUP BY i SQL, skal alle kolonner i SELECT enten være med i GROUP BY
-- eller bruges sammen med en aggregate funktion som COUNT, AVG, MIN eller MAX.
-- Grunden er at SQL ellers ikke ved hvilken værdi den skal vise for hver gruppe.

-- Task D2
SELECT
    year_published,
    COUNT(*) AS book_count,
    AVG(page_count) AS avg_page_count
FROM book
GROUP BY year_published
HAVING AVG(page_count) > 100;

-- Forklaring:
-- Her grupperer jeg bøgerne efter year_published.
-- COUNT bruges til at tælle hvor mange bøger der er udgivet hvert år.
-- AVG bruges til at finde gennemsnittet af page_count for hvert år.
-- HAVING bruges til kun at vise år hvor gennemsnittet af page_count er over 100.

-- Task E1
SELECT
    title,
    page_count
FROM book
ORDER BY page_count DESC
LIMIT 10;

-- Forklaring:
-- Her sorterer jeg bøgerne efter page_count fra størst til mindst.
-- På den måde kommer de længste bøger først.
-- LIMIT 10 bruges til kun at vise de 10 længste bøger.

-- Task E2
SELECT
    title,
    year_published
FROM book
ORDER BY title ASC, year_published DESC;

-- Forklaring:
-- Her sorterer jeg først titlerne alfabetisk med ASC.
-- Hvis der er flere bøger med samme titel,
-- bliver de derefter sorteret efter year_published fra nyeste til ældste med DESC.

-- Task F1
SELECT
    b.id AS book_id,
    b.title,
    a.first_name || ' ' || a.last_name AS author_full_name
FROM book b
JOIN author a
ON b.author_id = a.id;

-- Forklaring:
-- Her bruger jeg JOIN til at kombinere book og author tabellerne.
-- book.author_id bliver koblet sammen med author.id.
-- På den måde kan jeg vise både bogens titel og forfatterens navn.
-- first_name og last_name bliver sat sammen til et fuldt navn.

-- Task F2
SELECT
    a.first_name,
    a.last_name,
    COUNT(b.id) AS book_count
FROM author a
LEFT JOIN book b
ON a.id = b.author_id
GROUP BY a.first_name, a.last_name;

-- Forklaring:
-- Her bruger jeg LEFT JOIN til at koble author og book tabellerne sammen.
-- På den måde kan jeg se hvilke bøger der tilhører hver forfatter.
-- COUNT bruges til at tælle hvor mange bøger hver forfatter har.
-- GROUP BY bruges til at samle bøgerne for hver forfatter.

-- Task F3
-- Forklaring:
-- En FULL OUTER JOIN mellem publisher og book vil vise alle rækker fra begge tabeller.
-- Det betyder at man kan se publishers som ikke har nogen bøger,
-- og også bøger som ikke har en tilknyttet publisher.
-- På den måde kan man finde manglende relationer mellem tabellerne.

-- Task F4
-- Forklaring:
-- En INNER JOIN kobler rækker fra to tabeller sammen,
-- når værdierne i de kolonner man joiner på matcher.
-- Kun rækker hvor der er et match i begge tabeller bliver vist i resultatet.

-- Task G1 - Set A
SELECT b.title
FROM book b
JOIN book_read br
ON b.id = br.book_id
WHERE br.status = 'read';

-- Forklaring:
-- Her finder jeg bøger som har status 'read' i book_read tabellen.
-- Jeg bruger JOIN til at koble book og book_read sammen via book_id.
-- Derefter filtrerer jeg rækkerne så kun dem med status 'read' bliver vist.

-- Task G2 - Set B
SELECT b.title
FROM book b
JOIN book_read br
ON b.id = br.book_id
WHERE br.status = 'to-read';

-- Forklaring:
-- Her finder jeg bøger som har status 'to-read' i book_read tabellen.
-- Jeg bruger JOIN til at koble book og book_read sammen via book_id.
-- Derefter filtrerer jeg så kun bøger med status 'to-read' bliver vist.

-- Task G3 - UNION
SELECT b.title
FROM book b
JOIN book_read br
ON b.id = br.book_id
WHERE br.status = 'read'

UNION

SELECT b.title
FROM book b
JOIN book_read br
ON b.id = br.book_id
WHERE br.status = 'to-read';

-- Forklaring:
-- UNION bruges til at kombinere to resultatsæt.
-- Hvis den samme titel findes i begge resultater,
-- vil den kun blive vist én gang fordi UNION fjerner dubletter.

-- Task G3 - UNION ALL
SELECT b.title
FROM book b
JOIN book_read br
ON b.id = br.book_id
WHERE br.status = 'read'

UNION ALL

SELECT b.title
FROM book b
JOIN book_read br
ON b.id = br.book_id
WHERE br.status = 'to-read';

-- Forklaring:
-- UNION ALL kombinerer også to resultatsæt,
-- men den fjerner ikke dubletter.
-- Hvis den samme titel findes flere gange,
-- vil den blive vist flere gange i resultatet.

-- Task H1
SELECT MAX(id) + 1 AS new_book_id
FROM book;

-- Forklaring:
-- Her finder jeg det største id i book-tabellen med MAX
-- og lægger 1 til for at få et nyt id som kan bruges til en ny bog.

-- Task H2
INSERT INTO book (
    id,
    title,
    year_published,
    page_count,
    isbn,
    author_id,
    publisher_id,
    binding_id
)
VALUES (
    1000000,
    'Example Book',
    2024,
    250,
    '1234567890123',
    1,
    1,
    1
);

-- Verify insert
SELECT *
FROM book
WHERE id = 1000000;

-- Forklaring:
-- Her indsætter jeg en ny række i book-tabellen.
-- Jeg bruger et nyt id fra H1, så der ikke kommer fejl med duplicate key.
-- Derefter tjekker jeg med en SELECT, at bogen faktisk er blevet indsat.

-- Task H3
SELECT COUNT(*) AS rows_to_update
FROM book_read br
JOIN book b
ON br.book_id = b.id
WHERE b.year_published BETWEEN 1990 AND 1999;

-- Forklaring:
-- Her tæller jeg hvor mange rækker i book_read der vil blive påvirket af update.
-- Jeg joiner book_read med book, så jeg kan filtrere på year_published.
-- På den måde finder jeg alle bøger fra 1990 til 1999.

-- Task H4
UPDATE book_read br
SET status = 'classic'
FROM book b
WHERE br.book_id = b.id
AND b.year_published BETWEEN 1990 AND 1999;

-- Forklaring:
-- Her opdaterer jeg status i book_read til 'classic'.
-- Jeg bruger en JOIN med book-tabellen, så jeg kan filtrere på year_published.
-- Kun bøger der er udgivet mellem 1990 og 1999 bliver opdateret.

-- Verify update

SELECT br.profile_id, br.book_id, br.status
FROM book_read br
JOIN book b
ON br.book_id = b.id
WHERE b.year_published BETWEEN 1990 AND 1999;

-- Forklaring:
-- Her tjekker jeg at status nu er ændret til 'classic'
-- for bøger udgivet mellem 1990 og 1999.

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
-- Den sidste SELECT viser at ændringen ikke blev gemt i databasen.