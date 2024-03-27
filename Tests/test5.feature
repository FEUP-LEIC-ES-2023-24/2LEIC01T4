Feature: Trip Information

    Scenario: Viewing all detailes of the trip 
        Given a user clicks on  "View Details" button for a specific trip
        Then he should see detailed information about that particular  trip, including: 
        - Destination (City)
        - Phone number of the driver
        - Date and Time of Departure
        - Price per person
        
    Scenario: Trip Information Unavailable
        Given a user clicks on  "View Details" button for a specific trip
        When the driver didn't post all details
        Then he will be shown an message saying "to be filled" in front of each unavailable field.
        And will have to discuss those detailes directly withthe driver

