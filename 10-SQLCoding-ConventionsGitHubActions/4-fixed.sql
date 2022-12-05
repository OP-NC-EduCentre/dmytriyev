SELECT
    first_name,
    last_name,
    birth_date,
    ROUND(sysdate - birth_date) AS "Days passed",
    ROUND((sysdate - birth_date) / 7) AS "Weeks passed",
    ROUND(MONTHS_BETWEEN(sysdate, birth_date)) AS "Months passed"
FROM owner;
