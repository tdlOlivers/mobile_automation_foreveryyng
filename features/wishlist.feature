Feature: Wishlist

@test2
Scenario Outline: As a user I can add X items to my wishlist from Y. top searched item
  Given I sign up with random credentials
  And I go to the <index>. top searched item
  When I click hearts of first <amount> items and memorize their names
  And I return to the home screen
  And I click "Wishlist tab button"
  Then I see all items which I previously added to the wishlist

  @test2_0
  Examples:
    | index | amount |
    | 1     | 20     |

  @test2_1
  Examples:
    | index | amount |
    | 3     | 9      |
