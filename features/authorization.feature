Feature: authorization

@test1
Scenario: As a user I can sign up with random credentials X23
  When I click "login button"
  And  I click "sign up button"
  And  I "fill in sign up form" with the following data:
    | Full name | Phone Number     | Email            | Password   | Confirm password |
    | Joe Trump | RANDOM_GENERATED | RANDOM_GENERATED | Parole123! | Parole123!       |
  And  I click "Confirm sign up button"
  And  I click "Skip referal button"
  And  I click "Skip phone verification button"
  Then I am on the "home" screen
