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

-- Insert data into vets table
INSERT INTO vets ( name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23');

INSERT INTO vets ( name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, '2019-01-17');

INSERT INTO vets ( name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, '1981-05-04');

INSERT INTO vets ( name, age, date_of_graduation)   
VALUES ('Jack Harkness', 38, '2008-06-08');

-- Insert data into specializations table
INSERT INTO specializations (species_id, vet_id)
VALUES (
      (SELECT id FROM species WHERE name = 'Pokemon'),
      (SELECT id FROM vets WHERE name = 'William Tatcher')
  );

INSERT INTO specializations (species_id, vet_id)
VALUES (
        (SELECT id FROM species WHERE name = 'Pokemon'),
        (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
    ),
    (
        (SELECT id FROM species WHERE name = 'Digimon'),
        (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
    );

INSERT INTO specializations (species_id, vet_id)
VALUES (
        (SELECT id FROM species WHERE name = 'Digimon'),
        (SELECT id FROM vets WHERE name = 'Jack Harkness')
  );

-- Insert data for visits
INSERT INTO visits (animal_id, vet_id,  date_of_visit)
VALUES (
        (SELECT id FROM animals WHERE name = 'Agumon'),
        (SELECT id FROM vets WHERE name = 'William Tatcher'),
        '2020-05-24'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Agumon'),
        (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
        '2020-07-22'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Gabumon'),
        (SELECT id FROM vets WHERE name = 'Jack Harkness'),
        '2021-02-02'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Pikachu'),
        (SELECT id FROM vets WHERE name = 'Maisy Smith'),
        '2020-01-05'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Pikachu'),
        (SELECT id FROM vets WHERE name = 'Maisy Smith'),
        '2020-03-08'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Pikachu'),
        (SELECT id FROM vets WHERE name = 'Maisy Smith'),
        '2020-05-14'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Devimon'),
        (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
        '2021-05-04'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Charmander'),
        (SELECT id FROM vets WHERE name = 'Jack Harkness'),
        '2021-02-24'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Plantmon'),
        (SELECT id FROM vets WHERE name = 'Maisy Smith'),
        '2019-12-21'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Plantmon'),
        (SELECT id FROM vets WHERE name = 'William Tatcher'),
        '2020-08-10'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Plantmon'),
        (SELECT id FROM vets WHERE name = 'Maisy Smith'),
        '2021-04-07'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Squirtle'),
        (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
        '2019-09-29'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Angemon'),
        (SELECT id FROM vets WHERE name = 'Jack Harkness'),
        '2020-10-03'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Angemon'),
        (SELECT id FROM vets WHERE name = 'Jack Harkness'),
        '2020-11-04'
    ),
    (
        (SELECT id FROM animals WHERE name = 'Boarmon'),
        (SELECT id FROM vets WHERE name = 'Maisy Smith'),
        '2019-01-24'
    ),
     (
        (SELECT id FROM animals WHERE name = 'Boarmon'),
        (SELECT id FROM vets WHERE name = 'Maisy Smith'),
        '2019-05-15'
    ),
     (
        (SELECT id FROM animals WHERE name = 'Boarmon'),
        (SELECT id FROM vets WHERE name = 'Maisy Smith'),
        '2020-02-27'
    ),
     (
        (SELECT id FROM animals WHERE name = 'Boarmon'),
        (SELECT id FROM vets WHERE name = 'Maisy Smith'),
        '2020-08-03'
    ),
     (
        (SELECT id FROM animals WHERE name = 'Blossom'),
        (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
        '2020-05-24'
    ),
     (
        (SELECT id FROM animals WHERE name = 'Blossom'),
        (SELECT id FROM vets WHERE name = 'William Tatcher'),
        '2021-01-11'
    );
