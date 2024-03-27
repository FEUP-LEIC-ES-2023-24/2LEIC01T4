Feature: Publish trips and prices

  Scenario: Driver publishes a trip and a price
    Given a driver is on the trip publishing page
    And the driver enters a specific departure location
    And the driver enters a specific destination location
    And the driver enters a specific departure time
    And the driver enters a price per passenger
    When the driver submits the trip for publication
    Then the trip should display the entered price per passenger on the publishing page

  Scenario: Driver publishes a trip but does not write a price
    Given a driver is on the trip publishing page
    And the driver enters a specific departure location 
    And the driver enters a specific destination location
    And the driver enters a specific departure time
    And the driver does not enter a price per passenger
    When the driver submits the trip for publication
    Then the trip should be displayed as free on the publishing page

  Scenario: Driver publishes a trip but writes a departure location that doesn't exist
    Given a driver is on the trip publishing page
    And the driver enters a specific departure location that doesn't exist
    And the driver enters a specific destination location
    And the driver enters a specific departure time
    And the driver enters a price per passenger
    When the driver tries to submit the trip for publication
    Then it will appear the message "Could not find the departure location"


  Scenario: Driver publishes a trip but writes a destination location that doesn't exist
    Given a driver is on the trip publishing page
    And the driver enters a specific departure location
    And the driver enters a specific destination location that doesn't exist
    And the driver enters a specific departure time
    And the driver enters a price per passenger
    When the driver tries to submit the trip for publication
    Then it will appear the message "Could not find the destination location"


  Scenario: Driver publishes a trip but writes locations that don't exist
    Given a driver is on the trip publishing page
    And the driver enters a specific departure location that doesn't exist
    And the driver enters a specific destination location that doesn't exist
    And the driver enters a specific departure time
    And the driver enters a price per passenger
    When the driver tries to submit the trip for publication
    Then it will appear the message "Could not find any location"

  Scenario: Driver publishes a trip but doesn't write a departure time 
    Given a driver is on the trip publishing page
    And the driver enters a specific departure location
    And the driver enters a specific destination location 
    And the driver enters no specific departure time
    And the driver enters a price per passenger
    When the driver tries to submit the trip for publication
    Then it will appear the message "Please write a specific departure time"

  Scenario: Driver publishes a trip but the location is misspelled 
    Given a driver is on the trip publishing page
    And the driver enters a specific departure location "Porto"
    And the driver enters a specific destination location "Lisbua"
    And the driver enters a specific departure time
    And the driver enters a price per passenger
    When the driver tries to submit the trip for publication
    Then it will appear the message "Could not find the destination location"