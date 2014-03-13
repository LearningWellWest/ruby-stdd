Feature: Handle modules
  The api shall provide methods to manage modules

  Scenario: Create module
    When I create an customer
    And I create a project for the customer
    And I create a run for the project
    And I create a module for the run
    Then I should get the module name, ID, kind, start-time and run-ID back

  Scenario: Update module with stop-time
    When I create an customer
    And I create a project for the customer
    And I create a run for the project
    And I create a module for the run
    And I update the module stop-time
    Then I should get the module name, ID, kind, start-time, stop-time and run-ID back