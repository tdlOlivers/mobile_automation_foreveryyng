# frozen_string_literal: true

class Screens
  def initialize
    @screen_array = (methods - Object.methods).select { |scr| scr.to_s.include? 'screen' }.map { |scr| send(scr.to_s) }
  end

  def account_creation_screen
    @account_creation ||= AccountCreationScreen.new
    @account_creation
  end

  def choose_sign_in_option_screen
    @choose_sign_in_option ||= ChooseSignInOptionScreen.new
    @choose_sign_in_option
  end

  def simple_sign_in_screen
    @simple_sign_in ||= SimpleSignInScreen.new
    @simple_sign_in
  end

  def home_screen
    @home ||= HomeScreen.new
    @home
  end

  def product_screen
    @product ||= ProductScreen.new
    @product
  end

  def wishlist_screen
    @wishlist ||= WishlistScreen.new
    @wishlist
  end

  def refer_coupon_screen
    @refer_coupon_screen ||= ReferCouponScreen.new
    @refer_coupon_screen
  end

  def verify_number_screen
    @verify_number_screen ||= VerifyNumberScreen.new
    @verify_number_screen
  end

  def get_current
    Timeout.timeout(10) do
      scr = nil
      scr = @screen_array.find(&:this_the_current_screen?) while scr.nil?
      p "Current screen: #{scr.class}"
      return scr
    end
  end
end
