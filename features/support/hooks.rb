require 'selenium-webdriver'
require 'fig_newton'
require_relative 'helper/file_utils'

# Get current time
time = Time.new
# converts current time into 'YYYY-MM-DD/HH.mm.ss' format to be used throughout the application
$date_and_time = "#{time.year}-#{time.month}-#{time.day}/#{time.hour}.#{time.min}.#{time.sec}"

Before do
  @browser = Selenium::WebDriver.for :chrome
end

After do |scenario|
  begin
    if scenario.failed?
      take_screenshot(scenario)
    end
  # Terminate instance of browser
  ensure
    @browser.quit
  end
end

#  Private methods
private

#  Takes a screenshot of the current state of the page if the scenario failed.
#  Saves screenshot in folder specified in environments/default.yml
def take_screenshot(scenario)
  screenshot_dir = "#{FigNewton.screenshot_directory}/#{$date_and_time}"
  FileUtils.mkdir_p screenshot_dir unless File.directory? screenshot_dir
  # Creates filename for screenshot from scenario's name
  screenshot = "#{screenshot_dir}/FAILED_#{scenario.name.gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, '')}.png"
  # @browser.save_screenshot(screenshot)
  $stdout.print "Failing #{scenario.name} Screenshot: #{screenshot} \n"
  @current_page.save_screenshot(screenshot)
  # Embeds screenshot into Cucumber HTML reports
  attach(screenshot, 'image/png')
  # move file
  $screenshot_dir = screenshot_dir
end

def move_report
  # main_folder = FigNewton.dir
  screenshot_dir = "#{FigNewton.screenshot_directory}/#{$date_and_time}"
  File_Utils.mkdir screenshot_dir unless File.directory? screenshot_dir

  FileUtils.mv("features_report.html", screenshot_dir)
end
