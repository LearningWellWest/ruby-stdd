Feature: Handle customers
  The api shall provide methods to manage customers

  Scenario: Create customer
    When I create an customer
    Then I should get the customer name and ID back


  Scenario: Get customer
  	Given the system has an customer
  	When I request the customer
  	Then I should get the customer name and ID back