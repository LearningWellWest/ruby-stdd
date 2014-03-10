Feature: Handle projects
  The api shall provide methods to manage projects

  Scenario: Create project
    When I create an customer
    And I create a project for the customer
    Then I should get the project name, ID and customer ID back

  Scenario: Get project
  	Given the system has an customer
  	And the customer has a project
  	When I request the project
  	Then I should get the project name, ID and customer ID back