require_relative 'test_helper'

class TestBotrusDocker < Minitest::Test
  def setup
    @botrus = Botrus::Docker.new(containers: 3)

    @botrus.setup
  end

  def teardown
    @botrus.teardown
  end

  def test_can_create_instances
    assert_equal(3, @botrus.list.length)
  end


  def test_can_run_bootstrap_script
    containers = @botrus.list

    containers.each do |container|
      output = container.run('echo Hello world!')
      assert_match(/Hello world!/, output)

      output = container.run('test/hello_world.sh')
      assert_match(/Hello world!/, output)
    end
  end
end
