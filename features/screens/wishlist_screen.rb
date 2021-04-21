# frozen_string_literal: true

require_relative 'base_screen'

# Class containing
class WishlistScreen < BaseScreen
  def initialize
    @fully_visible_products = Elements.new(
      :xpath,
      "//*[@resource-id='com.view9.foreveryng:id/wishlist_rview']" \
      "//*[@resource-id='com.view9.foreveryng:id/materialCardView2']" \
      "[descendant::*[@resource-id='com.view9.foreveryng:id/textView6']]" \
      "[descendant::*[@resource-id='com.view9.foreveryng:id/add_to_cart_btn']]"
    )

    expected_element([@fully_visible_products])
  end

  def validate_wishlist(expected_list)
    product_titles = []
    whole_list_checked = false
    start = Time.now
    while Time.now - start < 60
      product_title_length = product_titles.length
      products = @fully_visible_products.get_multiple_elements
      products.each do |product|
        title = product.find_element(:id, 'textView6').text
        product_titles << title unless product_titles.include?(title)
      end
      scroll_from_to(products[-1], products[0])
      if product_title_length == product_titles.length # nothing was added
        whole_list_checked = true
        break
      end
    end
    raise "Not whole list checked! #{product_titles}" unless whole_list_checked
    return if product_titles == expected_list

    raise "Lists don't match! \nExpected: \n#{expected_list}\nActual: \n#{product_titles}"
  end
end
