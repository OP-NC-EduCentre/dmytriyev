CREATE TABLE Owner (
    Id NUMBER(8), -- ідентифікатор власника
    -- ПІБ власника окремими атрибутами
    First_Name VARCHAR(20),
    Last_Name VARCHAR(20),
    Patronymic VARCHAR(25),
    Birth_Date DATE, -- дата народження
    Pasport VARCHAR(20), -- номер паспорту
    Address VARCHAR(80), -- адреса
    Phone VARCHAR(20) -- номер телефону
);

CREATE TABLE Car (
    Car_Number VARCHAR(15), -- номер автомобіля
    Brand VARCHAR(20), -- марка
    Color VARCHAR(20), -- колір
    Production_Year DATE, -- рік виробництва
    Type VARCHAR(20), -- тип транспорту (легковик, вантажний)
    Weight NUMBER(8, 2), -- вага
    Owner NUMBER(8) -- власник
);

CREATE TABLE ParkingSlot (
    Id NUMBER(8), -- номер паркомісця
    Position VARCHAR(20), -- місце розташування (надворі, номер поверху тощо)
    Intended_Type VARCHAR(20), -- тип транспорту, для якого призначене місце
    Reserved_Since DATE, -- зарезервовано з вказаної дати
    Reserved_Due DATE, -- зарезервовано до вказаної дати
    Car VARCHAR(15) -- припаркований автомобіль
);
