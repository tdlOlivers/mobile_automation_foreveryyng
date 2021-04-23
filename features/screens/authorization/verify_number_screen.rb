# frozen_string_literal: true

require_relative '../base_screen'

# Screen
class VerifyNumberScreen < Base
  def initialize(driver:)
    super
    @skip_phone_verification_button = id('skip_verification')
    @verify_your_number_title = text('Verify your Number')
    expected_element(@verify_your_number_title)
  end
end
