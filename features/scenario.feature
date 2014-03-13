Feature: Handle scenarios
  The api shall provide methods to manage scenarios

  Scenario: Create screnario
    When I create an customer
    And I create a project for the customer
    And I create a run for the project
    And I create a cucumber module for the run
    And I create 1 features for the module
    And I create 2 scenarios for the feature
    Then I should get the scenario ids back each creation