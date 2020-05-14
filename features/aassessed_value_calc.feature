Feature: Homepage

  Background: Login page
    Given I am a logged in user

  Scenario: FM assessed value - Scenario Zero
    When I click on "Procurements dashboard"
    And I am on the "Procurements dashboard"
    And I click on "Scenario 0- Case 1"
    And I am on the results page
    Then I should see assessed value price for scenario zero

  Scenario: FM assessed value - Scenario One
    When I click on "Procurements dashboard"
    And I am on the "Procurements dashboard"
    And I click on "Scenario 1A- Case 1"
    And I am on the results page
    Then I should see assessed value price for scenario one

  Scenario: FM assessed value - Scenario One
#    When I click on "Procurements dashboard"
#    And I am on the "Procurements dashboard"
#    And I click on "Scenario 1A- Case 1"
#    And I am on the results page
    Then I should see assessed value price for scenario zero b