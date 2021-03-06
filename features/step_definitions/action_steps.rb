# frozen_string_literal: true

require 'pry'

When('I click {string}') do |element|
  @screens.current.click(element.snakify)
end

When('debug') do
  binding.pry
end

When('I {string} with the following data:') do |action, table|
  @screens.current.send(action.snakify, table)
end

Then('I am on the {string} screen') do |scr|
  p "Validating that we are on the following screen: #{scr} screen"
  @screens.current.class.to_s.snakify.include?(scr.snakify)
end
