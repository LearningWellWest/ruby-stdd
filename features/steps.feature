Feature: Handle scenario steps
  The api shall provide methods to add scenario steps

  Scenario: Add steps
    When I create an customer
    And I create a project for the customer
    And I create a run for the project
    And I create a cucumber module for the run
    And I create 1 features for the module
    And I create 1 scenarios for the feature
    And I add 2 steps to each scenario
    Then I should get a success message back