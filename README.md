# Hudl Automation Challenge
For this challenge I used Cucumber, Selenium-Webdriver, and Ruby to meet the requirements.

## Setup
To run this automation suite, you will need to install [RVM](https://rvm.io/rvm/install). 

Additionally, you'll need to make sure you have installed [Chromedriver](https://sites.google.com/chromium.org/driver/downloads)

From the hudl folder, you should be able to bundle install all of the needed gems once [RVM is installed](https://rvm.io/rvm/install) by running

      bundle install

Within the `config/data/default.yml`, you can update the email/password fields for correct logins or you can add them as environment variables 

      export HUDL_EMAIL="<your email>"
      export HUDL_PASSWORD="<your password>"

## How to Run
Once set up, you should be able to run the automation test when residing in the top level of the hudl folder using the command below:

      cucumber features/login.feature 

or in this case, simply running

      cucumber

This was coded/tested using a Chrome browser.

## Reporting
After the cucumber suite has run (in this case, the login feature file) you can review the `features_report.html` that gets generated on each run. If a scenario fails, a screenshot will be taken and added into the `screenshots` folder which will be created if the folder does not already exist locally. Additionally, this screenshot will be available within the `features_report.html` for quicker debugging.
