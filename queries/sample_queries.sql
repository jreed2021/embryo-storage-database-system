-- View all patients
SELECT * FROM patients;

-- View embryo details with patient info
SELECT p.first_name, p.last_name, e.embryo_stage, e.embryo_grade
FROM patients p
JOIN embryos e ON p.patient_id = e.patient_id;

-- Count embryos per patient
SELECT patient_id, COUNT(*) AS embryo_count
FROM embryos
GROUP BY patient_id;

-- View storage usage by tank
SELECT tank_label, current_usage, tank_capacity
FROM storage_tanks;

-- Specialist workload
SELECT s.first_name, s.last_name, COUNT(pr.procedure_id) AS procedures
FROM specialists s
LEFT JOIN procedures pr ON s.specialist_id = pr.specialist_id
GROUP BY s.first_name, s.last_name;

-- Patients with thawed embryos
SELECT p.first_name, p.last_name, e.storage_status
FROM patients p
JOIN embryos e ON p.patient_id = e.patient_id
WHERE e.storage_status = 'Thawed';
