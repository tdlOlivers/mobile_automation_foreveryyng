# frozen_string_literal: true

# setup
require 'appium_lib'
require 'cucumber'
require 'selenium-webdriver'

if ENV['DEVICE'].include? '@'
  avd = ENV['DEVICE'].tr('@', '')
  p '---Hellooo'
  p avd
  opts = {
    caps: {
      platformName: 'Android',
      deviceName: avd,
      automationName: 'UiAutomator2',
      systemPort: ENV['SYSTEM_PORT'],
      app: '/Users/edgarsavotins/Downloads/AF3DWBfkGpzLDiMDFxTo4XhicYUCStAldu_bYSMV_CIXaT0cwrw4eCcXKj_xtSoJq-Q9jVbh211OPER0q11SRuS52zU6I__RgJuLaMqZDfchJvUrLdhYoe41VN2_dDQ3dSEHeJUMt91LfHRUaQ4pi70R04Vj1VdpwQ.apk',
      avd: avd
    },
    appium_lib: {
      server_url: "http://localhost:#{ENV['PORT']}/wd/hub"
    }
  }
else
  opts = {
    caps: {
      platformName: 'Android',
      deviceName: ENV['DEVICE'],
      automationName: 'UiAutomator2',
      # systemPort: ENV['SYSTEM_PORT'],
      app: 'apk/4ever_yng.apk',
      udid: ENV['DEVICE'],
      newCommandTimeout: 600
    },
    appium_lib: {
      server_url: "http://localhost:#{ENV['PORT']}/wd/hub"
    }
  }
end

$driver = Appium::Driver.new(opts, true)
p Appium::Driver.method(:new).source_location
Selenium::WebDriver.logger.level = :error

Before do
  $driver.start_driver
  @screens = Screens.new
end

After do |scenario|
  begin
    add_screenshot(scenario.name) if scenario.failed?
  rescue StandardError => e
    p 'Failed to add screenshot'
    p e.message
  end
  $driver.quit_driver
end

def add_screenshot(scenario_name)
  scenario_name.tr!(' ', '_')
  local_name = "reports/screenshot-#{scenario_name}.png"
  $driver.screenshot(local_name)
  embed(local_name, 'image/png', 'SCREENSHOT')
end

# Auxillary

# Adding additional method to string class
class String
  def snakify
    downcase.strip.gsub(/\s+/, '_')
  end
end
