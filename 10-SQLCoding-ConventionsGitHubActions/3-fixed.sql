SELECT
    car_number,
    brand,
    color,
    production_year,
    type,
    owner,
    purchase_date,
    weight * 1000 || ' кг' AS weight_kg
FROM car;
