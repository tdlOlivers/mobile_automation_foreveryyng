# frozen_string_literal: true

require_relative 'base_screen'

# HomeScreen class
class HomeScreen < Base
  def initialize(driver:)
    super
    @logo_image = id('logo')
    @search_field = id('search_view')
    @wishlist_tab_button = id('fav_nav')
    @top_search_title = text('TOP SEARCH')
    @categories_title = text('Categories')

    expected_element([@categories_title, @top_search_title])
  end

  def click(element)
    super(element)
    WishlistScreen.new(driver: @driver).wait_to_load if element.eql?('wishlist_tab_button')
  end

  def open_top_searched_item_by_index(index)
    raise "Index out of bounds! Should be between 1 and 4, but is #{index}" if index < 1 || index > 4

    top_searched_item = xpath("//*[@resource-id='com.view9.foreveryng:id/recommended_chip']/android.widget.Button[#{index}]")
    top_searched_item.click
  end
end
