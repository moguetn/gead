-- Colons are used to denote use of variables :variable:
-- Intersection table inserts will allow user to search for and select names and backend will retrieve respective IDs.


-- COUNTRIES TABLE -----------------------------------------------

-- Populate
SELECT * FROM Countries;

-- Add new country
INSERT INTO Countries (countryName, globalRegion, population, GDP)
VALUES (:inputName:, :inputRegion:, :inputPopulation:, :inputGDP:);

-- Update country
UPDATE Countries
SET countryName = :inputName:, globalRegion = :inputRegion:, population = :inputPopulation:, GDP = :inputGDP:
WHERE countryID = :countryIDforSelectedEntry:;

-- Delete country
DELETE FROM Countries
WHERE countryID = :countryIDforSelectedEntry:



-- ENERGY_TYPES TABLE ----------------------------------------------

-- Populate
SELECT * FROM Energy_Types;

-- Add new energy type
INSERT INTO Energy_Types (energyName, emissionsRate, deathRate)
VALUES (:inputName:, :inputEmissionsRate:, :inputDeathRate:);

-- Update energy type
UPDATE Energy_Types
SET energyName = :inputName:, emissionsRate = :inputEmissionsRate:, deathRate = :inputDeathRate:
WHERE energyTypeID = :energyIDforSelectedEntry:;

-- Delete energy type
DELETE FROM Energy_Types
WHERE countryID = :countryIDforSelectedEntry:


-- CONSUMERS TABLE -------------------------------------------------------------

-- Populate
SELECT Consumers.municipality, Consumers.population, Consumers.annualConsumption
FROM Consumers;

-- Add new consumer
INSERT INTO Consumers (municipality, population, annualConsumption)
VALUES (:inputMunicipality:, :inputPop:, :inputConsumption:);

-- Update consumer
UPDATE Consumers
SET municipality = :inputMunicipality:, population = :inputPop:, annualConsumption = :inputConsumption:
WHERE consumerID = :consumerIDforSelectedEntry:;

-- Delete country
DELETE FROM Consumers
WHERE consumerID = :consumerIDforSelectedEntry:




-- PROVIDERS TABLE --------------------------------------------------

-- Populate
SELECT Providers.providerName, Providers.orgType
FROM Providers;

-- Add new provider
INSERT INTO Providers (providerName, orgType)
VALUES (:inputName:, :inputOrgType:);

-- Update provider
UPDATE Providers
SET providerName = :inputName:, orgType = :inputOrgType:
WHERE providerID = :providerIDforSelectedEntry:;

-- Delete provider - will make FKs for Provider NULL via CASCADE
DELETE FROM Providers
WHERE providerID = :providerIDforSelectedEntry:;



-- NATIONAL_OPERATIONS TABLE --------------------------------------------

-- Populate
SELECT Providers.providerName, Countries.countryName
FROM Providers
	INNER JOIN National_Operations ON Providers.providerID = National_Operations.providerID
	INNER JOIN Countries ON National_Operations.countryID = Countries.countryID;
    
-- Add new national operation
INSERT INTO National_Operations (providerID, countryID)
VALUES (:IDforInputProviderName:, :IDforInputCountryName:);
    
-- Update national operation
UPDATE National_Operations
SET providerID = :providerIDforEnteredProviderName:, countryID = :countryIDforEnteredCountryName:
WHERE 
	countryID = :countryIDforSelectedEntry:,
    providerID = :providerIDforSelectedEntry:;
    
-- Delete national operation
DELETE FROM National_Operations
WHERE
	countryID = :countryIDforSelectedEntry:,
    providerID = :providerIDforSelectedEntry:;
    
    
-- PROVIDER_ENERGY_TYPES TABLE ------------------------------------------------------------------

-- Populate
SELECT Providers.providerName, Energy_Types.energyTypeName
FROM Providers
	INNER JOIN Provider_Energy_Types ON Providers.providerID = Provider_Energy_Types.providerID
	INNER JOIN Energy_Types ON Provider_Energy_Types.energyTypeID = Energy_Types.energyTypeID;
    
-- Add new provider energy type
INSERT INTO Provider_Energy_Types (providerID, energyTypeID)
VALUES (:IDforInputProviderName:, :IDforInputEnergyType:);


-- Update provider energy type
UPDATE Provider_Energy_Types
SET providerID = :providerIDforEnteredProviderName:, energyTypeID = :IDforInputEnergyType:
WHERE 
	energyTypeID = :energyTypeIDforSelectedEntry:,
    providerID = :providerIDforSelectedEntry:;
    
-- Delete provider energy type
DELETE FROM Provider_Energy_Types
WHERE 
	energyTypeID = :energyTypeIDforSelectedEntry:,
    providerID = :providerIDforSelectedEntry:;
    

-- ENERGY_PROVISIONS TABLE ----------------------------------------------------------------

-- Populate
SELECT Providers.providerName, Consumers.consumerName, Energy_Types.energyTypeName
FROM Providers
	INNER JOIN Providers ON Energy_Provisions.providerID = Providers.providerID
    INNER JOIN Consumers ON Energy_Provisions.consumerID = Consumerss.consumerID
	INNER JOIN Energy_Types ON Energy_Provisions.energyTypeID = Energy_Types.energyTypeID;
    
-- Add new energy provision record -- Provider can be NULL
INSERT INTO Energy_Provisions (providerID, consumerID, energyTypeID)
VALUES (:IDforInputProviderName:, :IDforInputConsumerID:, :IDforInputEnergyType:);

-- Update energy provision -- Provider can be set to NULL
UPDATE Energy_Provisions
SET providerID = :providerIDforEnteredProviderName:, consumersID = :consumerIDforEnteredCountryName:, energyTypeIDforEneteredEnergyTypeName:
WHERE 
    providerID = :providerIDforSelectedEntry:,
	consumerID = :consumerIDforSelectedEntry:,
    energyTypeID = :energyTypeIDforSelectedEntry:;   

-- Delete energy provision    
DELETE FROM Energy_Provisions
WHERE 
	providerID = :providerIDforSelectedEntry:,
	consumerID = :consumerIDforSelectedEntry:,
    energyTypeID = :energyTypeIDforSelectedEntry:;    
    





