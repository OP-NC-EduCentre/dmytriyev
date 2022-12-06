-- Code	Line / Position	Description
-- L014	5 / 11	
-- Unquoted identifiers must be consistently lower case.
-- L057	5 / 36	
-- Do not use special characters in identifiers.
-- L014	6 / 12	
-- Unquoted identifiers must be consistently lower case.
-- L057	6 / 42	
-- Do not use special characters in identifiers.
-- L014	7 / 26	
-- Unquoted identifiers must be consistently lower case.
-- L057	7 / 51	
-- Do not use special characters in identifiers.
-- L014	8 / 6	
-- Unquoted identifiers must be consistently lower case.

SELECT
    first_name,
    last_name,
    birth_date,
    ROUND(SYSDATE - birth_date) AS "Days passed",
    ROUND((SYSDATE - birth_date) / 7) AS "Weeks passed",
    ROUND(MONTHS_BETWEEN(SYSDATE, birth_date)) AS "Months passed"
FROM Owner;