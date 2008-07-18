class Sessions < Application
  # provides :xml, :yaml, :js

  def index
    @sessions = Session.all
    display @sessions
  end

  def show
    @session = Session.get(params[:id])
    raise NotFound unless @session
    display @session
  end

  def new
    only_provides :html
    @session = Session.new
    render
  end

  def edit
    only_provides :html
    @session = Session.get(params[:id])
    raise NotFound unless @session
    render
  end

  def create
    @session = Session.new(params[:session])
    if @session.save
      redirect url(:session, @session)
    else
      render :new
    end
  end

  def update
    @session = Session.get(params[:id])
    raise NotFound unless @session
    if @session.update_attributes(params[:session]) || !@session.dirty?
      redirect url(:session, @session)
    else
      raise BadRequest
    end
  end

  def destroy
    @session = Session.get(params[:id])
    raise NotFound unless @session
    if @session.destroy
      redirect url(:session)
    else
      raise BadRequest
    end
  end

end
