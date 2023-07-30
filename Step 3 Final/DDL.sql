DROP TABLE IF EXISTS Countries, Consumers, Energy_Types, Providers, Provider_Energy_Types, National_Operations, Energy_Provisions;

-- Countries Table

CREATE TABLE `Countries` (
	`countryID` int NOT NULL auto_increment,
	`countryName` varchar(50) NOT NULL,
	`globalRegion` varchar(45) NOT NULL,
	`population` bigint(12) NOT NULL,
	`gdp` decimal(10,0),
	PRIMARY KEY (`countryID`)
);

INSERT INTO Countries (countryName, globalRegion, population, GDP)
VALUES
	('United States', 'North America', 3310002651, 21.43),
	('China', 'Asia', 1439323776, 14.34),
    ('India', 'Asia', 1380004385, 2.87),
    ('Brazil', 'South America', 212559417, 1.43),
    ('Russia', 'Asia', 145934462, 1.47);
    

-- Consumers Table

CREATE TABLE `Consumers` (
	`consumerID` int NOT NULL auto_increment,
	`municipality` varchar(100) NOT NULL,
	`population` int(11),
	`annualConsumption` int(11),
	`countryID` int,
	PRIMARY KEY (`consumerID`),
	FOREIGN KEY (`countryID`) REFERENCES Countries(countryID)
		ON DELETE SET NULL
);

INSERT INTO Consumers (municipality, population, annualConsumption)
VALUES 
	('New York City', 8336817, 180000),
	('Shanghai', 24281000, 220000),
    ('Mumbai', 20411274, 120000),
    ('Sao Paulo', 12252023, 160000),
    ('Moscow', 12537954, 100000);


-- Energy_Types Table

CREATE TABLE `Energy_Types` (
	`energyTypeID` int(11) NOT NULL auto_increment,
	`energyName` varchar(45) NOT NULL,
	`emissionsRate` int(11),
	`deathRate` decimal(10,0),
	PRIMARY KEY (`energyTypeID`)
);

INSERT INTO Energy_Types (energyName, emissionsRate, deathRate)
VALUES 
	('Solar', 45, 0.01),
	('Wind', 10, 0.005),
    ('Coal', 100, 0.02),
    ('Nuclear', 15, 0.002),
    ('Hydro', 5, 0.001);

-- Providers Table

CREATE TABLE `Providers` (
	`providerID` int(11) NOT NULL auto_increment,
	`providerName` varchar(45) NOT NULL,
	`orgType` varchar(45) NOT NULL,
	PRIMARY KEY (`providerID`)
);

INSERT INTO Providers (providerName, orgType)
VALUES
	('ABC Energy', 'Public'),
    ('XYZ Power', 'Private'),
    ('PowerCo', 'Public'),
    ('EcoEnergy', 'Private'),
    ('GreenPower', 'Cooperative');

-- Provider_Energy_Types Insersection Table

CREATE TABLE `Provider_Energy_Types` (
	`providerID` int NOT NULL,
	`energyTypeID` int NOT NULL,
	FOREIGN KEY (`providerID`) REFERENCES Providers(providerID)
		ON DELETE CASCADE,
	FOREIGN KEY (`energyTypeID`) REFERENCES Energy_Types(energyTypeID)
		ON DELETE CASCADE
);

-- National_Operations Intersection Table

CREATE TABLE `National_Operations` (
	`providerID` int NOT NULL,
    `countryID` int NOT NULL,
    FOREIGN KEY (`providerID`) REFERENCES Providers(providerID)
		ON DELETE CASCADE,
	FOREIGN KEY (`countryID`) REFERENCES Countries(countryID)
		ON DELETE CASCADE
);

-- Energy_Provisions Intersection Table

CREATE TABLE `Energy_Provisions` (
	`providerID` int,
	`consumerID` int NOT NULL,
    `energyTypeID` int NOT NULL,
    FOREIGN KEY (`providerID`) REFERENCES Providers(providerID)
		ON DELETE SET NULL,
	FOREIGN KEY (`consumerID`) REFERENCES Consumers(consumerID)
		ON DELETE CASCADE,
	FOREIGN KEY (`energyTypeID`) REFERENCES Energy_Types(energyTypeID)
		ON DELETE CASCADE
);

    

    

    

