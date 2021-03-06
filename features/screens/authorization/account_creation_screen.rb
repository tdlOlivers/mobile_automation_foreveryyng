# frozen_string_literal: true

require_relative '../base_screen'

# Class containing elements and methods for AccountCreationScreen
class AccountCreationScreen < Base
  def initialize(driver:)
    super
    @name_field = id('signup_name')
    @phone_number_field = id('signup_phone')
    @email_field = id('signup_email')
    @password_field = id('signup_password')
    @password_confirmation_field = id('signup_confirm_password')
    @confirm_sign_up_button = id('sign_up_btn')
    expected_element(@confirm_sign_up_button)
  end

  def click(element)
    super(element)

    case element
    when 'confirm_sign_up_button'
      ReferCouponScreen.new(driver: @driver).wait_to_load
    end
  end

  def fill_in_sign_up_form(data_table)
    data_table.hashes.first.each do |k, v|
      case k.snakify.to_sym
      when :full_name
        @name_field.set(v)
      when :phone_number
        @phone_number_field.set(v.eql?('RANDOM_GENERATED') ? "980#{rand(1_000_000...9_999_999)}" : v)
      when :email
        @email_field.set(v.eql?('RANDOM_GENERATED') ? "RandomEmail#{rand(1..99_999)}@gmail.com" : v)
      when :password
        @password_field.set(v)
      when :confirm_password
        @password_confirmation_field.set(v)
      end
    end
  end
end
