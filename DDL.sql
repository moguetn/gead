SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------

--
-- Table structure for table `Consumers`
--

CREATE TABLE `Consumers` (
  `consumerID` int(11) NOT NULL,
  `municipality` varchar(100) NOT NULL,
  `population` bigint(20) NOT NULL,
  `region` varchar(100) NOT NULL,
  `annualConsumption` decimal(10,0) NOT NULL,
  `annualSpending` decimal(10,0) NOT NULL,
  `totalProviders` int(11) NOT NULL,
  `countryID` int(11) NOT NULL,
  `currencyID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Countries`
--

CREATE TABLE `Countries` (
  `countryID` int(11) NOT NULL,
  `countryName` varchar(50) NOT NULL,
  `globalRegion` varchar(45) NOT NULL,
  `population` bigint(20) NOT NULL,
  `gdp` decimal(10,0) NOT NULL,
  `currencyID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Currencies`
--

CREATE TABLE `Currencies` (
  `currencyID` int(11) NOT NULL,
  `currencyName` varchar(45) NOT NULL,
  `exchangeRate` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Energy_Types`
--

CREATE TABLE `Energy_Types` (
  `energyTypeID` int(11) NOT NULL,
  `energyName` varchar(45) NOT NULL,
  `emissionsRate` int(11) NOT NULL,
  `deathRate` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Providers`
--

CREATE TABLE `Providers` (
  `providerID` int(11) NOT NULL,
  `providerName` varchar(45) NOT NULL,
  `orgType` varchar(45) NOT NULL,
  `countryID` int(11) NOT NULL,
  `energyTypeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Provider_Energy_Types`
--

CREATE TABLE `Provider_Energy_Types` (
  `providerID` int(11) NOT NULL,
  `energyTypeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Consumers`
--
ALTER TABLE `Consumers`
  ADD PRIMARY KEY (`consumerID`,`countryID`,`currencyID`),
  ADD UNIQUE KEY `Consumer_ID_UNIQUE` (`consumerID`),
  ADD KEY `fk_consumers_countries1_idx` (`countryID`,`currencyID`);

--
-- Indexes for table `Countries`
--
ALTER TABLE `Countries`
  ADD PRIMARY KEY (`countryID`,`currencyID`),
  ADD UNIQUE KEY `Country_ID_UNIQUE` (`countryID`),
  ADD UNIQUE KEY `countryName_UNIQUE` (`countryName`),
  ADD UNIQUE KEY `globalRegion_UNIQUE` (`globalRegion`),
  ADD KEY `fk_Countries_Currencies1_idx` (`currencyID`);

--
-- Indexes for table `Currencies`
--
ALTER TABLE `Currencies`
  ADD PRIMARY KEY (`currencyID`),
  ADD UNIQUE KEY `EnergyType_ID_UNIQUE` (`currencyID`),
  ADD UNIQUE KEY `currencyName_UNIQUE` (`currencyName`);

--
-- Indexes for table `Energy_Types`
--
ALTER TABLE `Energy_Types`
  ADD PRIMARY KEY (`energyTypeID`),
  ADD UNIQUE KEY `EnergyType_ID_UNIQUE` (`energyTypeID`);

--
-- Indexes for table `Providers`
--
ALTER TABLE `Providers`
  ADD PRIMARY KEY (`providerID`,`countryID`,`energyTypeID`),
  ADD UNIQUE KEY `Provider_ID_UNIQUE` (`providerID`),
  ADD KEY `fk_providers_countries1_idx` (`countryID`),
  ADD KEY `fk_provider_energy_types1_idx` (`energyTypeID`);

--
-- Indexes for table `Provider_Energy_Types`
--
ALTER TABLE `Provider_Energy_Types`
  ADD PRIMARY KEY (`providerID`,`energyTypeID`),
  ADD KEY `fk_Provider_Energy_Types_Providers1_idx` (`providerID`),
  ADD KEY `fk_Provider_Energy_Types_Energy_Types1_idx` (`energyTypeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Consumers`
--
ALTER TABLE `Consumers`
  MODIFY `consumerID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Countries`
--
ALTER TABLE `Countries`
  MODIFY `countryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Currencies`
--
ALTER TABLE `Currencies`
  MODIFY `currencyID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Energy_Types`
--
ALTER TABLE `Energy_Types`
  MODIFY `energyTypeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Providers`
--
ALTER TABLE `Providers`
  MODIFY `providerID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Consumers`
--
ALTER TABLE `Consumers`
  ADD CONSTRAINT `fk_consumers_countries1` FOREIGN KEY (`countryID`,`currencyID`) REFERENCES `Countries` (`countryID`, `currencyID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Countries`
--
ALTER TABLE `Countries`
  ADD CONSTRAINT `fk_Countries_Currencies1` FOREIGN KEY (`currencyID`) REFERENCES `Currencies` (`currencyID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Providers`
--
ALTER TABLE `Providers`
  ADD CONSTRAINT `fk_provider_energy_types1` FOREIGN KEY (`energyTypeID`) REFERENCES `Provider_Energy_Types` (`providerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_providers_countries1` FOREIGN KEY (`countryID`) REFERENCES `Countries` (`countryID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Provider_Energy_Types`
--
ALTER TABLE `Provider_Energy_Types`
  ADD CONSTRAINT `fk_Provider_Energy_Types_Energy_Types1` FOREIGN KEY (`energyTypeID`) REFERENCES `Energy_Types` (`energyTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Provider_Energy_Types_Providers1` FOREIGN KEY (`providerID`) REFERENCES `Providers` (`providerID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
