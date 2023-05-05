-- Insert data in owners table.
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34);

INSERT INTO owners (full_name, age)
VALUES ('Jennifer Orwell',19);

INSERT INTO owners (full_name, age)
VALUES ('Bob',45);

INSERT INTO owners (full_name, age)
VALUES ('Melody Pond',77);

INSERT INTO owners (full_name, age)
VALUES ('Dean Winchester',14);

INSERT INTO owners (full_name, age)
VALUES ('Jodie Whittaker',38);

-- insert data in species table
INSERT INTO species (name) 
VALUES ('Pokemon');

INSERT INTO species (name)
VALUES ('Digimon');

-- For all animals ending with 'mon' in animals table, modify species_id value to be id of Digimon in species table.
 UPDATE animals
 SET species_id = (
  SELECT id from species
  WHERE name = 'Digimon')
 WHERE name LIKE '%mon';

-- For all animals with NULL value in animals table, modify species_id value to be id of Pokemon in species table.
 UPDATE animals
 SET species_id = (
  SELECT id FROM species
  WHERE name = 'Pokemon')
 WHERE species_id is NULL;

-- Modify owner_id to match corresponding ids from owners table.
UPDATE animals
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Jennifer Orwell'
)
WHERE name = 'Pikachu';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Bob'
)
WHERE name = 'Plantmon';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Melody Pond'
)
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Dean Winchester'
)
WHERE name = 'Angemon' OR name = 'Boarmon';
