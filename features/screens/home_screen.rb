# frozen_string_literal: true

require_relative 'base_screen'

class HomeScreen < BaseScreen
  def initialize
    super
    @logo_image = Elements.new(:id, 'logo')
    @search_field = Elements.new(:id, 'search_view')
    @wishlist_tab_button = Elements.new(:id, 'fav_nav')
    @top_search_title = Elements.new(:xpath, "//android.widget.TextView[@text='TOP SEARCH']")

    expected_element([@logo_image, @top_search_title])
  end

  def click(element)
    super(element)
    WishlistScreen.new.wait_to_load if element.eql?('wishlist_tab_button')
  end

  def validate_screen
    @logo_image.get_element
    @search_field.get_element
  end

  def click_on_search_field
    @search_field.click
  end

  def open_top_searched_item_by_index(index)
    raise "Index out of bounds! Should be between 1 and 4, but is #{index}" if index < 1 || index > 4

    top_searched_item = Elements.new(:xpath, "//*[@resource-id='com.view9.foreveryng:id/recommended_chip']/android.widget.Button[#{index}]")
    top_searched_item.click
  end

  def open_wishlist_tab
    @wishlist_tab_button.click
  end
end
