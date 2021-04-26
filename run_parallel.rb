# frozen_string_literal: true

require 'report_builder'
require 'optparse'
require 'yaml'

require_relative 'mobile_runner'

# Creating mobile runner object
mobile_runner = MobileRunner.new
# Reading options passed to run_parallel.rb
options = {}
OptionParser.new { |opts| opts.on('-t', '--tag NAME', 'Tag name') { |t| options[:tag] = t } }.parse!
# Reading and adding devices in yml file to mobile_runner
YAML.load_file('devices.yml')['devices'].each { |device| mobile_runner.add_mobile_device name: device }
# Executing tests
mobile_runner.appium_starter
mobile_runner.run_tests tag: options[:tag].nil? ? nil : options[:tag]
mobile_runner.generate_report
mobile_runner.appium_killer
