DROP TABLE ParkingSlot CASCADE CONSTRAINTS;
DROP TABLE Car CASCADE CONSTRAINTS;
DROP TABLE Owner CASCADE CONSTRAINTS;

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
    car VARCHAR(10) -- припаркований автомобіль
);