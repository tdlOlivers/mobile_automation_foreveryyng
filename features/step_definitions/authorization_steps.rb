# frozen_string_literal: true

When(/^I click login button$/) do
  @screens.choose_sign_in_option.start_login_process
end

And(/^I click signup button$/) do
  @screens.simple_sign_in.start_sign_up_process
end

And(/^I confirm the signup form$/) do
  @screens.account_creation.confirm_sign_up
end

And(/^I skip the referal and mobile verification$/) do
  @screens.account_creation.skip_referal
  @screens.account_creation.skip_phone_verification
end

Then(/^I am on the home screen$/) do
  @screens.home.validate_screen
end

Then(/^I print (.+)$/) do |asd|
  p asd
end
