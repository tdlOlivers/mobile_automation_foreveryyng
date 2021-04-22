# frozen_string_literal: true

# Class containing base methods for screens
class Base
  @expected_e = nil
  @driver = nil

  def initialize(driver:)
    @driver = driver
  end

  def expected_element(element)
    @expected_e = element
  end

  def this_the_current_screen?
    if @expected_e.is_a? Array
      @expected_e.each { |e| return true if e.present? }
      false
    else
      @expected_e.present?
    end
  end

  def wait_to_load
    p "Waiting to load: #{self.class}"
    Timeout.timeout(10) { break if this_the_current_screen? }
  end

  def click(element)
    p "Clicking: #{element}"
    get_element(element).click
  end

  def get_element(element)
    p "Finding #{element.snakify}"
    e = instance_variable_get("@#{element.snakify}")
    e.nil? ? raise("Element undefined: #{element}") : e
  end

  def wait_for(time: 10)
    p "Waiting for #{time}"
    yield while Time.now <= Time.now + time
  end

  # Selectors-----------------------------------------------------------------------------------------------------------
  def id(value)
    Elements.new(type: :id, value: value, driver: @driver)
  end

  def xpath(value)
    Elements.new(type: :xpath, value: value, driver: @driver)
  end

  def text(value)
    Elements.new(type: :xpath, value: "//*[contains(@text, '#{value}')]", driver: @driver)
  end
end
