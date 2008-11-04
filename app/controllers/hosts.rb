class Hosts < Application

  def index
    render
  end

  def list 
    @items = []
    Merb::Config[:inventory].each do |rh|
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
    Merb::Config[:inventory].each do |h|
      hosts << "<a href=/hosts/show/?hostname=#{h.hostname}>#{h.hostname}</a><br/>" if h.hostname =~ /#{params[:hostname]}/
    end
    hosts
  end

  def show
    @host = nil
    Merb::Config[:inventory].each do |rh|
      @host = rh if rh.hostname.eql? params[:hostname]
    end
    render
  end

  def delete
    @hostname = params[:hostname]
    @deleted = !Merb::Config[:inventory].delete(params[:hostname]).nil?
    Merb::Config[:inventory].write
    render
  end

  def add
    @added = false
    if defined? session[:last_farmed] and not session[:last_farmed].nil? \
        and params[:hostname] == session[:last_farmed].hostname
      @added = Merb::Config[:inventory].add_item(session[:last_farmed])
      Merb::Config[:inventory].write if @added
    end
    render
  end

  def farming_results
    @ip = params[:ip]
    @last_farmed =MechFarmer::RemoteHost.new @ip
    session[:last_farmed] = @last_farmed
    if @last_farmed.farm
      render
    else
      'failed'
    end
  end

end
