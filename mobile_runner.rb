# frozen_string_literal: true

require 'timeout'
require 'pry'

# Class for interacting with mobile test runs
class MobileRunner
  @default_appium_port = nil
  @default_system_port = nil
  @threads = nil
  @pid_arr = nil
  @device_list = nil

  def initialize(default_appium_port: 4567, default_system_port: 8207)
    @default_appium_port = default_appium_port
    @default_system_port = default_system_port
    @threads = []
    @pid_arr = []
    @device_list = []
  end

  def add_mobile_device(name:, appium_port: nil, system_port: nil)
    a_port = appium_port.nil? ? @default_appium_port : appium_port
    s_port = system_port.nil? ? @default_system_port : system_port
    @device_list << {
      name: name,
      appium_port: a_port,
      system_port: s_port,
      runner_command: cucumber_command(name: name, appium_port: a_port, system_port: s_port)
    }

    @default_appium_port += 1 if appium_port.nil?
    @default_system_port += 1 if system_port.nil?
  end

  def run_tests(device: nil, tag: nil)
    @device_list.each do |d|
      p "Did not find device: #{d[:name]}" unless `adb devices`.include?(d[:name])
      next unless `adb devices`.include?(d[:name])

      @threads << Thread.new do
        command = "#{d[:runner_command]} #{"-t #{tag}" unless tag.nil?}"
        p command
        `#{command}`
      end
    end
    @threads.each(&:join)
  end

  def generate_report
    p 'Generating report'
    ReportBuilder.configure do |config|
      config.input_path = {}
      @device_list.each { |device| config.input_path[device[:name]] = "reports/#{device[:name]}.json" }
      config.report_path = 'reports/results'
      config.report_types = [:html]
      config.report_title = '2021 TDL Mobile automation'
      config.additional_info = { Device_type: 'Mobile', version: 'GoodVersion' }
    end
    ReportBuilder.build_report
  end

  def appium_starter
    p 'Running Appium Servers'
    @device_list.each do |d|
      kill_on_port(d[:appium_port])
      start_on_port(d[:appium_port])
    end
  end

  def appium_killer
    p 'Killing Appium Servers'
    @device_list.each { |d| kill_on_port(d[:appium_port]) }
  end

  def cucumber_command(name:, appium_port:, system_port:)
    "cucumber -f pretty -f json -o reports/#{name}.json DEVICE=#{name} PORT=#{appium_port} SYSTEM_PORT=#{system_port}"
  end

  def start_on_port(port)
    p "Starting on port: #{port}"
    Process.detach(fork { exec "appium -p #{port}" })
    Timeout.timeout(30) { break if port_used?(port) }
  end

  def kill_on_port(port)
    p "Killing port: #{port}"
    `kill $(lsof -t -i:#{port})` if port_used?(port)
    Timeout.timeout(30) { break unless port_used?(port) }
  end

  def port_used?(port)
    used = `lsof -i:#{port}`.size.positive?
    p "Port used: #{used}"
    used
  end
end
