require_relative '../helper/data_qa_id'

class LoginPage
  # Using libraries
  include PageObject
  include DataMagic

  # starting URL
  page_url("https://www.hudl.com/login")

  # page object web elements
  link(:login_selector, :id => 'login-select')
  link(:main_logo, :data_qa_id => "site-logo")

  # login page elements
  element(:logo, :data_qa_id => "hudl-logo")
  text_field(:email, :id => 'email')
  label(:email_label, :data_qa_id => "email-input-label")
  label(:password_label, :data_qa_id => "password-input-label")
  text_field(:password, :id => 'password')
  button(:login_button, :id => 'logIn')
  checkbox(:remember_me, :data_qa_id => "remember-me-checkbox")
  button(:login_with_org_button, :data_qa_id => "log-in-with-organization-btn")
  link(:back_to_main, :class => /backIconContainer/)
  link(:sign_up_link, :href => "/register/signup")
  link(:need_help_link, :data_qa_id => "need-help-link")

  # login organization elements
  h2(:org_login_header, :text => "Log into Hudl with your Organization")
  text_field(:org_email, :class => "uni-input")
  button(:org_go_back, :data_qa_id => "go-back")

  # login error elements
  paragraph(:error_display, :css => "[data-qa-id='error-display']")
  link(:need_help_error_link, :xpath => "//p[@data-qa-id='error-display']//a[contains(text(),'Need help')]")
  h2(:login_help_header, :data_qa_id => "login-help-headline")
  h3(:reset_help_header, :data_qa_id => "lets-reset-password-headline")
  text_field(:password_reset_field, :data_qa_id => "password-reset-input")
  button(:password_reset_button, :data_qa_id => "password-reset-submit-btn")

  # logged in elements
  link(:home_nav, :data_qa_id => "webnav-globalnav-home")
  link(:explore_nav, :data_qa_id => "webnav-globalnav-explore")

  # signup page elements
  link(:request_demo_button, :id => "register_demo")

  def enter_login_credentials(option)
    DataMagic.yml_directory = './config/data'
    DataMagic.load 'default.yml'

    if option == "incorrect"
      login_data = data_for :incorrect_login
    else
      login_data = data_for :login
    end
    self.email = login_data['email']
    self.password = login_data['password']
  end

  def validate_login_page_elements
    fail "Error: Hudl logo is missing" unless logo?
    fail "Error: email field is missing" unless email?
    fail "Error: email field is not empty" unless email.empty?
    fail "Error: password field is missing" unless password?
    fail "Error: password field is not empty" unless password.empty?
    fail "Error: Login button is not enabled" unless login_button_element.enabled?
    fail "Error: Need Help link is missing" unless need_help_link?
    fail "Error: Remember me checkbox is missing" unless remember_me?
    fail "Error: Remember me checkbox is already checked" if remember_me_checked?
    fail "Error: Login with organization button is missing" unless login_with_org_button?
    fail "Error: Back to main arrow is missing" unless back_to_main?
    fail "Error: Sign up link is missing" unless sign_up_link?
  end

  def validate_user_logged_in
    fail "Error: Home navigation is missing" unless home_nav?
    fail "Error: Explore navigation is missing" unless explore_nav?
  end

  def validate_login_error
    error_display_element.wait_until(&:present?)
    fail "Error: The error display text is incorrect" unless error_display == "We didn't recognize that email and/or password.Need help?"
    fail "Error: The login button is still enabled" unless login_button_element.disabled?
    fail "Error: Need Help link is missing" unless need_help_error_link?
  end

  def validate_login_help_elements
    fail "Error: Login Help header is missing " unless login_help_header == "Login Help"
    fail "Error: Reset your password header is missing" unless reset_help_header == "Let’s reset your password"
    fail "Error: Textfield to reset password via email is missing" unless password_reset_field?
    fail "Error: Password reset button has the wrong text" unless password_reset_button_element.text == "Send Password Reset"
  end

  def validate_url(url)
    fail "Error: The user is currently at #{@browser.current_url} which is not the expected URL: #{url}" unless @browser.current_url == url
  end
end
