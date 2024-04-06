-- Create Database
CREATE DATABASE CapStone;

-- Create Table: Login
CREATE TABLE Login (
    Username VARCHAR(50),
    Password VARCHAR(50),
    person_id SERIAL PRIMARY KEY,
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

-- Create Table: Person
CREATE TABLE Person (
    person_id SERIAL PRIMARY KEY,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    email VARCHAR(100),
    homeless_reason TEXT
);

-- Create Table: Phone_contact
CREATE TABLE Phone_contact (
    person_id SERIAL,
    Contact_type_id INT,
    Contact VARCHAR(20),
    Description TEXT,
    FOREIGN KEY (person_id) REFERENCES Person(person_id),
    FOREIGN KEY (Contact_type_id) REFERENCES Contact_type(contact_type_id)
);

-- Create Table: Contact_type
CREATE TABLE Contact_type (
    contact_type_id SERIAL PRIMARY KEY,
    contact_type_title VARCHAR(50)
);

-- Create Table: Disease
CREATE TABLE Disease (
    disease_id SERIAL PRIMARY KEY,
    disease_title VARCHAR(100)
);

-- Create Table: Person_health
CREATE TABLE Person_health (
    person_health_id SERIAL PRIMARY KEY,
    person_id INT,
    disease_id INT,
    FOREIGN KEY (person_id) REFERENCES Person(person_id),
    FOREIGN KEY (disease_id) REFERENCES Disease(disease_id)
);

-- Create Table: Necessities
CREATE TABLE Necessities (
    necessity_id SERIAL PRIMARY KEY,
    necessity_title VARCHAR(100)
);

-- Create Table: Person_necessities
CREATE TABLE Person_necessities (
    person_id INT,
    necessity_id INT,
    FOREIGN KEY (person_id) REFERENCES Person(person_id),
    FOREIGN KEY (necessity_id) REFERENCES Necessities(necessity_id)
);

-- Create Table: Person_location
CREATE TABLE Person_location (
    person_id INT,
    lat FLOAT,
    long FLOAT,
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

-- Create Table: Organization_sector
CREATE TABLE Organization_sector (
    organization_sector_id SERIAL PRIMARY KEY,
    organization_sector_title VARCHAR(100)
);

-- Create Table: Organization
CREATE TABLE Organization (
    organization_id SERIAL PRIMARY KEY,
    organization_title VARCHAR(100),
    organization_sector_id INT,
    FOREIGN KEY (organization_sector_id) REFERENCES Organization_sector(organization_sector_id)
);
