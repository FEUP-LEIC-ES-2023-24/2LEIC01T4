Feature: Search for trips

  Scenario: User searches for trips with specific locations
    Given a user is on the trip search page
    And the user enters a specific departure location
    And the user enters a specific destination location
    When the user presses the search bar
    Then only trips matching the locations should be displayed

  Scenario: User searches for trips with specific locations but both of them don't exist
    Given a user is on the trip search page
    And the user enters a specific departure location that doesn't exist
    And the user enters a specific destination location that doesn't exist
    When the user presses the search bar
    Then it will appear the message "Could not find any location"

  Scenario: User searches for trips with specific locations but the departure one doesn't exist
    Given a user is on the trip search page
    And the user enters a specific departure location that doesn't exist
    And the user enters a specific destination location
    When the user presses the search bar
    Then it will appear the message "Could not find the departure location"

  Scenario: User searches for trips with specific locations but the destionation one doesn't exist
    Given a user is on the trip search page
    And the user enters a specific departure location 
    And the user enters a specific destination location that doesn't exist
    When the user presses the search bar
    Then it will appear the message "Could not find the destination location"

  Scenario: User searches for trips with specific locations but the location is misspelled
    Given a user is on the trip search page
    And the user enters a specific departure location "Porto"
    And the user enters a specific destination location "Lisbua"
    When the user clicks the suggested spelling
    Then it will appear the message "Could not find the departure location"

   

