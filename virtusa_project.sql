CREATE DATABASE hospital_management_db;
USE hospital_management_db;

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(50),
    specialization VARCHAR(50)
);
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY,
    patient_id INT,
    diagnosis VARCHAR(100),
    cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
INSERT INTO Patients VALUES
(1, 'Pooja', 25, 'Female'),
(2, 'Anita', 30, 'Female'),
(3, 'Kiran', 40, 'Male');

INSERT INTO Doctors VALUES
(1, 'Dr. Sharma', 'Cardiology'),
(2, 'Dr. Meena', 'Neurology');

INSERT INTO Appointments VALUES
(1, 1, 1, '2024-04-01'),
(2, 2, 1, '2025-04-02'),
(3, 1, 2, '2026-05-01');

INSERT INTO Treatments VALUES
(1, 1, 'Heart Issue', 5000),
(2, 2, 'Migraine', 2000),
(3, 1, 'Heart Issue', 7000);


SELECT d.name, COUNT(a.appointment_id) AS total_visits
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name
ORDER BY total_visits DESC;

SELECT MONTH(a.date) AS month, SUM(t.cost) AS total_revenue
FROM Treatments t
JOIN Appointments a ON t.patient_id = a.patient_id
GROUP BY MONTH(a.date);

SELECT diagnosis, COUNT(*) AS count
FROM Treatments
GROUP BY diagnosis
ORDER BY count DESC;

SELECT patient_id, COUNT(*) AS visit_count
FROM Appointments
GROUP BY patient_id;

SELECT d.name, COUNT(a.appointment_id) AS total_patients
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name;
