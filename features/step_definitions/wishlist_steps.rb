# frozen_string_literal: true

Given(/^I sign up with random credentials$/) do
  steps %(
    When I click "login button"
    And  I click "sign up button"
    And  I "fill in sign up form" with the following data:
      | Full name | Phone Number     | Email            | Password   | Confirm password |
      | Joe Trump | RANDOM_GENERATED | RANDOM_GENERATED | Parole123! | Parole123!       |
    And  I click "Confirm sign up button"
    And  I click "Skip referal button"
    And  I click "Skip phone verification button"
    Then I am on the "home" screen
  )
end

And(/^I go to the (\d). top searched item$/) do |index|
  @screens.current.click_on_search_field
  @screens.current.open_top_searched_item_by_index(index.to_i)
end

When(/^I click hearts of first (\d+) items and memorize their names$/) do |count|
  @screens.product_screen.wait_to_load
  @product_titles = @screens.current.add_x_items_to_the_wishlist(count.to_i)
end

And(/^I return to the home screen$/) do
  @screens.current.return_to_home
end

And(/^I click on Wishlist tab$/) do
  @screens.current.open_wishlist_tab
end

Then(/^I see all items which I previously added to the wishlist$/) do
  @screens.current.validate_wishlist(@product_titles)
end
