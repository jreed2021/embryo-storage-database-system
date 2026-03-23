/*========================================================
  Embryo Storage Database System
  Oracle SQL DML Script
========================================================*/

--------------------------------------------------------
-- INSERT INTO PATIENTS
--------------------------------------------------------
INSERT INTO patients (first_name, last_name, date_of_birth, phone_number, email_address)
VALUES ('Janessa', 'Clark', TO_DATE('1993-04-21', 'YYYY-MM-DD'), '252-555-1001', 'janessa.clark@email.com');

INSERT INTO patients (first_name, last_name, date_of_birth, phone_number, email_address)
VALUES ('Melissa', 'Reed', TO_DATE('1988-09-10', 'YYYY-MM-DD'), '252-555-1002', 'melissa.reed@email.com');

INSERT INTO patients (first_name, last_name, date_of_birth, phone_number, email_address)
VALUES ('Alicia', 'Brown', TO_DATE('1990-12-15', 'YYYY-MM-DD'), '252-555-1003', 'alicia.brown@email.com');

--------------------------------------------------------
-- INSERT INTO STORAGE_TANKS
--------------------------------------------------------
INSERT INTO storage_tanks (tank_label, tank_location, tank_capacity, current_usage, last_inspection_date)
VALUES ('Tank-A1', 'Lab Room 1', 100, 45, TO_DATE('2024-05-10', 'YYYY-MM-DD'));

INSERT INTO storage_tanks (tank_label, tank_location, tank_capacity, current_usage, last_inspection_date)
VALUES ('Tank-B1', 'Lab Room 2', 120, 52, TO_DATE('2024-05-15', 'YYYY-MM-DD'));

INSERT INTO storage_tanks (tank_label, tank_location, tank_capacity, current_usage, last_inspection_date)
VALUES ('Tank-C1', 'Cryo Storage', 150, 60, TO_DATE('2024-06-01', 'YYYY-MM-DD'));

--------------------------------------------------------
-- INSERT INTO SPECIALISTS
--------------------------------------------------------
INSERT INTO specialists (first_name, last_name, specialty, phone_number, email_address)
VALUES ('Andrea', 'Moore', 'Reproductive Endocrinology', '919-555-2001', 'andrea.moore@clinic.com');

INSERT INTO specialists (first_name, last_name, specialty, phone_number, email_address)
VALUES ('Brian', 'Lewis', 'Embryology', '919-555-2002', 'brian.lewis@clinic.com');

INSERT INTO specialists (first_name, last_name, specialty, phone_number, email_address)
VALUES ('Nina', 'Taylor', 'Andrology', '919-555-2003', 'nina.taylor@clinic.com');

--------------------------------------------------------
-- INSERT INTO PROCEDURES
--------------------------------------------------------
INSERT INTO procedures (patient_id, specialist_id, procedure_type, procedure_date, ivf_cycle_date, notes)
VALUES (1, 1, 'IVF Retrieval', TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'Successful egg retrieval');

INSERT INTO procedures (patient_id, specialist_id, procedure_type, procedure_date, ivf_cycle_date, notes)
VALUES (2, 2, 'Embryo Freezing', TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-03', 'YYYY-MM-DD'), 'Embryos frozen for storage');

INSERT INTO procedures (patient_id, specialist_id, procedure_type, procedure_date, ivf_cycle_date, notes)
VALUES (3, 1, 'IVF Retrieval', TO_DATE('2024-06-10', 'YYYY-MM-DD'), TO_DATE('2024-06-06', 'YYYY-MM-DD'), 'Retrieved multiple mature eggs');

INSERT INTO procedures (patient_id, specialist_id, procedure_type, procedure_date, ivf_cycle_date, notes)
VALUES (1, 3, 'Embryo Assessment', TO_DATE('2024-06-12', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'Embryo grading completed');

--------------------------------------------------------
-- INSERT INTO EMBRYOS
--------------------------------------------------------
INSERT INTO embryos (patient_id, procedure_id, tank_id, embryo_stage, embryo_grade, retrieval_date, fertilization_type, storage_status, freeze_date, thaw_date)
VALUES (1, 1, 1, 'Blastocyst', 'A', TO_DATE('2024-06-05', 'YYYY-MM-DD'), 'ICSI', 'Stored', TO_DATE('2024-06-06', 'YYYY-MM-DD'), NULL);

INSERT INTO embryos (patient_id, procedure_id, tank_id, embryo_stage, embryo_grade, retrieval_date, fertilization_type, storage_status, freeze_date, thaw_date)
VALUES (2, 2, 2, 'Morula', 'B+', TO_DATE('2024-06-08', 'YYYY-MM-DD'), 'Conventional IVF', 'Stored', TO_DATE('2024-06-09', 'YYYY-MM-DD'), NULL);

INSERT INTO embryos (patient_id, procedure_id, tank_id, embryo_stage, embryo_grade, retrieval_date, fertilization_type, storage_status, freeze_date, thaw_date)
VALUES (3, 3, 3, 'Cleavage', 'B', TO_DATE('2024-06-10', 'YYYY-MM-DD'), 'ICSI', 'Stored', TO_DATE('2024-06-11', 'YYYY-MM-DD'), NULL);

INSERT INTO embryos (patient_id, procedure_id, tank_id, embryo_stage, embryo_grade, retrieval_date, fertilization_type, storage_status, freeze_date, thaw_date)
VALUES (1, 4, 1, 'Blastocyst', 'A-', TO_DATE('2024-06-12', 'YYYY-MM-DD'), 'ICSI', 'Thawed', TO_DATE('2024-06-13', 'YYYY-MM-DD'), TO_DATE('2024-06-20', 'YYYY-MM-DD'));

COMMIT;
