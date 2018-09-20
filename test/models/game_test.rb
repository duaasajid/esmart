require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test 'required attributes' do
    g = Game.new
    g.validate
    assert g.has_error?(:title, :blank)
    assert g.has_error?(:slug, :blank)
  end

  test 'unique attributes' do
    g = Game.new(slug: games(:lol).slug)
    g.validate
    assert g.has_error?(:slug, :taken)
  end

  test 'defaults' do
    g = Game.new
    refute g.enabled?
  end

  test 'enabled scope' do
    assert_includes Game.enabled, games(:pubg)
    refute_includes Game.enabled, games(:lineage)
  end

  test 'playable_by?' do
    skip 'todo'
  end

end
