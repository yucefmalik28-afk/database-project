-- Drop existing database if needed
DROP DATABASE IF EXISTS Clinic_System;

-- Create and use the database
CREATE DATABASE Clinic_System;
USE Clinic_System;

-- Create Department table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

-- Create Clinic table
CREATE TABLE Clinic (
    ClinicID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Create Doctor table
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20),
    Address VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Create Patient table
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20),
    Address VARCHAR(100),
    BirthDate DATE,
    Job VARCHAR(50)
);

-- Create Appointment table
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    Date DATE,
    PatientID INT,
    DoctorID INT,
    StartTime TIME,
    EndTime TIME,
    Cost DECIMAL(10,2),
    Status VARCHAR(20),
    Diagnosis VARCHAR(100),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- Insert Department data
INSERT INTO Department VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Dermatology'),
(4, 'Orthopedics'),
(5, 'Pediatrics'),
(6, 'General Medicine'),
(7, 'Oncology'),
(8, 'Psychiatry'),
(9, 'Gastroenterology'),
(10, 'Endocrinology');

-- Insert Clinic data
INSERT INTO Clinic VALUES
(101, 'Heart Clinic', '123 Cardio St', 1),
(102, 'Brain Clinic', '456 Neuro Ave', 2),
(103, 'Skin Clinic', '789 Derma Rd', 3),
(104, 'Bone Clinic', '321 Ortho Blvd', 4),
(105, 'Children Clinic', '654 Kids Ln', 5),
(106, 'Family Clinic', '987 Health Dr', 6),
(107, 'Cancer Clinic', '159 Onco Ct', 7),
(108, 'Mind Clinic', '753 Psych Pkwy', 8),
(109, 'Stomach Clinic', '258 Gastro St', 9),
(110, 'Hormone Clinic', '369 Endo Way', 10);

-- Insert Doctor data
INSERT INTO Doctor VALUES
(201, 'Dr. Ayman', '111-1111', 'Cardio Address', 1),
(202, 'Dr. Leila', '222-2222', 'Neuro Address', 2),
(203, 'Dr. Sara', '333-3333', 'Derma Address', 3),
(204, 'Dr. Omar', '444-4444', 'Ortho Address', 4),
(205, 'Dr. Hana', '555-5555', 'Pediatrics Address', 5),
(206, 'Dr. Adel', '666-6666', 'General Address', 6),
(207, 'Dr. Kamal', '777-7777', 'Onco Address', 7),
(208, 'Dr. Rania', '888-8888', 'Psych Address', 8),
(209, 'Dr. Mona', '999-9999', 'Gastro Address', 9),
(210, 'Dr. Youssef', '000-0000', 'Endo Address', 10);

-- Insert Patient data
INSERT INTO Patient VALUES
(12527, 'Ali Ahmed', '0100000000', 'Cairo', '1990-01-01', 'Teacher'),
(12528, 'Sara Youssef', '0100000001', 'Giza', '1985-05-20', 'Engineer'),
(12529, 'Omar Adel', '0100000002', 'Mansoura', '1992-03-15', 'Accountant'),
(12530, 'Maya Fathy', '0100000003', 'Aswan', '1988-07-10', 'Designer'),
(12531, 'Noor Khaled', '0100000004', 'Tanta', '1991-09-25', 'Nurse'),
(12532, 'Ziad Hany', '0100000005', 'Alexandria', '1987-11-30', 'Lawyer'),
(12533, 'Laila Samir', '0100000006', 'Fayoum', '1995-12-05', 'Pharmacist'),
(12534, 'Yara Said', '0100000007', 'Suez', '1993-04-17', 'Banker'),
(12535, 'Tamer Sherif', '0100000008', 'Zagazig', '1989-06-12', 'Driver'),
(12536, 'Huda Mostafa', '0100000009', 'Minya', '1994-08-19', 'Doctor');

-- Insert Appointment data
INSERT INTO Appointment VALUES
(20001, '2023-06-01', 12527, 201, '09:00', '09:30', 100.00, 'Completed', 'Fatty liver'),
(20002, '2024-04-15', 12528, 202, '10:00', '10:30', 80.00, 'Scheduled', 'Migraine'),
(20003, '2024-05-01', 12529, 203, '11:00', '11:30', 70.00, 'Postponed', 'Acne'),
(20004, '2023-12-20', 12530, 204, '13:00', '13:30', 120.00, 'Completed', 'Knee pain'),
(20005, '2022-11-10', 12531, 205, '14:00', '14:30', 90.00, 'Completed', 'Flu'),
(20006, '2024-01-05', 12532, 206, '08:00', '08:30', 60.00, 'Completed', 'Diabetes'),
(20007, '2023-02-14', 12533, 207, '12:00', '12:30', 150.00, 'Completed', 'Cancer'),
(20008, '2022-05-25', 12534, 208, '09:30', '10:00', 110.00, 'Completed', 'Anxiety'),
(20009, '2023-08-18', 12535, 209, '10:30', '11:00', 95.00, 'Completed', 'Ulcer'),
(20010, '2024-03-11', 12536, 210, '15:00', '15:30', 130.00, 'Completed', 'Thyroid');

-- Run required queries

-- 1. Patients diagnosed with 'Fatty liver' in the last year
SELECT Name
FROM Patient
WHERE PatientID IN (
    SELECT PatientID
    FROM Appointment
    WHERE Diagnosis = 'Fatty liver' 
      AND Date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);

-- 2. Addresses of cardiology clinics
SELECT Clinic.Address
FROM Clinic
JOIN Department ON Clinic.DepartmentID = Department.DepartmentID
WHERE Department.Name = 'Cardiology';

-- 3. Total money paid by patient with ID 12527 in the last 3 years
SELECT SUM(Cost) AS TotalPaid
FROM Appointment
WHERE PatientID = 12527 
  AND Date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

-- 4. Sample UPDATE queries
UPDATE Patient
SET Address = 'New Address', PhoneNumber = 'New PhoneNumber'
WHERE PatientID = 12530;

UPDATE Appointment
SET Status = 'Postponed'
WHERE AppointmentID = 20003;

UPDATE Clinic
SET Address = '123 New Clinic Address'
WHERE ClinicID = 101;
