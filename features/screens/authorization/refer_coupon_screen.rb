# frozen_string_literal: true

require_relative '../base_screen'

# Screen
class ReferCouponScreen < BaseScreen
  def initialize
    @skip_referal_button = Elements.new(:id, 'skip_btn')
    @refer_code_info = Elements.new(:xpath, "//*[contains(@text, 'Use refer code')]")

    expected_element(@refer_code_info)
  end

  def click(element)
    super(element)

    case element
    when 'skip_referal_button'
      VerifyNumberScreen.new.wait_to_load
    end
  end
end
