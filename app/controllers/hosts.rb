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
