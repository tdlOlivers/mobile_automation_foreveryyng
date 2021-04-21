# frozen_string_literal: true

require 'pry'

def scroll_from_to(el1, el2, duration: 2000)
  el1_x = el1.location.x + (el1.size.width / 2)
  el1_y = el1.location.y + (el1.size.height / 2)
  el2_x = el2.location.x + (el2.size.width / 2)
  el2_y = el2.location.y + (el2.size.height / 2)
  $driver.swipe(start_x: el1_x, start_y: el1_y, end_x: el2_x, end_y: el2_y, duration: duration)
  sleep(0.3)
end

def scroll_from_top_to_top(el1, el2, duration: 2000)
  el1_x = el1.location.x + (el1.size.width / 2)
  el1_y = el1.location.y
  el2_x = el2.location.x + (el2.size.width / 2)
  el2_y = el2.location.y
  $driver.swipe(start_x: el1_x, start_y: el1_y, end_x: el2_x, end_y: el2_y, duration: duration)
  sleep(0.3)
end

def scroll_down(ratio: 0.5, duration: 2000)
  window_size = $driver.window_size.height

  $driver.swipe(start_x: 0, start_y: window_size * ratio, end_x: 0, end_y: 0, duration: duration)
end
