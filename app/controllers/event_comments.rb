class EventComments < Application
  # provides :xml, :yaml, :js

  def index
    @event_comments = EventComment.all
    display @event_comments
  end

  def show
    @event_comment = EventComment.get(params[:id])
    raise NotFound unless @event_comment
    display @event_comment
  end

  def new
    only_provides :html
    @event_comment = EventComment.new
    render
  end

  def edit
    only_provides :html
    @event_comment = EventComment.get(params[:id])
    raise NotFound unless @event_comment
    render
  end

  def create
    @event_comment = EventComment.new(params[:event_comment])
    if @event_comment.save
      redirect url(:event_comment, @event_comment)
    else
      render :new
    end
  end

  def update
    @event_comment = EventComment.get(params[:id])
    raise NotFound unless @event_comment
    if @event_comment.update_attributes(params[:event_comment]) || !@event_comment.dirty?
      redirect url(:event_comment, @event_comment)
    else
      raise BadRequest
    end
  end

  def destroy
    @event_comment = EventComment.get(params[:id])
    raise NotFound unless @event_comment
    if @event_comment.destroy
      redirect url(:event_comment)
    else
      raise BadRequest
    end
  end

end
