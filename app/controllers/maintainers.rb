class Maintainers < Application
  def list
    @maintainers = MechFarmer::Maintainer.from_yaml Merb::Config[:maintainers_file]
    render
  end

  def new
    render
  end
end

