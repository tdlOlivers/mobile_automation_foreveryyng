# frozen_string_literal: true

require 'report_builder'

# run these two commands from terminal
# appium -p 4567 -bp 5567
# appium -p 4568 -bp 5568

# "cucumber -t @test -f pretty -f json -o reports/16a2773e.json DEVICE=16a2773e PORT=4567 SYSTEM_PORT=8207"
# "cucumber -t @test -f pretty -f json -o reports/98867841334d475732.json DEVICE=98867841334d475732 PORT=4568 SYSTEM_PORT=8208"

@threads = []
@pid_arr = []
@port = 4567
@system_port = 8207
devices = [
  '16a2773e',
  '@Pixel_2_API_29'
]

devices.each do |device|
  @threads << Thread.new(@port, @system_port) do |port, system_port|
    command = "cucumber -t @test1 -f pretty -f json -o reports/#{device}.json DEVICE=#{device} PORT=#{port} SYSTEM_PORT=#{system_port}"
    # p command
    `#{command}`
  end
  @port += 1
  @system_port += 1
end

p 'Waiting on tests to finish'
@threads.each(&:join)

# ReportBuilder.configure do |config|
#   config.input_path = {}
#   devices.each do |device|
#     config.input_path[device] = "reports/#{device}.json"
#   end
#   config.report_path = 'reports/results'
#   config.report_types = [:html]
#   config.report_title = '2021 TDL Mobile automation'
#   config.additional_info = {Device_type: 'Mobile', version: 'GoodVersion'}
# end
#
# ReportBuilder.build_report
