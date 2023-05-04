/* Create database vet_clinic; */
CREATE DATABASE vet_clinic;

/* Create table animals */
CREATE TABLE animals (
    id INTEGER,
    name VARCHAR(255),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2)
);

/* Project 2 - Add species column to animals table */
ALTER TABLE animals ADD COLUMN species VARCHAR;

