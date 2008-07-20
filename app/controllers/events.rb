class Events < Application
  # provides :xml, :yaml, :js

  provides :json

  def index
    @events = Event.all
    display @events
  end

  def show(id)
    @event = Event.get(id)
    raise NotFound unless @event
    display @event
  end

  def new
    only_provides :html
    @event = Event.new
    render
  end

  def edit
    only_provides :html
    @event = Event.get(params[:id])
    raise NotFound unless @event
    render
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect url(:event, @event)
    else
      render :new
    end
  end

  def update
    @event = Event.get(params[:id])
    raise NotFound unless @event
    if @event.update_attributes(params[:event]) || !@event.dirty?
      redirect url(:event, @event)
    else
      raise BadRequest
    end
  end

  def destroy
    @event = Event.get(params[:id])
    raise NotFound unless @event
    if @event.destroy
      redirect url(:event)
    else
      raise BadRequest
    end
  end

end
