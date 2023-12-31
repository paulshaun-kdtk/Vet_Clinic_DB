/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Agumon', '2020-02-03', 0, true, 10.23),
    ('Gabumon', '2018-11-15', 2, true, 8),
    ('Pikachu', '2021-01-07', 1, false, 15.04),
    ('Devimon', '2017-05-12', 5, true, 11);

--  day 2 data update

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
    (1, 'Charmander', '2020-02-08', 0, FALSE, -11, NULL),
    (2, 'Plantmon', '2021-11-15', 2, TRUE, -5.7, NULL),
    (3, 'Squirtle', '1993-04-02', 3, FALSE, -12.13, NULL),
    (4, 'Angemon', '2005-06-12', 1, TRUE, -45, NULL),
    (5, 'Boarmon', '2005-06-07', 7, TRUE, 20.4, NULL),
    (6, 'Blossom', '1998-10-13', 3, TRUE, 17, NULL),
    (7, 'Ditto', '2022-05-14', 4, TRUE, 22, NULL);

-- day 3 data update

INSERT INTO owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES
  ('Pokemon'),
  ('Digimon');

UPDATE animals
SET species_id = (CASE 
                    WHEN name ILIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
                    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
                 END);

UPDATE animals
SET owner_id = (CASE 
                    WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
                    WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
                    WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
                    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
                    WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
                 END);

