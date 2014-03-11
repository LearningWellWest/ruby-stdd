Feature: Handle runs
  The api shall provide methods to manage runs

  Scenario: Create run
    When I create an customer
    And I create a project for the customer
    And I create a run for the project
    Then I should get the run name, ID, source and project ID back

  Scenario: Get run by name
  	Given the system has an customer
  	And the customer has a project
    And the project has a run with a specific name
  	When I request the run by name
  	Then I should get the run name, ID, source and project ID back