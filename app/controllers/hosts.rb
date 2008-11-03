class Hosts < Application

  def index
    render
  end

  def list 
    @items = []
    i = MechFarmer::Inventory.load_from_file(Merb::Config[:inventory_file])
    i.each do |rh|
      @items << rh
    end
    render
  end

  def farm
    render
  end

  def find
    hosts = []
    return "type something dude" if params[:hostname].empty?
    MechFarmer::Inventory.load_from_file(Merb::Config[:inventory_file]).each do |h|
      hosts << "<a href=/hosts/show/?hostname=#{h.hostname}>#{h.hostname}</a><br/>" if h.hostname =~ /#{params[:hostname]}/
    end
    hosts
  end

  def show
    @host = nil
    i = MechFarmer::Inventory.load_from_file(Merb::Config[:inventory_file])
    i.each do |rh|
      @host = rh if rh.hostname.eql? params[:hostname]
    end
    render
  end

  def farming_results
    @ip = params[:ip]
    @mf =MechFarmer::RemoteHost.new @ip
    if @mf.farm
      render
    else
      'failed'
    end
  end

end
