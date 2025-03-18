DROP SCHEMA IF EXISTS `hospital`;
CREATE SCHEMA `hospital`;
USE `hospital`;

-- Branch Table
CREATE TABLE `branch` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL,
  `address` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Login Table
CREATE TABLE `login` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(30) NOT NULL UNIQUE,
  `password` VARCHAR(25) NOT NULL,
  `role` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Patients Table
CREATE TABLE `patients` (
  `patient_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `gender` ENUM('Male', 'Female', 'Other') NOT NULL,
  `address` VARCHAR(255),
  `age` INT CHECK (age >= 0),
  `phone_number` VARCHAR(15) UNIQUE NOT NULL,
  `email` VARCHAR(100) UNIQUE,
  `branch` INT NOT NULL,
  FOREIGN KEY (`branch`) REFERENCES `branch`(`id`)
);

-- Diagnosis Table
CREATE TABLE `diagnosis` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `diagnosis` VARCHAR(255) NOT NULL
);

-- Patients OPD History Table
CREATE TABLE `patients_opd_history` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `seen_by_doctor` VARCHAR(255) NOT NULL,
  `diagnosis_id` BIGINT,
  `treatment` VARCHAR(500) NULL DEFAULT NULL,
  `bill` DECIMAL(10,2) NOT NULL,
  `pending_amount` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `bill_status` ENUM('Paid', 'Pending') NOT NULL DEFAULT 'Pending',
  `date_of_treatment` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `treatment_Date` DATE NULL,
  `payment_type` ENUM('Cash', 'Credit Card', 'UPI', 'Insurance') NOT NULL DEFAULT 'Cash',
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`patient_id`) REFERENCES `patients`(`patient_id`) ON DELETE CASCADE,
  FOREIGN KEY (`diagnosis_id`) REFERENCES `diagnosis`(`id`)
);

-- Admit Patient Table (Updated)
CREATE TABLE `admit_patient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `admit_Date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `patient_id` INT NOT NULL,
  `mLC_No` INT,
  `IPD_No` INT,
  `consultant` VARCHAR(45),
  `diagnosis` VARCHAR(255),
  `clinical_History` VARCHAR(255),
  `amount_paid` DECIMAL(10,2) DEFAULT 0,
  `amount_tobepaid` DECIMAL(10,2) DEFAULT 0,
  `discharged_at` DATETIME NULL,
  `Admit_And_Discharge_Status` ENUM('Admitted', 'Discharged') NOT NULL DEFAULT 'Admitted',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`patient_id`) REFERENCES `patients`(`patient_id`) ON DELETE CASCADE
);

-- Discharge Patient Table
CREATE TABLE `discharge_patient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mLC_No` INT NOT NULL,
  `IPD_No` INT NOT NULL,
  `consultant` VARCHAR(45) NOT NULL,
  `diagnosis` VARCHAR(255) NOT NULL,
  `clinical_History` VARCHAR(255) NOT NULL,
  `admit_Patient_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`patient_id`) REFERENCES `patients`(`patient_id`) ON DELETE CASCADE,
  FOREIGN KEY (`admit_Patient_id`) REFERENCES `admit_patient`(`id`) ON DELETE CASCADE
);

-- Treatment Details Table (New)
CREATE TABLE `treatment_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `admittance_id` INT DEFAULT NULL,
  `medicine_name` VARCHAR(32) NOT NULL,
  `medicine_time` VARCHAR(128) NOT NULL,
  `treatment_date` DATE NOT NULL,
  `bill` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `bill_paid` ENUM('Paid', 'Unpaid') NOT NULL DEFAULT 'Unpaid',
  `payment_mode` ENUM('Cash', 'Credit Card', 'UPI', 'Insurance') NOT NULL DEFAULT 'Cash',
  `created_by` VARCHAR(32) NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);