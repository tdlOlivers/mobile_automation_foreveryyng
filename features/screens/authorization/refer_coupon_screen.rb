# frozen_string_literal: true

require_relative '../base_screen'

# Screen
class ReferCouponScreen < Base
  def initialize(driver:)
    super
    @skip_referal_button = id('skip_btn')
    @refer_code_info = text('Use refer code')

    expected_element(@refer_code_info)
  end

  def click(element)
    super(element)

    case element
    when 'skip_referal_button'
      VerifyNumberScreen.new(driver: @driver).wait_to_load
    end
  end
end
