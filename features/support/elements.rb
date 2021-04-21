# frozen_string_literal: true

# Class containing basic functionality for elements
class Elements
  def initialize(type, value)
    @type = type
    @value = value
  end

  def get_element(timeout: 15)
    $driver.wait(wait_opts(timeout: timeout)) do
      return $driver.find_element(@type, @value)
    end
  end

  def present?
    $driver.find_elements(@type, @value).size.positive?
  end

  def click(timeout: 15)
    $driver.wait(wait_opts(timeout: timeout)) do
      $driver.find_element(@type, @value).click
    end
  end

  def set(text, timeout: 15)
    $driver.wait(wait_opts(timeout: timeout)) do
      $driver.find_element(@type, @value).send_keys(text)
      $driver.hide_keyboard
    end
  end

  def get_multiple_elements(timeout: 15)
    $driver.wait(wait_opts(timeout: timeout)) do
      elements = $driver.find_elements(@type, @value)
      return elements if elements.length.positive?

      raise 'No elements were found by these parameters!'
    end
  end

  def wait_opts(timeout: 15)
    {
      timeout: timeout,
      interval: 0.2,
      message: "Element not found! @type: #{@type}, @value: #{@value}, timeout: #{timeout}",
      ignored: [Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::StaleElementReferenceError]
    }
  end
end
