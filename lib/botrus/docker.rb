class Botrus::Docker
  class Container
    def initialize(options)
      @container = Docker::Container.create(
        'Cmd' => [options.fetch(:cmd)],
        'Env' => ['PATH=/host:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
        'Image' => options.fetch(:image) + ':' + options.fetch(:tag),
        'WorkingDir' => '/host',
        'HostConfig' => {
          'Binds' => ["#{Dir.pwd}:/host"]
        }
      )

      @container.start
    end

    def output
      @container.logs(stdout: true)
    end

    def delete
      @container.wait
      @container.delete
    end
  end

  def initialize(options)
    @options = options
    @containers = []
  end

  def setup
    Docker::Image.create('fromImage' => @options.fetch(:image), 'tag' => @options.fetch(:tag))

    @options.fetch(:containers).times do
      container = Container.new(
        image:  @options.fetch(:image),
        tag:    @options.fetch(:tag),
        cmd:    @options.fetch(:script)
      )

      @containers << container
    end
  end

  def teardown
    @containers.each do |container|
      container.delete
    end
  end

  def list
    @containers
  end
end
