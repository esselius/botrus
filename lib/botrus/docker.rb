class Botrus::Docker
  def initialize(options)
    @options = options
    @containers = []
  end

  def setup
    Docker::Image.create('fromImage' => @options.fetch(:image))

    @options.fetch(:containers).times do
      container = Docker::Container.create('Image' => @options.fetch(:image))

      container.start

      @containers << container
    end
  end

  def teardown
    @containers.each do |container|
      container.delete(:force => true)
    end
  end

  def list
    @containers
  end
end
