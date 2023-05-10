Feature: Hudl Login Workflow
  As a Hudl client
  I want to login to Hudl 
  So that I can access my account

Background: Navigate to login page
  Given I navigate to the Hudl login page

Scenario: Successful Login
  Given I enter "correct" credentials
  And I "check" the remember me checkbox
  When I click the login button
  Then I should have access to the Hudl web application

Scenario: Unsuccessful Login
  Given I enter "incorrect" credentials
  When I click the login button
  Then I should not have access to the Hudl web application
  And I can click the Need Help option to troubleshoot my login issues

Scenario: Go Back
  Given I click the go back arrow
  Then I should be at the hudl main page

Scenario: Login with your hudl organization
  Given I click the Login with an organization button
  Then I should be directed to login with an organization page
  And I should be able to go back to the original login page

Scenario: User needs help
  Given I click the Need Help link
  Then I should be directed to a page to troubleshoot my login issues

Scenario: User wants to Sign up
  Given I click the sign up link
  Then I should be taken to the Hudl page to sign up to join Hudl



