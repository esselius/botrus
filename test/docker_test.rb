require_relative 'test_helper'

class TestDocker < Minitest::Test
  def setup
    @botrus = Botrus::Docker.new(
      containers: 3,
      image: 'esselius/botrus'
    )

    @botrus.setup
  end

  def teardown
    @botrus.teardown
  end

  def test_can_create_instances
    assert_equal(3, @botrus.list.length)
  end
end
