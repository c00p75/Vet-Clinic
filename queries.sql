/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/12/31'; 

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = True AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name =  'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg < 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = True;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Start a transaction block
BEGIN;

-- Set species column to unspecified
UPDATE animals SET species = 'unspecified';

-- Verify change
SELECT species FROM animals;

-- Roll back the change
ROLLBACK;

-- Verify Roll back
SELECT species FROM animals;

-- Start a transaction block
BEGIN;

-- Set species column to digimon for all animals that have a name ending in mon
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Set species column to pokemon for all animals that don't have species already set.
Update animals SET species = 'pokemon' WHERE species IS NULL;

-- Save changes invoked by a transaction
COMMIT;

-- Verify updates
SELECT species FROM animals;

-- Start stransaction
BEGIN;

-- delete all records in the animals table
DELETE FROM animals;

-- Roll back changes in transaction
ROLLBACK;

-- Verify roll back
SELECT * FROM animals;

-- Start transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022/01/01';

-- Create savepoint
SAVEPOINT s1;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO s1;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Save changes invoked by a transaction
COMMIT;

-- Verify that change was made and persists after commit
SELECT * FROM animals;

-- Animals count
SELECT COUNT(*) FROM animals;

-- Count animals that have never tried to escape.
SELECT COUNT(escape_attempts) FROM animals 
WHERE escape_attempts = 0;

-- Average weight of animals.
SELECT AVG(weight_kg) AS average_weight FROM animals;

-- Most escapes amoung neutered and not neutered animals.
SELECT neutered, MAX(escape_attempts) AS highest_escape_attempts FROM animals 
GROUP BY neutered;

-- Minimum and maximum weight of each type of animal.
SELECT species, MAX(weight_kg) AS max_wieght, MIN(weight_kg) AS min_wieght FROM animals 
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals 
WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/12/31'
GROUP BY species;