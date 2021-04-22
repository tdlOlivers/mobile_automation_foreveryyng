# frozen_string_literal: true

require_relative 'base_screen'

# Class containing items for Product screem
class ProductScreen < Base
  def initialize(driver:)
    super
    @fully_visible_products = xpath(
      "//*[@resource-id='com.view9.foreveryng:id/product_r_view']" \
      "//*[@resource-id='com.view9.foreveryng:id/materialCardView2']" \
      "[descendant::*[@resource-id='com.view9.foreveryng:id/textView6']]" \
      "[descendant::*[@resource-id='com.view9.foreveryng:id/wish_list']]"
    )
    @products_cards = xpath(
      "//*[@resource-id='com.view9.foreveryng:id/product_r_view']" \
      "//*[@resource-id='com.view9.foreveryng:id/materialCardView2']"
    )
    @toast = id('tvToastMsgId')

    expected_element(@fully_visible_products)
  end

  def add_x_items_to_the_wishlist(number_of_items_to_add)
    product_titles = []
    counter = 0
    start = Time.now

    while counter + 2 <= number_of_items_to_add && Time.now - start < 360

      products = @fully_visible_products.get_multiple_elements
      product_titles << products[0].find_element(:id, 'textView6').text
      products[0].find_element(:id, 'wish_list').click

      wait_for_toast_to_disapear

      product_titles << products[1].find_element(:id, 'textView6').text
      products[1].find_element(:id, 'wish_list').click

      wait_for_toast_to_disapear

      scroll_down(ratio: 0.45)
      counter += 2
    end

    if number_of_items_to_add == counter + 1
      products = @fully_visible_products.get_multiple_elements
      product_titles << products[0].find_element(:id, 'textView6').text

      products[0].find_element(:id, 'wish_list').click

      wait_for_toast_to_disapear

      counter += 1
    end

    raise 'smth went wrong with my math.. or it exceeded the timer idk' if number_of_items_to_add != counter

    product_titles
  end

  def return_to_home
    @driver.back
    @driver.back
  end

  def wait_for_toast_to_disapear
    @toast.get_element
    wait_for { break unless @toast.present? }
  end
end
