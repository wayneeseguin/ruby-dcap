class SessionComments < Application
  # provides :xml, :yaml, :js

  def index
    @session_comments = SessionComment.all
    display @session_comments
  end

  def show
    @session_comment = SessionComment.get(params[:id])
    raise NotFound unless @session_comment
    display @session_comment
  end

  def new
    only_provides :html
    @session_comment = SessionComment.new
    render
  end

  def edit
    only_provides :html
    @session_comment = SessionComment.get(params[:id])
    raise NotFound unless @session_comment
    render
  end

  def create
    @session_comment = SessionComment.new(params[:session_comment])
    if @session_comment.save
      redirect url(:session_comment, @session_comment)
    else
      render :new
    end
  end

  def update
    @session_comment = SessionComment.get(params[:id])
    raise NotFound unless @session_comment
    if @session_comment.update_attributes(params[:session_comment]) || !@session_comment.dirty?
      redirect url(:session_comment, @session_comment)
    else
      raise BadRequest
    end
  end

  def destroy
    @session_comment = SessionComment.get(params[:id])
    raise NotFound unless @session_comment
    if @session_comment.destroy
      redirect url(:session_comment)
    else
      raise BadRequest
    end
  end

end
