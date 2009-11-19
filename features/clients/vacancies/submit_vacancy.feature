@vacancies @current
Feature: Submit vacancy for approval
  In order to have my vacancy approved for the live site
  As an authorised client
  I want to be able to submit my vacancy for approval when I have completed it

  Background:
    Given I am logged in as a client

  Scenario: Vacancy has all required fields
    Given I am on the new vacancy page
    When I fill out all the fields for a vacancy
    And I press "Submit for approval"
    Then I should see "Vacancy submitted for approval"
    And the vacancy should have the status of "awaiting_approval"
    And a new vacancy notification should be sent
    When I go to the vacancies awaiting approval page
    Then I should have 1 rows of vacancies

  Scenario: Vacancy does not have all required fields
    Given I am on the new vacancy page
    When I do not fill out any fields
    And I press "Submit for approval"
    Then I should see "There were problems with the following fields"

    When I go to the vacancies awaiting approval page
    Then I should have 0 rows of vacancies

  Scenario: Viewing a vacancy awaiting approval
    Given I am on the new vacancy page
    When I fill out all the fields for a vacancy
    And I press "Submit for approval"
    When I go to the vacancies awaiting approval page
    Then I should not see "edit"
    And I should see "view"
    When I follow "view"
    Then I should not see "Submit for approval"
    And I should not see "Update"
