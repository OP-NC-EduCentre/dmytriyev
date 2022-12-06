-- Code	Line / Position	Description
-- L014	2 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	4 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	5 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	6 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	7 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	8 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	9 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	10 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	14 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	15 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	16 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	17 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	18 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L029	18 / 5	
-- Keywords should not be used as identifiers.
-- L014	19 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L008	19 / 20	
-- Commas should be followed by a single whitespace unless followed by a comment.
-- L014	20 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L029	20 / 5	
-- Keywords should not be used as identifiers.
-- L014	24 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	25 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L029	25 / 5	
-- Keywords should not be used as identifiers.
-- L014	26 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	27 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	28 / 5	
-- Unquoted identifiers must be consistently pascal case.
-- L014	29 / 5	
-- Unquoted identifiers must be consistently pascal case.

CREATE TABLE Owner (
    id NUMBER(8), -- ідентифікатор власника
    -- ПІБ власника окремими атрибутами
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    patronymic VARCHAR(25),
    birth_date DATE, -- дата народження
    pasport VARCHAR(20), -- номер паспорту
    address VARCHAR(80), -- адреса
    phone VARCHAR(20) -- номер телефону
);

CREATE TABLE Car (
    car_number VARCHAR(15), -- номер автомобіля
    brand VARCHAR(20), -- марка
    color VARCHAR(20), -- колір
    production_year DATE, -- рік виробництва
    type VARCHAR(20), -- тип транспорту (легковик, вантажний)
    weight NUMBER(8,2), -- вага
    owner NUMBER(8) -- власник
);

CREATE TABLE ParkingSlot (
    id NUMBER(8), -- номер паркомісця
    position VARCHAR(20), -- місце розташування (надворі, номер поверху тощо)
    intended_type VARCHAR(20), -- тип транспорту, для якого призначене місце
    reserved_since DATE, -- зарезервовано з вказаної дати
    reserved_due DATE, -- зарезервовано до вказаної дати
    car VARCHAR(15) -- припаркований автомобіль
);