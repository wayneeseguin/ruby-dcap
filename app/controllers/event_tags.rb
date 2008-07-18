class EventTags < Application
  # provides :xml, :yaml, :js

  def index
    @event_tags = EventTag.all
    display @event_tags
  end

  def show
    @event_tag = EventTag.get(params[:id])
    raise NotFound unless @event_tag
    display @event_tag
  end

  def new
    only_provides :html
    @event_tag = EventTag.new
    render
  end

  def edit
    only_provides :html
    @event_tag = EventTag.get(params[:id])
    raise NotFound unless @event_tag
    render
  end

  def create
    @event_tag = EventTag.new(params[:event_tag])
    if @event_tag.save
      redirect url(:event_tag, @event_tag)
    else
      render :new
    end
  end

  def update
    @event_tag = EventTag.get(params[:id])
    raise NotFound unless @event_tag
    if @event_tag.update_attributes(params[:event_tag]) || !@event_tag.dirty?
      redirect url(:event_tag, @event_tag)
    else
      raise BadRequest
    end
  end

  def destroy
    @event_tag = EventTag.get(params[:id])
    raise NotFound unless @event_tag
    if @event_tag.destroy
      redirect url(:event_tag)
    else
      raise BadRequest
    end
  end

end
