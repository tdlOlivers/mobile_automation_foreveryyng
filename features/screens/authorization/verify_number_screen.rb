# frozen_string_literal: true

require_relative '../base_screen'

# Screen
class VerifyNumberScreen < BaseScreen
  def initialize
    @skip_phone_verification_button = Elements.new(:id, 'skip_verification')
    @verify_your_number_title = Elements.new(:xpath, "//*[contains(@text, 'Verify your Number')]")
    expected_element(@verify_your_number_title)
  end
end
