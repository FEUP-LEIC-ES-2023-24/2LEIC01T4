Feature: Registration as a Passenger

    Scenario: Passenger registers himself correctly
        Given a user is on the registration page for passengers
        And the user enters his username
        And the user enters his phone number
        And the user enters his password
        When he submits the form
        Then the system will display a success message
        And the passenger's information will be stored

    Scenario: Passenger registers himself with an already existant username
        Given a user is on the registration page for passengers
        And the user enters an already existant username
        And the user enters his phone number
        And the user enters his password
        When he submits the form
        Then the system will display a message containing "This username is already taken"

    Scenario: Passenger registers himself with an already existant phone number
        Given a user is on the registration page for passengers
        And the user enters his username
        And the user enters an already existant phone number
        And the user enters his password
        When he submits the form
        Then the system will display a message containing "This phone number is already taken"

    Scenario: User tries to register without entering all the data
        Given  a user is on the registration page for passengers
        And the user does not enter his username
        And the user enters his phone number
        And the user enters his password
        When he submits the form
        Then the system will display a message containing "Make sure you didn't anything blank"
    



        