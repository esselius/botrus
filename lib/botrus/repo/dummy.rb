class Botrus::Repo::Dummy < Botrus::Repo
  def initialize
    @repo = []
  end

  def create
    instance = srand

    @repo << instance

    instance
  end

  def destroy(instance)
    @repo.delete(instance)
  end

  def clear
    @repo.clear
  end

  def list
    @repo
  end
end
