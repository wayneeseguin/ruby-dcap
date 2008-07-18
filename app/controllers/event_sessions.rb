class EventSessions < Application
  # provides :xml, :yaml, :js

  def index
    @event_sessions = EventSession.all
    display @event_sessions
  end

  def show
    @event_session = EventSession.get(params[:id])
    raise NotFound unless @event_session
    display @event_session
  end

  def new
    only_provides :html
    @event_session = EventSession.new
    render
  end

  def edit
    only_provides :html
    @event_session = EventSession.get(params[:id])
    raise NotFound unless @event_session
    render
  end

  def create
    @event_session = EventSession.new(params[:event_session])
    if @event_session.save
      redirect url(:event_session, @event_session)
    else
      render :new
    end
  end

  def update
    @event_session = EventSession.get(params[:id])
    raise NotFound unless @event_session
    if @event_session.update_attributes(params[:event_session]) || !@event_session.dirty?
      redirect url(:event_session, @event_session)
    else
      raise BadRequest
    end
  end

  def destroy
    @event_session = EventSession.get(params[:id])
    raise NotFound unless @event_session
    if @event_session.destroy
      redirect url(:event_session)
    else
      raise BadRequest
    end
  end

end
