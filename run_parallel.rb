# frozen_string_literal: true

require 'report_builder'
require 'optparse'
require 'yaml'

require_relative 'mobile_runner'

# Creating mobile runner object
mobile_runner = MobileRunner.new
# Reading predefined devices from yml
devices = YAML.load_file('devices.yml')
# Reading optins passed to run_parallel.rb
options = {}
OptionParser.new { |opts| opts.on('-t', '--tag NAME', 'Tag name') { |t| options[:tag] = t } }.parse!
# Adding devices in yml file to mobile_runner
devices['devices'].each { |device| mobile_runner.add_mobile_device name: device }

mobile_runner.appium_starter
mobile_runner.run_tests tag: options[:tag].nil? ? nil : options[:tag]
mobile_runner.generate_report
mobile_runner.appium_killer
