Given(/^I navigate to the Hudl login page$/) do
  visit_page(LoginPage)
  on_page(LoginPage).email_element.wait_until(&:present?)
  on_page(LoginPage).validate_login_page_elements
end

Given(/^I enter "([^"]*)" credentials$/) do |option|
  on_page(LoginPage).enter_login_credentials(option)
end

Given(/^I click the login button$/) do
  on_page(LoginPage).login_button
end

And(/^I "([^"]*)" the remember me checkbox$/) do |option|
  if option == "check"
    on_page(LoginPage).remember_me_element.fire_event('onClick')
    fail "Error: The remember me checkbox is not checked" unless on_page(LoginPage).remember_me_checked?  
  else
    fail "Error: The remember me checkbox is not checked" if on_page(LoginPage).remember_me_checked?    
  end
    ## would like to get more details on how `remember me` works to create additional testing scenarios  
end

Then(/^I should have access to the Hudl web application$/) do
  on_page(LoginPage).home_nav_element.wait_until(&:present?)
  on_page(LoginPage).validate_url("https://www.hudl.com/home")
  on_page(LoginPage).validate_user_logged_in
end

Then(/^I should not have access to the Hudl web application$/) do
  on_page(LoginPage).error_display_element.wait_until(&:present?)
  on_page(LoginPage).validate_login_error
end

Then(/^I can click the Need Help option to troubleshoot my login issues$/) do
  on_page(LoginPage).need_help_error_link
  on_page(LoginPage).validate_url("https://www.hudl.com/login/help")
  on_page(LoginPage).login_help_header_element.wait_until(&:present?)
  on_page(LoginPage).validate_login_help_elements
end

Given('I click the go back arrow') do
  on_page(LoginPage).back_to_main
end

Then('I should be at the hudl main page') do
  on_page(LoginPage).validate_url("https://www.hudl.com/")
  fail "Error: The Hudl logo on the main page is missing" unless on_page(LoginPage).main_logo?
end

Given('I click the Login with an organization button') do
  on_page(LoginPage).login_with_org_button
end

Then('I should be directed to login with an organization page') do
  on_page(LoginPage).validate_url("https://www.hudl.com/app/auth/login/organization")
  fail "Error: The header on the organization login page is missing" unless on_page(LoginPage).org_login_header?
  fail "Error: The email text field on the organization login page is missing" unless on_page(LoginPage).org_email?
end

Then('I should be able to go back to the original login page') do
  on_page(LoginPage).org_go_back
  on_page(LoginPage).validate_url("https://www.hudl.com/login")
  on_page(LoginPage).validate_login_page_elements
end

Given('I click the Need Help link') do
  on_page(LoginPage).need_help_link
end

Then('I should be directed to a page to troubleshoot my login issues') do
  on_page(LoginPage).validate_url("https://www.hudl.com/login/help#")
  on_page(LoginPage).login_help_header_element.wait_until(&:present?)
  on_page(LoginPage).validate_login_help_elements
end

Given('I click the sign up link') do
  on_page(LoginPage).sign_up_link
end

Then('I should be taken to the Hudl page to sign up to join Hudl') do
  on_page(LoginPage).validate_url("https://www.hudl.com/register/signup")
  fail "Error: Request demo button is not available on the sign up page" unless on_page(LoginPage).request_demo_button?
end