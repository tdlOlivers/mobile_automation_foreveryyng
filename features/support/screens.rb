# frozen_string_literal: true

# Class containing screens
class Screens
  def initialize(driver:)
    @driver = driver
    @screen_array = (methods - Object.methods).select { |scr| scr.to_s.include? '_screen' }.map { |scr| send(scr.to_s) }
  end

  def base
    @base ||= Base.new(driver: @driver)
    @base
  end

  def account_creation_screen
    @account_creation ||= AccountCreationScreen.new(driver: @driver)
    @account_creation
  end

  def choose_sign_in_option_screen
    @choose_sign_in_option ||= ChooseSignInOptionScreen.new(driver: @driver)
    @choose_sign_in_option
  end

  def simple_sign_in_screen
    @simple_sign_in ||= SimpleSignInScreen.new(driver: @driver)
    @simple_sign_in
  end

  def home_screen
    @home ||= HomeScreen.new(driver: @driver)
    @home
  end

  def product_screen
    @product ||= ProductScreen.new(driver: @driver)
    @product
  end

  def wishlist_screen
    @wishlist ||= WishlistScreen.new(driver: @driver)
    @wishlist
  end

  def refer_coupon_screen
    @refer_coupon_screen ||= ReferCouponScreen.new(driver: @driver)
    @refer_coupon_screen
  end

  def verify_number_screen
    @verify_number_screen ||= VerifyNumberScreen.new(driver: @driver)
    @verify_number_screen
  end

  def current
    Timeout.timeout(10) do
      scr = nil
      scr = @screen_array.find(&:this_the_current_screen?) while scr.nil?
      p "Current screen: #{scr.class}"
      return scr
    end
  end
end
