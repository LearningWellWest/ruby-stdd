Feature: Handle features
  The api shall provide methods to manage features

  Scenario: Create feature
    When I create an customer
    And I create a project for the customer
    And I create a run for the project
    And I create a cucumber module for the run
    And I create 2 features for the module
    Then I should get the feature ids back each creation