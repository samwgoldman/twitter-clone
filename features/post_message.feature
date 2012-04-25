Feature: Post Message
  In order to make myself heard
  As a user
  I want to write messages for anyone to see

  Scenario: Posting a message
    Given I am on the home page
    When  I post "Hello, World!"
    Then  I should see the message "Hello, World!"
