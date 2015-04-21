require_relative 'test_helper'

class TestDummyRepo < Minitest::Test
  def setup
    @repo = Botrus::Repo::Dummy.new
  end

  def test_can_create_dummy_instance
    instance = @repo.create

    assert_includes(@repo.list, instance)
  end

  def test_can_destroy_dummy_instance
    instance = @repo.create
    assert_includes(@repo.list, instance)

    @repo.destroy(instance)
    refute_includes(@repo.list, instance)
  end

  def test_can_create_multiple_dummy_instances
    3.times do
      @repo.create
    end

    assert_equal(3, @repo.list.length)
  end

  def test_can_clear_instances
    3.times do
      @repo.create
    end
    assert_equal(3, @repo.list.length)

    @repo.clear
    assert_empty(@repo.list)
  end
end
