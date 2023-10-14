/*Queries that provide answers to the questions from all projects.*/

-- Day 1

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Day 2 (transactions)

        -- Species first transaction
BEGIN TRANSACTION;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


        -- species second transaction

BEGIN TRANSACTION;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;


        -- deletion transaction
        
BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;



                                    -- # Questions: 

-- How many animals are there?
-- How many animals have never tried to escape?
-- What is the average weight of animals?
-- Who escapes the most, neutered or not neutered animals?
-- What is the minimum and maximum weight of each type of animal?
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

                                    -- #Queres:

-- 1
SELECT COUNT(*) AS total_animals
FROM animals;

-- 2
SELECT COUNT(*) AS animals_without_escape_attempts
FROM animals
WHERE escape_attempts = 0;

-- 3
SELECT AVG(weight_kg) AS average_weight
FROM animals;

-- 4
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY total_escape_attempts DESC
LIMIT 1;

-- 5
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- 6
SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

--  day 3 queries

                -- # Questions:

-- What animals belong to Melody Pond?
-- List of all animals that are pokemon (their type is Pokemon).
-- List all owners and their animals, remember to include those that don't own any animal.
-- How many animals are there per species?
-- List all Digimon owned by Jennifer Orwell.
-- List all animals owned by Dean Winchester that haven't tried to escape.
-- Who owns the most animals?

-- 1
SELECT * FROM animals
WHERE owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Melody Pond'
);

-- 2
SELECT * FROM animals
WHERE species_id = (
  SELECT id FROM species
  WHERE name = 'Pokemon'
);

-- 3
SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- 4
SELECT species.name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

-- 5
SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- 6
SELECT * FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- 7
SELECT owners.full_name, COUNT(animals.id) AS animal_count
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;