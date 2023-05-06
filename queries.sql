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

-- Animals belonging to Melody Pond
SELECT a.id AS animal_id, a.name AS animal_name, o.id AS owner_id, o.full_name AS owner_name
FROM animals a
INNER JOIN owners o
ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- All animals that are pokemon 
SELECT a.id AS animal_id, a.name AS animal_name, s.id AS species_id, s.name AS species_name
FROM animals a
INNER JOIN species s
ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- All owners and their animals, including those that don't own any animal.
SELECT a.id AS animal_id, a.name AS animal_name, o.id AS owner_id, o.full_name AS owner_name
FROM animals a
RIGHT JOIN owners o
ON a.owner_id = o.id;

-- Number of animals per species
SELECT s.name AS species_name, COUNT(*)
FROM animals a
INNER JOIN species s
ON a.species_id = s.id
GROUP BY s.name;

-- All Digimon owned by Jennifer Orwell
SELECT a.name AS animal_name, s.name AS species_name, o.full_name AS owner
FROM animals a
INNER JOIN species s
ON a.species_id = s.id
INNER JOIN owners o
ON a.owner_id = o.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- All animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name AS animal_name, a.escape_attempts, o.full_name AS owner_name
FROM animals a
INNER JOIN owners o
ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Owner with most pets
SELECT o.full_name AS owner_name, COUNT(*) as animal_count
FROM owners o
INNER JOIN animals a
ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC;

--  Last animal seen by William Tatcher
SELECT  animals.name AS animal_name, date_of_visit, vets.name AS vets_name FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC LIMIT 1;

-- Count of different animals seen by Stephanie Mendez
SELECT vets.name AS vet_name, COUNT(*) AS visit_count FROM vets
JOIN visits ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id 
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- All vets and there specializations
SELECT vets.name AS vet_name, species.name AS species_name FROM vets 
FULL JOIN specializations ON specializations.vet_id = vets.id
LEFT JOIN species ON specializations.species_id = species.id;

-- All animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name AS vet_name, a.name AS animal_name, date_of_visit FROM visits
JOIN animals a ON visits.animal_id = a.id 
JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- Animal with the most visits to vets
SELECT name, COUNT(*) AS visit_count FROM animals a 
JOIN visits v ON a.id = visits.animal_id 
GROUP BY a.name 
ORDER BY visit_count 
DESC LIMIT 1;

-- Maisy Smith's first visit
SELECT a.name AS animal_name, vets.name AS vets_name, date_of_visit FROM visits 
JOIN vets ON visits.vet_id = vets.id 
JOIN animals a ON visits.animal_id = a.id 
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.*, vets.*, date_of_visit FROM visits
JOIN animals a ON visits.animal_id = a.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY date_of_visit
DESC LIMIT 1;

-- Number of visits with a vet that did not specialize in that animal's species.
SELECT COUNT(*) FROM visits
FULL OUTER JOIN vets ON visits.vet_id = vets.id
FULL OUTER JOIN specializations ON specializations.vet_id = vets.id
WHERE species_id IS NULL;

-- Species most visited by Maisy Smith.
SELECT COUNT(species.name), species.name FROM visits
JOIN animals a ON visits.animal_id = a.id 
JOIN species ON a.species_id = species.id 
JOIN vets ON visits.vet_id = vets.id 
WHERE vet_id = 2 
GROUP BY(species.name) 
LIMIT 1;
