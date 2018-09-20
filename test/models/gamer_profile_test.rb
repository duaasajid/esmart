require 'test_helper'

class GamerProfileTest < ActiveSupport::TestCase

  test 'required attributes' do
    gp = GamerProfile.new
    gp.validate
    assert gp.has_error?(:game, :blank)
    assert gp.has_error?(:user, :blank)
    assert gp.has_error?(:handle, :blank)
  end

  test 'unique attributes' do
    gp = GamerProfile.new(user: users(:ken), game: games(:lol))
    gp.validate
    assert gp.has_error?(:user_id, :taken)
  end

end
