/*Queries that provide answers to the questions from all projects.*/

-- first query 

SELECT * FROM animals WHERE name LIKE '%mon';

-- second query

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- 3rd query

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- 4th query

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- 5th query

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- sixth query

SELECT * FROM animals WHERE neutered = true;

-- 7th query

SELECT * FROM animals WHERE name != 'Gabumon';

-- 8th query

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;