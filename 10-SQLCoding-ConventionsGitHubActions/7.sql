-- Code	Line / Position	Description
-- L001	1 / 7	
-- Unnecessary trailing whitespace.
-- L014	7 / 6	
-- Unquoted identifiers must be consistently lower case.
-- L003	9 / 17	
-- Expected 0 indentations, found 4 [compared to line 08]
-- L003	10 / 17	
-- Expected 0 indentations, found 4 [compared to line 08]
-- L014	10 / 22	
-- Unquoted identifiers must be consistently lower case.
-- L003	11 / 17	
-- Expected 0 indentations, found 4 [compared to line 08]
-- L003	12 / 16	
-- Expected 4 indentations, found less than 4 [compared to line 08]

SELECT 
    car_number,
    brand,
    color,
    type,
    weight
FROM Car
WHERE weight < (
                SELECT weight
                FROM Car
                WHERE car_number = 'ВН0000АА'
               );