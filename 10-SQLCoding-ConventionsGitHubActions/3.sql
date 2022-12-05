-- Code	Line / Position	Description
-- L034	1 / 1	
-- Select wildcards then simple targets before calculations and aggregates.
-- L014	10 / 6	
-- Unquoted identifiers must be consistently lower case.

SELECT
    car_number,
    brand,
    color,
    production_year,
    type,
    weight * 1000 || ' кг' AS weight_kg,
    owner,
    purchase_date
FROM Car;