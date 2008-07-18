class Attendees < Application
  # provides :xml, :yaml, :js

  def index
    @attendees = Attendee.all
    display @attendees
  end

  def show
    @attendee = Attendee.get(params[:id])
    raise NotFound unless @attendee
    display @attendee
  end

  def new
    only_provides :html
    @attendee = Attendee.new
    render
  end

  def edit
    only_provides :html
    @attendee = Attendee.get(params[:id])
    raise NotFound unless @attendee
    render
  end

  def create
    @attendee = Attendee.new(params[:attendee])
    if @attendee.save
      redirect url(:attendee, @attendee)
    else
      render :new
    end
  end

  def update
    @attendee = Attendee.get(params[:id])
    raise NotFound unless @attendee
    if @attendee.update_attributes(params[:attendee]) || !@attendee.dirty?
      redirect url(:attendee, @attendee)
    else
      raise BadRequest
    end
  end

  def destroy
    @attendee = Attendee.get(params[:id])
    raise NotFound unless @attendee
    if @attendee.destroy
      redirect url(:attendee)
    else
      raise BadRequest
    end
  end

end
