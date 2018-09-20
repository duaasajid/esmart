require 'test_helper'

class MatchTest < ActiveSupport::TestCase

  test 'required attributes' do
    m = Match.new
    m.validate
    assert m.has_error?(:player1, :blank)
    assert m.has_error?(:player2, :blank)
  end

  test 'distinct players' do
    m = Match.new(player1: users(:ryu), player2: users(:ryu))
    m.validate
    assert_includes m.errors[:base], "A match can't include the same player multiple times"
  end

  test 'set_winner' do
    player2 = users(:ryu)
    m = matches(:ken_ryu_lol_tie_break)
    m.set_winner(player2)
    m.reload
    assert m.finished?
    assert_equal player2, m.winner
  end

  test 'finished?' do
    assert matches(:ken_ryu_lol_first_blood).finished?
    refute matches(:ken_ryu_lol_tie_break).finished?
  end

end
