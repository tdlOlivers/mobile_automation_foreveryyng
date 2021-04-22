# frozen_string_literal: true

require_relative '../base_screen'

# Class containing elements and methods for SimpleSignInScreen
class SimpleSignInScreen < Base
  def initialize(driver:)
    super
    @sign_up_button = id('sign_up_login')
    @sign_in_title = text('Sign in to continue!')

    expected_element(@sign_in_title)
  end

  def click(element)
    super(element)

    case element
    when 'sign_up_button'
      AccountCreationScreen.new(driver: @driver).wait_to_load
    end
  end
end
