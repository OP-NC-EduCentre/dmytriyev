SELECT
    car_number,
    brand,
    color,
    type,
    weight
FROM car
WHERE weight < (
    SELECT weight
    FROM car
    WHERE car_number = 'ВН0000АА'
);
