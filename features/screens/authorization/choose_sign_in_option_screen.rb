# frozen_string_literal: true

require_relative '../base_screen'

# Class containing elements and methods for ChooseSignInOptionScreen
class ChooseSignInOptionScreen < Base
  def initialize(driver:)
    super
    @login_button = id('go_to_login_btn')

    expected_element(@login_button)
  end
end
