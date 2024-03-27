Feature: Registration as a Driver

    Scenario: Driver registers himself correctly
        Given a user is on the registration page for drivers
        And the user enters his username
        And the user enters his phone number
        And the user enters his password
        And the user enters his driving licence number
        And the user enters his driving licence expiration date
        When he submits the form
        Then the system will display a success message
        And the driver's information will be stored

    Scenario: Driver registers himself with an already existant username
        Given a user is on the registration page for drivers
        And the user enters an already existant username
        And the user enters his phone number
        And the user enters his password
        And the user enters his driving licence number
        And the user enters his driving licence expiration date
        When he submits the form
        Then the system will display a message containing "This username is already taken"

    Scenario: Driver registers himself with an already existant phone number
        Given a user is on the registration page for drivers
        And the user enters his username
        And the user enters an already existant phone number
        And the user enters his password
        And the user enters his driving licence number
        And the user enters his driving licence expiration date
        When he submits the form
        Then the system will display a message containing "This phone number is already taken"

    Scenario: Driver registers himself with an invalid driving licence
        Given a user is on the registration page for drivers
        And the user enters his username
        And the user enters his phone number
        And the user enters his password
        And the user enters his driving licence number
        And the user enters his a driving licence expiration date already expired
        When he submits the form
        Then the system will display a message containing "This driving licence is invalid"

    Scenario: User tries to register without entering all the data
        Given  a user is on the registration page for drivers
        And the user does not enter his username
        And the user enters his phone number
        And the user enters his password
        And the user enters his driving licence number
        And the user enters his driving licence expiration date
        When he submits the form
        Then the system will display a message containing "Make sure you don't left anything blank"
    
