class Botrus::Docker
  class Container
    def initialize(options)
      @container = Docker::Container.create(
        'Env' => ['PATH=/host:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
        'Image' => options.fetch(:image),
        'WorkingDir' => '/host',
        'HostConfig' => {
          'Binds' => ["#{Dir.pwd}:/host"],
          'PortBindings' => {
            '22/tcp' => [{ 'HostPort' => '' }]
          }
        }
      )

      @container.start
    end

    def output
      @container.logs(stdout: true)
    end

    def delete
      @container.delete(force: true)
    end

    def run(command)
      host = URI(Docker.url).host
      port = Docker::Container.get(@container.id).info.fetch('NetworkSettings').fetch('Ports').fetch('22/tcp').first.fetch('HostPort').to_i


      Net::SSH.start(host, 'root', port: port, password: 'insecure') do |ssh|
        return ssh.exec!('cd /host;' + command)
      end
    end
  end

  def initialize(options)
    @options = options
    @containers = []
  end

  def setup
    image = 'esselius/botrus'
    Docker::Image.create('fromImage' => image)

    @options.fetch(:containers).times do
      container = Container.new(image:  image)

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
