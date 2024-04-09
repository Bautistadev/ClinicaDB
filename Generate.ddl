-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2024-03-26 10:14:49 ART
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE appointment (
    id                 INTEGER NOT NULL,
    appointment_status VARCHAR2(45 BYTE) NOT NULL,
    appointment_date   DATE NOT NULL,
    datecreated        DATE NOT NULL,
    datedeleted        DATE,
    patient_id         INTEGER NOT NULL,
    doctor_id          INTEGER NOT NULL
);

ALTER TABLE appointment ADD CONSTRAINT appointment_pk PRIMARY KEY ( id );

CREATE TABLE credential (
    id             INTEGER NOT NULL,
    name_lastname  VARCHAR2(45) NOT NULL,
    liscensenumber VARCHAR2(45) NOT NULL,
    especiality    VARCHAR2(45) NOT NULL,
    institute      VARCHAR2(45) NOT NULL,
    graduationdate DATE NOT NULL
);

ALTER TABLE credential ADD CONSTRAINT credential_pk PRIMARY KEY ( id );

CREATE TABLE doctor (
    id            INTEGER NOT NULL,
    name          VARCHAR2(45) NOT NULL,
    lastname      VARCHAR2(45) NOT NULL,
    dni           INTEGER NOT NULL,
    email         VARCHAR2(45) NOT NULL,
    datecreated   DATE NOT NULL,
    datedeleetd   DATE,
    user_id       INTEGER NOT NULL,
    credential_id INTEGER NOT NULL
);

ALTER TABLE doctor ADD CONSTRAINT doctor_pk PRIMARY KEY ( id );

CREATE TABLE doctor_telephone (
    id           INTEGER NOT NULL,
    doctor_id    INTEGER NOT NULL,
    telephone_id INTEGER NOT NULL
);

ALTER TABLE doctor_telephone ADD CONSTRAINT doctor_telephone_pk PRIMARY KEY ( id );

CREATE TABLE historical (
    id              INTEGER NOT NULL,
    diagnosis       VARCHAR2(45) NOT NULL,
    tratment        CLOB NOT NULL,
    recomendeds     CLOB NOT NULL,
    result          CLOB NOT NULL,
    patient_id      INTEGER NOT NULL,
    appointment_id  INTEGER NOT NULL,
    prescription_id INTEGER NOT NULL
);

ALTER TABLE historical ADD CONSTRAINT historical_pk PRIMARY KEY ( id );

CREATE TABLE medicine (
    id                   INTEGER NOT NULL,
    name                 VARCHAR2(30 CHAR) NOT NULL,
    description_medicine CLOB NOT NULL,
    instruction          CLOB NOT NULL,
    datecreated          DATE NOT NULL,
    datedeleted          DATE
);

ALTER TABLE medicine ADD CONSTRAINT medicine_pk PRIMARY KEY ( id );

CREATE TABLE patient (
    id          INTEGER NOT NULL,
    name        VARCHAR2(45) NOT NULL,
    lastname    VARCHAR2(45) NOT NULL,
    dni         INTEGER NOT NULL,
    birthdate   DATE NOT NULL,
    gender      VARCHAR2(45) NOT NULL,
    email       VARCHAR2(45) NOT NULL,
    address     VARCHAR2(45) NOT NULL,
    datecreated DATE NOT NULL,
    datedeleted DATE
);

ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( id );

CREATE TABLE patient_telephone (
    id           INTEGER NOT NULL,
    patient_id   INTEGER NOT NULL,
    telephone_id INTEGER NOT NULL
);

ALTER TABLE patient_telephone ADD CONSTRAINT patient_telephone_pk PRIMARY KEY ( id );

CREATE TABLE prescription (
    id                INTEGER NOT NULL,
    prescription_date DATE NOT NULL,
    dose              VARCHAR2(45 CHAR) NOT NULL,
    instruction       CLOB NOT NULL,
    medicine_id       INTEGER NOT NULL
);

ALTER TABLE prescription ADD CONSTRAINT prescription_pk PRIMARY KEY ( id );

CREATE TABLE telephone (
    id       INTEGER NOT NULL,
    areacod  INTEGER NOT NULL,
    "number" INTEGER NOT NULL
);

ALTER TABLE telephone ADD CONSTRAINT telephone_pk PRIMARY KEY ( id );

CREATE TABLE "User" (
    id          INTEGER NOT NULL,
    username    VARCHAR2(45) NOT NULL,
    password    VARCHAR2(120 BYTE) NOT NULL,
    role        VARCHAR2(45) NOT NULL,
    status      VARCHAR2(45) NOT NULL,
    datecreated VARCHAR2(45) NOT NULL,
    datedeleted DATE
);

ALTER TABLE "User" ADD CONSTRAINT user_pk PRIMARY KEY ( id );

ALTER TABLE appointment
    ADD CONSTRAINT appointment_doctor_fk FOREIGN KEY ( doctor_id )
        REFERENCES doctor ( id );

ALTER TABLE appointment
    ADD CONSTRAINT appointment_patient_fk FOREIGN KEY ( patient_id )
        REFERENCES patient ( id );

ALTER TABLE doctor
    ADD CONSTRAINT doctor_credential_fk FOREIGN KEY ( credential_id )
        REFERENCES credential ( id );

ALTER TABLE doctor_telephone
    ADD CONSTRAINT doctor_telephone_doctor_fk FOREIGN KEY ( doctor_id )
        REFERENCES doctor ( id );

ALTER TABLE doctor_telephone
    ADD CONSTRAINT doctor_telephone_telephone_fk FOREIGN KEY ( telephone_id )
        REFERENCES telephone ( id );

ALTER TABLE doctor
    ADD CONSTRAINT doctor_user_fk FOREIGN KEY ( user_id )
        REFERENCES "User" ( id );

ALTER TABLE historical
    ADD CONSTRAINT historical_appointment_fk FOREIGN KEY ( appointment_id )
        REFERENCES appointment ( id );

ALTER TABLE historical
    ADD CONSTRAINT historical_patient_fk FOREIGN KEY ( patient_id )
        REFERENCES patient ( id );

ALTER TABLE historical
    ADD CONSTRAINT historical_prescription_fk FOREIGN KEY ( prescription_id )
        REFERENCES prescription ( id );

ALTER TABLE patient_telephone
    ADD CONSTRAINT patient_telephone_patient_fk FOREIGN KEY ( patient_id )
        REFERENCES patient ( id );

ALTER TABLE patient_telephone
    ADD CONSTRAINT patient_telephone_telephone_fk FOREIGN KEY ( telephone_id )
        REFERENCES telephone ( id );

ALTER TABLE prescription
    ADD CONSTRAINT prescription_medicine_fk FOREIGN KEY ( medicine_id )
        REFERENCES medicine ( id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             23
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
