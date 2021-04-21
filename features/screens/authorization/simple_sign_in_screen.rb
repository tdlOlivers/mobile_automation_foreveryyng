# frozen_string_literal: true

require_relative '../base_screen'

# Screen
class SimpleSignInScreen < BaseScreen
  def initialize
    @sign_up_button = Elements.new(:id, 'sign_up_login')
    expected_element(@sign_up_button)
  end

  def click(element)
    super(element)

    case element
    when 'sign_up_button'
      AccountCreationScreen.new.wait_to_load
    end
  end
end
