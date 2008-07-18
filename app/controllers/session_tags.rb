class SessionTags < Application
  # provides :xml, :yaml, :js

  def index
    @session_tags = SessionTag.all
    display @session_tags
  end

  def show
    @session_tag = SessionTag.get(params[:id])
    raise NotFound unless @session_tag
    display @session_tag
  end

  def new
    only_provides :html
    @session_tag = SessionTag.new
    render
  end

  def edit
    only_provides :html
    @session_tag = SessionTag.get(params[:id])
    raise NotFound unless @session_tag
    render
  end

  def create
    @session_tag = SessionTag.new(params[:session_tag])
    if @session_tag.save
      redirect url(:session_tag, @session_tag)
    else
      render :new
    end
  end

  def update
    @session_tag = SessionTag.get(params[:id])
    raise NotFound unless @session_tag
    if @session_tag.update_attributes(params[:session_tag]) || !@session_tag.dirty?
      redirect url(:session_tag, @session_tag)
    else
      raise BadRequest
    end
  end

  def destroy
    @session_tag = SessionTag.get(params[:id])
    raise NotFound unless @session_tag
    if @session_tag.destroy
      redirect url(:session_tag)
    else
      raise BadRequest
    end
  end

end
