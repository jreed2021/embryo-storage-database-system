/*========================================================
  Embryo Storage Database System
  Oracle SQL DDL Script
========================================================*/

-- Drop views first
DROP VIEW vw_patient_embryo_summary;
DROP VIEW vw_specialist_procedure_summary;

-- Drop triggers
DROP TRIGGER trg_patients_id;
DROP TRIGGER trg_tanks_id;
DROP TRIGGER trg_specialists_id;
DROP TRIGGER trg_procedures_id;
DROP TRIGGER trg_embryos_id;

-- Drop sequences
DROP SEQUENCE seq_patients_id;
DROP SEQUENCE seq_tanks_id;
DROP SEQUENCE seq_specialists_id;
DROP SEQUENCE seq_procedures_id;
DROP SEQUENCE seq_embryos_id;

-- Drop tables
DROP TABLE embryos CASCADE CONSTRAINTS;
DROP TABLE procedures CASCADE CONSTRAINTS;
DROP TABLE specialists CASCADE CONSTRAINTS;
DROP TABLE storage_tanks CASCADE CONSTRAINTS;
DROP TABLE patients CASCADE CONSTRAINTS;

--------------------------------------------------------
-- TABLE: PATIENTS
--------------------------------------------------------
CREATE TABLE patients (
    patient_id           NUMBER PRIMARY KEY,
    first_name           VARCHAR2(30) NOT NULL,
    last_name            VARCHAR2(30) NOT NULL,
    date_of_birth        DATE NOT NULL,
    phone_number         VARCHAR2(20),
    email_address        VARCHAR2(60),
    created_date         DATE DEFAULT SYSDATE
);

--------------------------------------------------------
-- TABLE: STORAGE_TANKS
--------------------------------------------------------
CREATE TABLE storage_tanks (
    tank_id              NUMBER PRIMARY KEY,
    tank_label           VARCHAR2(20) NOT NULL,
    tank_location        VARCHAR2(50) NOT NULL,
    tank_capacity        NUMBER NOT NULL,
    current_usage        NUMBER DEFAULT 0,
    last_inspection_date DATE,
    CONSTRAINT chk_tank_capacity CHECK (tank_capacity >= 0),
    CONSTRAINT chk_current_usage CHECK (current_usage >= 0)
);

--------------------------------------------------------
-- TABLE: SPECIALISTS
--------------------------------------------------------
CREATE TABLE specialists (
    specialist_id        NUMBER PRIMARY KEY,
    first_name           VARCHAR2(30) NOT NULL,
    last_name            VARCHAR2(30) NOT NULL,
    specialty            VARCHAR2(40),
    phone_number         VARCHAR2(20),
    email_address        VARCHAR2(60)
);

--------------------------------------------------------
-- TABLE: PROCEDURES
--------------------------------------------------------
CREATE TABLE procedures (
    procedure_id         NUMBER PRIMARY KEY,
    patient_id           NUMBER NOT NULL,
    specialist_id        NUMBER NOT NULL,
    procedure_type       VARCHAR2(30) NOT NULL,
    procedure_date       DATE NOT NULL,
    ivf_cycle_date       DATE,
    notes                VARCHAR2(200),
    CONSTRAINT fk_procedure_patient
        FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    CONSTRAINT fk_procedure_specialist
        FOREIGN KEY (specialist_id) REFERENCES specialists(specialist_id)
);

--------------------------------------------------------
-- TABLE: EMBRYOS
--------------------------------------------------------
CREATE TABLE embryos (
    embryo_id            NUMBER PRIMARY KEY,
    patient_id           NUMBER NOT NULL,
    procedure_id         NUMBER NOT NULL,
    tank_id              NUMBER NOT NULL,
    embryo_stage         VARCHAR2(20) NOT NULL,
    embryo_grade         VARCHAR2(10),
    retrieval_date       DATE NOT NULL,
    fertilization_type   VARCHAR2(20),
    storage_status       VARCHAR2(20) DEFAULT 'Stored',
    freeze_date          DATE,
    thaw_date            DATE,
    CONSTRAINT fk_embryo_patient
        FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    CONSTRAINT fk_embryo_procedure
        FOREIGN KEY (procedure_id) REFERENCES procedures(procedure_id),
    CONSTRAINT fk_embryo_tank
        FOREIGN KEY (tank_id) REFERENCES storage_tanks(tank_id),
    CONSTRAINT chk_storage_status
        CHECK (storage_status IN ('Stored', 'Transferred', 'Discarded', 'Thawed'))
);

--------------------------------------------------------
-- INDEXES
--------------------------------------------------------
CREATE INDEX idx_patients_last_name
    ON patients(last_name);

CREATE INDEX idx_tanks_location
    ON storage_tanks(tank_location);

CREATE INDEX idx_specialists_last_name
    ON specialists(last_name);

CREATE INDEX idx_procedures_patient_id
    ON procedures(patient_id);

CREATE INDEX idx_procedures_specialist_id
    ON procedures(specialist_id);

CREATE INDEX idx_embryos_patient_id
    ON embryos(patient_id);

CREATE INDEX idx_embryos_tank_id
    ON embryos(tank_id);

CREATE INDEX idx_embryos_procedure_id
    ON embryos(procedure_id);

CREATE INDEX idx_embryos_stage
    ON embryos(embryo_stage);

--------------------------------------------------------
-- VIEWS
--------------------------------------------------------
CREATE OR REPLACE VIEW vw_patient_embryo_summary AS
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    e.embryo_id,
    e.embryo_stage,
    e.embryo_grade,
    e.storage_status,
    t.tank_label
FROM patients p
JOIN embryos e
    ON p.patient_id = e.patient_id
JOIN storage_tanks t
    ON e.tank_id = t.tank_id;

CREATE OR REPLACE VIEW vw_specialist_procedure_summary AS
SELECT
    s.specialist_id,
    s.first_name,
    s.last_name,
    s.specialty,
    COUNT(pr.procedure_id) AS procedure_count
FROM specialists s
LEFT JOIN procedures pr
    ON s.specialist_id = pr.specialist_id
GROUP BY
    s.specialist_id,
    s.first_name,
    s.last_name,
    s.specialty;

--------------------------------------------------------
-- SEQUENCES
--------------------------------------------------------
CREATE SEQUENCE seq_patients_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tanks_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_specialists_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_procedures_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_embryos_id START WITH 1 INCREMENT BY 1;

--------------------------------------------------------
-- TRIGGERS
--------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_patients_id
BEFORE INSERT ON patients
FOR EACH ROW
BEGIN
    IF :NEW.patient_id IS NULL THEN
        :NEW.patient_id := seq_patients_id.NEXTVAL;
    END IF;
END;
/
CREATE OR REPLACE TRIGGER trg_tanks_id
BEFORE INSERT ON storage_tanks
FOR EACH ROW
BEGIN
    IF :NEW.tank_id IS NULL THEN
        :NEW.tank_id := seq_tanks_id.NEXTVAL;
    END IF;
END;
/
CREATE OR REPLACE TRIGGER trg_specialists_id
BEFORE INSERT ON specialists
FOR EACH ROW
BEGIN
    IF :NEW.specialist_id IS NULL THEN
        :NEW.specialist_id := seq_specialists_id.NEXTVAL;
    END IF;
END;
/
CREATE OR REPLACE TRIGGER trg_procedures_id
BEFORE INSERT ON procedures
FOR EACH ROW
BEGIN
    IF :NEW.procedure_id IS NULL THEN
        :NEW.procedure_id := seq_procedures_id.NEXTVAL;
    END IF;
END;
/
CREATE OR REPLACE TRIGGER trg_embryos_id
BEFORE INSERT ON embryos
FOR EACH ROW
BEGIN
    IF :NEW.embryo_id IS NULL THEN
        :NEW.embryo_id := seq_embryos_id.NEXTVAL;
    END IF;
END;
/
