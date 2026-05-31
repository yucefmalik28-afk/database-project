# database-project
Clinic Management System
Project Overview
Clinic Management System Project Overview This project implements a relational database system to manage clinic operations, including *patients, **appointments, **doctors, **clinics, and *departments. It demonstrates *SQL database design, **data population, **queries, and *update triggers to simulate real-world healthcare management.
#  Project Goals
Design and implement a normalized relational database for clinical operations.
Enable efficient CRUD operations (Create, Read, Update, Delete).
Write practical SQL queries for healthcare use cases.
Maintain data integrity using relationships and constraints.
# Database Structure
Entities & Attributes

Department – DepartmentID, Name
Clinic – ClinicID, Name, Address, DepartmentID
Doctor – DoctorID, Name, Phone, Address, DepartmentID
Patient – PatientID, Name, Phone, Address, BirthDate, Job
Appointment – AppointmentID, Date, PatientID, DoctorID, StartTime, EndTime, Cost, Status, Diagnosis
# Relationships
One Department → Many Clinics
One Department → Many Doctors
One Clinic → One Department
One Doctor → Many Appointments
One Patient → Many Appointments
## Data Overview
Sample Data Includes:

10 Departments (e.g., Cardiology, Neurology, Pediatrics, Oncology).
10 Clinics linked to departments.
10 Doctors assigned to departments.
10 Patients with personal details.
10 Appointments with diagnosis, cost, and status.
## Example SQL Queries
# Patients diagnosed with Fatty liver in the last year
sql SELECT Name FROM Patient WHERE PatientID IN ( SELECT PatientID FROM Appointment WHERE Diagnosis = 'Fatty liver' AND Date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) );

# Addresses of Cardiology clinics
sql SELECT Clinic.Address FROM Clinic JOIN Department ON Clinic.DepartmentID = Department.DepartmentID WHERE Department.Name = 'Cardiology';

# Total money paid by patient 12527 in the last 3 years
sql SELECT SUM(Cost) AS TotalPaid FROM Appointment WHERE PatientID = 12527 AND Date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

# Update patient contact information
sql UPDATE Patient SET Address = 'New Address', PhoneNumber = 'New PhoneNumber' WHERE PatientID = 12530;

## Setup Instructions
# Create the database and tables
sql DROP DATABASE IF EXISTS Clinic_System; CREATE DATABASE Clinic_System; USE Clinic_System;

-- Create tables (Department, Clinic, Doctor, Patient, Appointment) -- Add foreign keys and constraints

# Populate with sample data
sql INSERT INTO Department VALUES (1, 'Cardiology'), (2, 'Neurology'), (3, 'Dermatology'), ...;

# Run queries
Test the provided *SELECT, **UPDATE, and *JOIN queries.

# Learning Outcomes
Designing a fully relational database with multiple relationships.
Writing complex SQL queries with joins, subqueries, and aggregates.
Using foreign keys to ensure data integrity.
Populating a database with realistic healthcare data.
🏁 Conclusion
The Clinic Management System demonstrates how a well-designed relational database can simplify medical data management. By combining structured schema design, meaningful relationships, and practical SQL queries, this project offers a scalable solution for real-world clinic operations. Future work could integrate a web-based interface and authentication system to make it production-ready
