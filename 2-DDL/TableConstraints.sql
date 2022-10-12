ALTER TABLE Owner ADD CONSTRAINT owner_pk
    PRIMARY KEY (id);
-- номер паспорту унікальний
ALTER TABLE Owner ADD CONSTRAINT owner_pasport_unique 
    UNIQUE(pasport);
ALTER TABLE Owner MODIFY (
    first_name NOT NULL,
    last_name NOT NULL,
    birth_date NOT NULL,
    pasport NOT NULL,
    address NOT NULL,
    phone NOT NULL
);

ALTER TABLE Car ADD CONSTRAINT car_pk 
    PRIMARY KEY (car_number);
-- кожен автомобіль має власника
ALTER TABLE Car ADD CONSTRAINT car_owner_fk 
    FOREIGN KEY (owner) REFERENCES Owner(id);
-- вага не може бути від'ємною
ALTER TABLE Car ADD CONSTRAINT car_weight_not_zero
    CHECK (weight > 0);
ALTER TABLE Car MODIFY (
    brand NOT NULL,
    color NOT NULL,
    production_year NOT NULL,
    type NOT NULL,
    owner NOT NULL
);

ALTER TABLE ParkingSlot ADD CONSTRAINT slot_pk
    PRIMARY KEY (id);
-- на паркомісці може бути автомобіль
ALTER TABLE ParkingSlot ADD CONSTRAINT slot_car_fk
    FOREIGN KEY (car) REFERENCES Car(car_number);
ALTER TABLE ParkingSlot MODIFY (
    position NOT NULL,
    intended_type NOT NULL,
    reserved_since NOT NULL,
    reserved_due NOT NULL
);