# frozen_string_literal: true

require_relative '../base_screen'

# Screen
class ChooseSignInOptionScreen < BaseScreen
  def initialize
    @login_button = Elements.new(:id, 'go_to_login_btn')

    expected_element(@login_button)
  end
end
