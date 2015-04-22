class Botrus::Docker
  def initialize(options)
    @options = options
    @containers = []
  end

  def setup
    Docker::Image.create('fromImage' => @options.fetch(:image), 'tag' => @options.fetch(:tag))

    @options.fetch(:containers).times do
      container = Docker::Container.create(
        'Cmd' => [@options.fetch(:script)],
        'Env' => ['PATH=/host:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
        'Image' => @options.fetch(:image) + ':' + @options.fetch(:tag),
        'WorkingDir' => '/host',
        'HostConfig' => {
          'Binds' => ["#{Dir.pwd}:/host"]
        }
      )

      container.start

      @containers << container
    end
  end

  def teardown
    @containers.each do |container|
      container.wait
      container.delete(:force => true)
    end
  end

  def list
    @containers
  end
end
