# frozen_string_literal: true

# Class containing base methods for screens
class BaseScreen
  @expected_e = nil

  def expected_element(element)
    @expected_element = element
  end

  def this_the_current_screen?
    if @expected_element.is_a? Array
      @expected_element.each { |e| return true if e.present? }
      false
    else
      @expected_element.present?
    end
  end

  def wait_to_load
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
end
