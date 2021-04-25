# frozen_string_literal: true

require 'report_builder'
require_relative 'mobile_runner'

mobile_runner = MobileRunner.new

mobile_runner.add_mobile_device name: 'HT83M1A04819'
mobile_runner.add_mobile_device name: 'emulator-5554'

mobile_runner.appium_starter
mobile_runner.run_tests
mobile_runner.generate_report
mobile_runner.appium_killer
