# Clinic Management Database System

## Project Description
This project implements a comprehensive clinic management system database using MySQL. It models a complete healthcare clinic with patients, doctors, appointments, medical records, prescriptions, billing, and more.

## How to Setup/Run
1. Clone this repository
2. Import the SQL file into your MySQL server
3. Uncomment the CREATE DATABASE and USE statements at the top of the file if you want to create a new database

## Entity Relationship Diagram (ERD)
The ERD is available in two formats:
1. PlantUML format (clinic_management_erd.puml)
2. DBML format (clinic_management.dbml) - Can be pasted into [dbdiagram.io](https://dbdiagram.io) to generate a visual diagram

## Database Schema
The database includes the following tables:

- Patients: Core patient demographic information
- Doctors: Physician information and specializations
- Appointments: Scheduled visits linking patients and doctors
- MedicalRecords: Patient health data collected during visits
- And more...

This database fully implements all required constraints including Primary Keys, Foreign Keys, and appropriate data validation.
