/*
Entity Relationship Diagram (ERD) for Clinic Management System:

+----------------+       +----------------+       +----------------+
|    Patients    |       |  Appointments  |       |    Doctors     |
+----------------+       +----------------+       +----------------+
| patient_id (PK)|<----->| patient_id (FK)|       | doctor_id (PK) |
| first_name     |       | doctor_id (FK) |<----->| first_name     |
| last_name      |       | appointment_id |       | last_name      |
| date_of_birth  |       | appointment_date|      | specialization |
| gender         |       | status         |       | phone          |
| phone          |       | reason         |       | email          |
| email          |       +----------------+       | hire_date      |
| address        |               |                | is_active      |
| insurance_id   |               |                +----------------+
| reg_date       |               |
+----------------+               |
        |                        |
        |                        |
+----------------+       +----------------+       +----------------+
| MedicalRecords |       |  Diagnoses     |       | Prescriptions  |
+----------------+       +----------------+       +----------------+
| record_id (PK) |       | diagnosis_id   |       | prescription_id|
| patient_id (FK)|<----->| record_id (FK) |       | record_id (FK) |
| appointment_id |       | condition_name |       | doctor_id (FK) |
| height         |       | description    |       | medication_id  |
| weight         |       | diagnosis_date |       | dosage         |
| blood_type     |       +----------------+       | frequency      |
| allergies      |                                | start_date     |
+----------------+                                | end_date       |
        |                                         +----------------+
        |                                                 |
        |                                                 |
+----------------+       +----------------+       +----------------+
| LabTests       |       | Medications    |       | Billing        |
+----------------+       +----------------+       +----------------+
| test_id (PK)   |       | medication_id  |       | bill_id (PK)   |
| patient_id (FK)|       | name           |       | patient_id (FK)|
| doctor_id (FK) |       | manufacturer   |       | insurance_id   |
| test_name      |       | dosage_form    |       | appointment_id |
| test_date      |       | stock_quantity |       | total_amount   |
| results        |       +----------------+       | payment_status |
| status         |                                | due_date       |
+----------------+                                +----------------+

+----------------+       +----------------+       +----------------+
| InsuranceProv  |       | DoctorSchedules|       | Staff          |
+----------------+       +----------------+       +----------------+
| insurance_id   |       | schedule_id    |       | staff_id (PK)  |
| provider_name  |       | doctor_id (FK) |       | first_name     |
| policy_number  |       | day_of_week    |       | last_name      |
| coverage_details|      | start_time     |       | role           |
+----------------+       | end_time       |       | phone          |
                         | is_available   |       | email          |
                         +----------------+       | hire_date      |
                                                  +----------------+

Legend:
PK = Primary Key
FK = Foreign Key
---> = One-to-Many Relationship
<---> = Many-to-Many Relationship
*/

-- Create the Clinic Database
-- CREATE DATABASE ClinicManagement;
-- USE ClinicManagement;

-- 1. Patients Table (Core patient information)
-- CREATE TABLE Patients (
--     patient_id INT PRIMARY KEY AUTO_INCREMENT,
--     first_name VARCHAR(50) NOT NULL,
--     last_name VARCHAR(50) NOT NULL,
--     date_of_birth DATE NOT NULL,
--     gender ENUM('Male', 'Female', 'Other') NOT NULL,
--     phone VARCHAR(20),
--     email VARCHAR(100),
--     address TEXT,
--     insurance_id VARCHAR(50),
--     registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
-- );

-- 2. Doctors Table (Clinic doctors)
-- CREATE TABLE Doctors (
--     doctor_id INT PRIMARY KEY AUTO_INCREMENT,
--     first_name VARCHAR(50) NOT NULL,
--     last_name VARCHAR(50) NOT NULL,
--     specialization VARCHAR(100) NOT NULL,
--     phone VARCHAR(20),
--     email VARCHAR(100),
--     hire_date DATE,
--     is_active BOOLEAN DEFAULT TRUE
-- );

-- 3. Appointments Table (Links Patients & Doctors)
-- CREATE TABLE Appointments (
--     appointment_id INT PRIMARY KEY AUTO_INCREMENT,
--     patient_id INT NOT NULL,
--     doctor_id INT NOT NULL,
--     appointment_date DATETIME NOT NULL,
--     status ENUM('Scheduled', 'Completed', 'Cancelled', 'No-Show') DEFAULT 'Scheduled',
--     reason TEXT,
--     FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
--     FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
-- );

-- 4. MedicalRecords Table (Patient health history)
-- CREATE TABLE MedicalRecords (
--     record_id INT PRIMARY KEY AUTO_INCREMENT,
--     patient_id INT NOT NULL,
--     appointment_id INT UNIQUE, -- 1:1 with Appointments
--     height DECIMAL(5,2), -- in cm
--     weight DECIMAL(5,2), -- in kg
--     blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
--     allergies TEXT,
--     FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
--     FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
-- );

-- 5. Diagnoses Table (Medical conditions)
-- CREATE TABLE Diagnoses (
--     diagnosis_id INT PRIMARY KEY AUTO_INCREMENT,
--     record_id INT NOT NULL,
--     condition_name VARCHAR(100) NOT NULL,
--     description TEXT,
--     diagnosis_date DATE DEFAULT (CURRENT_DATE),
--     FOREIGN KEY (record_id) REFERENCES MedicalRecords(record_id)
-- );

-- 6. Medications Table (Available drugs)
-- CREATE TABLE Medications (
--     medication_id INT PRIMARY KEY AUTO_INCREMENT,
--     name VARCHAR(100) NOT NULL,
--     manufacturer VARCHAR(100),
--     dosage_form ENUM('Tablet', 'Capsule', 'Liquid', 'Injection', 'Topical'),
--     stock_quantity INT DEFAULT 0
-- );

-- 7. Prescriptions Table (Doctors prescribe meds)
-- CREATE TABLE Prescriptions (
--     prescription_id INT PRIMARY KEY AUTO_INCREMENT,
--     record_id INT NOT NULL,
--     doctor_id INT NOT NULL,
--     medication_id INT NOT NULL,
--     dosage VARCHAR(50) NOT NULL,
--     frequency VARCHAR(50) NOT NULL,
--     start_date DATE,
--     end_date DATE,
--     FOREIGN KEY (record_id) REFERENCES MedicalRecords(record_id),
--     FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
--     FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
-- );

-- 8. InsuranceProviders Table (Patient insurance)
-- CREATE TABLE InsuranceProviders (
--     insurance_id INT PRIMARY KEY AUTO_INCREMENT,
--     provider_name VARCHAR(100) NOT NULL,
--     policy_number VARCHAR(50),
--     coverage_details TEXT
-- );

-- 9. Billing Table (Patient invoices)
-- CREATE TABLE Billing (
--     bill_id INT PRIMARY KEY AUTO_INCREMENT,
--     patient_id INT NOT NULL,
--     insurance_id INT,
--     appointment_id INT,
--     total_amount DECIMAL(10,2) NOT NULL,
--     payment_status ENUM('Paid', 'Pending', 'Insurance Claim') DEFAULT 'Pending',
--     due_date DATE,
--     FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
--     FOREIGN KEY (insurance_id) REFERENCES InsuranceProviders(insurance_id),
--     FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
-- );

-- 10. DoctorSchedules Table (Doctor availability)
-- CREATE TABLE DoctorSchedules (
--     schedule_id INT PRIMARY KEY AUTO_INCREMENT,
--     doctor_id INT NOT NULL,
--     day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
--     start_time TIME NOT NULL,
--     end_time TIME NOT NULL,
--     is_available BOOLEAN DEFAULT TRUE,
--     FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
-- );

-- 11. Staff Table (Non-doctor employees)
-- CREATE TABLE Staff (
--     staff_id INT PRIMARY KEY AUTO_INCREMENT,
--     first_name VARCHAR(50) NOT NULL,
--     last_name VARCHAR(50) NOT NULL,
--     role ENUM('Nurse', 'Receptionist', 'Lab Technician', 'Admin') NOT NULL,
--     phone VARCHAR(20),
--     email VARCHAR(100),
--     hire_date DATE
-- );

-- 12. LabTests Table (Medical tests)
-- CREATE TABLE LabTests (
--     test_id INT PRIMARY KEY AUTO_INCREMENT,
--     patient_id INT NOT NULL,
--     doctor_id INT NOT NULL,
--     test_name VARCHAR(100) NOT NULL,
--     test_date DATE DEFAULT (CURRENT_DATE),
--     results TEXT,
--     status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
--     FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
--     FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
-- );

-- Enable the database
-- USE ClinicManagement;

-- 1. Insert Patients
-- INSERT INTO Patients (first_name, last_name, date_of_birth, gender, phone, email, address, insurance_id)
-- VALUES
-- ('John', 'Smith', '1985-04-12', 'Male', '555-0101', 'john.smith@email.com', '123 Main St, Anytown', 'INS-1001'),
-- ('Sarah', 'Johnson', '1990-07-25', 'Female', '555-0102', 'sarah.j@email.com', '456 Oak Ave, Somewhere', 'INS-1002'),
-- ('Michael', 'Williams', '1978-11-30', 'Male', '555-0103', 'michael.w@email.com', '789 Pine Rd, Nowhere', 'INS-1003'),
-- ('Emily', 'Brown', '1995-02-14', 'Female', '555-0104', 'emily.b@email.com', '321 Elm St, Anywhere', 'INS-1004'),
-- ('David', 'Jones', '1982-09-08', 'Male', '555-0105', 'david.j@email.com', '654 Maple Dr, Everywhere', NULL);

-- 2. Insert Doctors
-- INSERT INTO Doctors (first_name, last_name, specialization, phone, email, hire_date)
-- VALUES
-- ('Robert', 'Miller', 'Cardiology', '555-0201', 'dr.miller@clinic.com', '2015-06-10'),
-- ('Jennifer', 'Davis', 'Pediatrics', '555-0202', 'dr.davis@clinic.com', '2018-03-15'),
-- ('William', 'Wilson', 'Orthopedics', '555-0203', 'dr.wilson@clinic.com', '2012-11-22'),
-- ('Lisa', 'Taylor', 'Dermatology', '555-0204', 'dr.taylor@clinic.com', '2019-05-30');

-- 3. Insert Appointments
-- INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, reason)
-- VALUES
-- (1, 1, '2023-06-15 09:00:00', 'Completed', 'Annual checkup'),
-- (2, 2, '2023-06-15 10:30:00', 'Completed', 'Child vaccination'),
-- (3, 3, '2023-06-16 11:00:00', 'Completed', 'Knee pain consultation'),
-- (4, 4, '2023-06-16 14:00:00', 'Completed', 'Skin rash examination'),
-- (1, 1, '2023-07-01 10:00:00', 'Scheduled', 'Follow-up on blood pressure'),
-- (5, 2, '2023-07-02 13:30:00', 'Scheduled', 'General consultation');

-- 4. Insert MedicalRecords
-- INSERT INTO MedicalRecords (patient_id, appointment_id, height, weight, blood_type, allergies)
-- VALUES
-- (1, 1, 175.5, 80.2, 'A+', 'Penicillin'),
-- (2, 2, 92.0, 14.5, 'B+', 'Peanuts'),
-- (3, 3, 182.0, 95.0, 'O-', 'None'),
-- (4, 4, 165.0, 62.0, 'AB+', 'Shellfish'),
-- (5, NULL, 178.0, 85.0, 'A-', 'Iodine');

-- 5. Insert Diagnoses
-- INSERT INTO Diagnoses (record_id, condition_name, description, diagnosis_date)
-- VALUES
-- (1, 'Hypertension', 'Stage 1 hypertension, recommend lifestyle changes', '2023-06-15'),
-- (2, 'Vaccination', 'Routine childhood vaccination administered', '2023-06-15'),
-- (3, 'Osteoarthritis', 'Mild osteoarthritis in right knee', '2023-06-16'),
-- (4, 'Contact Dermatitis', 'Allergic reaction to unknown irritant', '2023-06-16'),
-- (1, 'Hyperlipidemia', 'Elevated cholesterol levels noted', '2023-06-15');

-- 6. Insert Medications
-- INSERT INTO Medications (name, manufacturer, dosage_form, stock_quantity)
-- VALUES
-- ('Lisinopril', 'Generic', 'Tablet', 500),
-- ('Amoxicillin', 'Pfizer', 'Capsule', 300),
-- ('Ibuprofen', 'Generic', 'Tablet', 1000),
-- ('Hydrocortisone Cream', 'Johnson & Johnson', 'Topical', 200),
-- ('Diphenhydramine', 'Generic', 'Liquid', 150),
-- ('Simvastatin', 'Merck', 'Tablet', 400);

-- 7. Insert Prescriptions
-- INSERT INTO Prescriptions (record_id, doctor_id, medication_id, dosage, frequency, start_date, end_date)
-- VALUES
-- (1, 1, 1, '10mg', 'Once daily', '2023-06-15', '2023-12-15'),
-- (1, 1, 6, '20mg', 'Once at bedtime', '2023-06-15', NULL),
-- (3, 3, 3, '400mg', 'Every 6 hours as needed', '2023-06-16', '2023-06-30'),
-- (4, 4, 4, '1%', 'Apply twice daily', '2023-06-16', '2023-06-30'),
-- (2, 2, 2, '250mg', 'Three times daily for 10 days', '2023-06-15', '2023-06-25');

-- 8. Insert InsuranceProviders
-- INSERT INTO InsuranceProviders (provider_name, policy_number, coverage_details)
-- VALUES
-- ('Blue Cross', 'BC-1001', 'Full coverage with $20 copay'),
-- ('Aetna', 'AE-2002', '80% coverage after deductible'),
-- ('Medicare', 'MC-3003', 'Full coverage for approved services'),
-- ('United Health', 'UH-4004', '90% coverage with network providers');

-- 9. Insert Billing
-- INSERT INTO Billing (patient_id, insurance_id, appointment_id, total_amount, payment_status, due_date)
-- VALUES
-- (1, 1, 1, 150.00, 'Paid', '2023-07-01'),
-- (2, 2, 2, 85.00, 'Insurance Claim', '2023-07-05'),
-- (3, 3, 3, 200.00, 'Pending', '2023-07-10'),
-- (4, 4, 4, 175.00, 'Paid', '2023-07-08'),
-- (5, NULL, NULL, 120.00, 'Pending', '2023-07-15');

-- 10. Insert DoctorSchedules
-- INSERT INTO DoctorSchedules (doctor_id, day_of_week, start_time, end_time)
-- VALUES
-- (1, 'Monday', '08:00:00', '16:00:00'),
-- (1, 'Wednesday', '08:00:00', '16:00:00'),
-- (2, 'Tuesday', '09:00:00', '17:00:00'),
-- (2, 'Thursday', '09:00:00', '17:00:00'),
-- (3, 'Monday', '10:00:00', '18:00:00'),
-- (3, 'Friday', '08:00:00', '14:00:00'),
-- (4, 'Wednesday', '07:00:00', '15:00:00'),
-- (4, 'Friday', '07:00:00', '15:00:00');

-- 11. Insert Staff
-- INSERT INTO Staff (first_name, last_name, role, phone, email, hire_date)
-- VALUES
-- ('Nancy', 'Anderson', 'Nurse', '555-0301', 'nancy@clinic.com', '2020-01-15'),
-- ('Thomas', 'Martinez', 'Receptionist', '555-0302', 'thomas@clinic.com', '2021-05-20'),
-- ('Jessica', 'Lee', 'Lab Technician', '555-0303', 'jessica@clinic.com', '2019-11-10'),
-- ('Daniel', 'White', 'Admin', '555-0304', 'daniel@clinic.com', '2018-03-01');

-- 12. Insert LabTests
-- INSERT INTO LabTests (patient_id, doctor_id, test_name, test_date, results, status)
-- VALUES
-- (1, 1, 'Blood Panel', '2023-06-15', 'Cholesterol: 220, Triglycerides: 150', 'Completed'),
-- (3, 3, 'X-Ray - Right Knee', '2023-06-16', 'Mild joint space narrowing', 'Completed'),
-- (4, 4, 'Allergy Test', '2023-06-16', NULL, 'Pending'),
-- (2, 2, 'Urinalysis', '2023-06-20', NULL, 'Pending');

-- CODES TO TEST THE DATA.
-- SELECT * FROM MedicalRecords WHERE patient_id = 1;

-- SELECT * FROM Billing WHERE patient_id = 1;

-- SQL JOIN QUERIES
-- SELECT 
--     a.appointment_id,
--     p.first_name AS patient_name,
--     d.first_name AS doctor_name,
--     a.appointment_date,
--     a.status,
--     a.reason
-- FROM Appointments a
-- JOIN Patients p ON a.patient_id = p.patient_id
-- JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- SELECT 
--     b.bill_id,
--     p.first_name AS patient_name,
--     i.provider_name,
--     b.total_amount,
--     b.payment_status,
--     b.due_date
-- FROM Billing b
-- JOIN Patients p ON b.patient_id = p.patient_id
-- LEFT JOIN InsuranceProviders i ON b.insurance_id = i.insurance_id;

-- SELECT 
--     pr.prescription_id,
--     pat.first_name AS patient_name,
--     d.first_name AS doctor_name,
--     m.name AS medication_name,
--     pr.dosage,
--     pr.frequency,
--     pr.start_date,
--     pr.end_date
-- FROM Prescriptions pr
-- JOIN MedicalRecords mr ON pr.record_id = mr.record_id
-- JOIN Patients pat ON mr.patient_id = pat.patient_id
-- JOIN Doctors d ON pr.doctor_id = d.doctor_id
-- JOIN Medications m ON pr.medication_id = m.medication_id;

-- SELECT 
--     lt.test_id,
--     lt.test_name,
--     lt.test_date,
--     lt.status,
--     p.first_name AS patient_name,
--     d.first_name AS doctor_name
-- FROM LabTests lt
-- JOIN Patients p ON lt.patient_id = p.patient_id
-- JOIN Doctors d ON lt.doctor_id = d.doctor_id;

-- SELECT 
--     d.diagnosis_id,
--     pat.first_name AS patient_name,
--     d.condition_name,
--     d.diagnosis_date,
--     a.appointment_date
-- FROM Diagnoses d
-- JOIN MedicalRecords mr ON d.record_id = mr.record_id
-- JOIN Appointments a ON mr.appointment_id = a.appointment_id
-- JOIN Patients pat ON mr.patient_id = pat.patient_id;

-- SELECT 
--     ds.schedule_id,
--     doc.first_name AS doctor_name,
--     ds.day_of_week,
--     ds.start_time,
--     ds.end_time,
--     ds.is_available
-- FROM DoctorSchedules ds
-- JOIN Doctors doc ON ds.doctor_id = doc.doctor_id; 