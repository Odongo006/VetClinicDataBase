/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';
/* Project 1 table animals queries */

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Project 2 - Transactions */
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savePointUpdate;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO savePointUpdate;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/* Project 2 - Queries */
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* Project 3 - JOIN queries */
SELECT name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, animals.species_id, animals.owner_id, species.name as species_name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT name, full_name as owners
SELECT owners.full_name, animals.name
FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;
SELECT species.name, COUNT(animals.name)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name as animals, full_name as owner, species.name as species
FROM animals
JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT name, full_name as owner_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT full_name, COUNT(animals.owner_id)
FROM animals
JOIN owners ON owners.id = animals.owner_id
GROUP BY full_name ORDER BY count DESC LIMIT 1;

/* Project 4 - 'JOIN TABLE' queries */
SELECT animals.name, visits.date_of_visit, vets.name AS vet_name
  FROM animals 
  JOIN visits ON visits.animal_id = animals.id 
  JOIN vets ON vets.id = visits.vet_id 
  WHERE vets.name = 'William Tatcher' 
  ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT COUNT(DISTINCT animals.name) AS animals_checked
  FROM animals 
  JOIN visits ON visits.animal_id = animals.id 
  JOIN vets ON vets.id = visits.vet_id 
  WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name AS vets_name, species.name AS species_name
  FROM vets 
  LEFT JOIN specializations ON vets.id = specializations.vet_id 
  LEFT JOIN species ON species.id = specializations.species_id;

SELECT DISTINCT animals.name AS animal_name, visits.date_of_visit
  FROM animals 
  JOIN visits ON visits.animal_id = animals.id 
  JOIN vets ON vets.id = visits.vet_id 
  WHERE vets.name = 'Stephanie Mendez'
  AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


SELECT animals.name, COUNT(visits.date_of_visit) AS visit_count
  FROM animals JOIN visits ON visits.animal_id = animals.id 
  GROUP BY animals.name 
  ORDER BY visit_count 
  DESC LIMIT 1;

SELECT animals.name, visits.date_of_visit
  FROM animals JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visits.date_of_visit ASC LIMIT 1;

SELECT 
  animals.name As animal_name,
  animals.weight_kg,
  animals.date_of_birth,
  animals.neutered,
  vets.name AS vet_name,
  vets.date_of_graduation,
  visits.date_of_visit
  FROM animals JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON vets.id = visits.vet_id
  ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT COUNT(visits.animal_id) AS non_specialized_visits
  FROM visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  JOIN specializations ON specializations.species_id = vets.id
  WHERE specializations.species_id != animals.species_id;

SELECT species.name, COUNT(visits.animal_id)
  FROM visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  JOIN species ON species.id = animals.species_id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY species.name
  ORDER BY COUNT DESC LIMIT 1; 


  /* Vet clinic database: database performance audit */


  explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;


SELECT COUNT(*) FROM visits where animal_id = 4;

SELECT * FROM visits where vet_id = 2;

SELECT * FROM owners where email = 'owner_18327@mail.com';


EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;


EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;

EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';