require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'required attributes' do
    u = User.new
    u.validate
    assert u.has_error?(:email, :blank)
  end

  test 'unique attributes' do
    u = User.new(email: users(:ken).email)
    u.validate
    assert u.has_error?(:email, :taken)
  end

  test 'cheater?' do
    u1 = User.new
    refute u1.cheater?

    u2 = User.new(reputation: 4.0)
    assert u2.cheater?

    u3 = User.new(reputation: 9.9)
    refute u3.cheater?
  end

end
