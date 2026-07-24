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
(1, 'Pooja', 25, 'Male'),
(2, 'Anita', 30, 'Female'),
(3, 'Kiran', 40, 'Male');
INSERT INTO Patients VALUES
(4, 'Rahul', 35, 'Male'),
(5, 'Sneha', 28, 'Female'),
(6, 'Arjun', 45, 'Male'),
(7, 'Priya', 32, 'Female'),
(8, 'Vikram', 50, 'Male');


INSERT INTO Doctors VALUES
(1, 'Dr. Sharma', 'Cardiology'),
(2, 'Dr. Meena', 'Neurology');
INSERT INTO Doctors VALUES
(3, 'Dr. Reddy', 'Orthopedics'),
(4, 'Dr. Priya', 'Dermatology'),
(5, 'Dr. Kumar', 'General Medicine');
INSERT INTO Appointments VALUES
(1, 1, 1, '2024-04-01'),
(2, 2, 1, '2025-04-02'),
(3, 1, 2, '2026-05-01');
INSERT INTO Appointments VALUES
(4, 3, 3, '2026-05-10'),
(5, 4, 1, '2026-06-05'),
(6, 5, 2, '2026-06-12'),
(7, 6, 3, '2026-07-01'),
(8, 7, 4, '2026-07-05'),
(9, 8, 5, '2026-07-08'),
(10, 1, 1, '2026-07-15'),
(11, 2, 5, '2026-07-18'),
(12, 3, 3, '2026-07-20'),
(13, 5, 2, '2026-08-02'),
(14, 6, 1, '2026-08-10');
INSERT INTO Treatments VALUES
(1, 1, 'Heart Issue', 5000),
(2, 2, 'Migraine', 2000),
(3, 1, 'Heart Issue', 7000);
INSERT INTO Treatments VALUES
(4, 3, 'Fracture', 8000),
(5, 4, 'Heart Issue', 6000),
(6, 5, 'Migraine', 2500),
(7, 6, 'Back Pain', 3500),
(8, 7, 'Skin Allergy', 1800),
(9, 8, 'Fever', 1000),
(10, 1, 'Heart Issue', 5500),
(11, 2, 'Fever', 1200),
(12, 3, 'Fracture', 9000),
(13, 5, 'Migraine', 2200),
(14, 6, 'Heart Issue', 7000);
show tables;

-- Find most consulted doctors
SELECT d.name, COUNT(a.appointment_id) AS total_visits
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name
ORDER BY total_visits DESC;

-- Calculate total revenue per month 
SELECT MONTH(a.date) AS month, SUM(t.cost) AS total_revenue
FROM Treatments t
JOIN Appointments a ON t.patient_id = a.patient_id
GROUP BY MONTH(a.date);

-- Identify most common diseases
SELECT diagnosis, COUNT(*) AS count
FROM Treatments
GROUP BY diagnosis	
ORDER BY count DESC;

-- Track patient visit frequency

SELECT patient_id, COUNT(*) AS visit_count
FROM Appointments
GROUP BY patient_id;

-- Analyze doctor performance
SELECT d.name, COUNT(a.appointment_id) AS total_patients
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name;
