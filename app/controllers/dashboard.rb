class Dashboard < Application
  
  def index
    @events = Event.all
    render
  end
  
end
