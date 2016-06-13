require 'test_helper'

class OrderTest <  Minitest::Unit::TestCase
  def setup
    @meme = Order.new
  end
  
  def test_that_kitty_can_eat
    assert_equal "OHAI!", @meme.i_can_has_cheezburger?
  end
end
