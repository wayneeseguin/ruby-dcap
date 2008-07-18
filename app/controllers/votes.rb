class Votes < Application
  # provides :xml, :yaml, :js

  def index
    @votes = Vote.all
    display @votes
  end

  def show
    @vote = Vote.get(params[:id])
    raise NotFound unless @vote
    display @vote
  end

  def new
    only_provides :html
    @vote = Vote.new
    render
  end

  def edit
    only_provides :html
    @vote = Vote.get(params[:id])
    raise NotFound unless @vote
    render
  end

  def create
    @vote = Vote.new(params[:vote])
    if @vote.save
      redirect url(:vote, @vote)
    else
      render :new
    end
  end

  def update
    @vote = Vote.get(params[:id])
    raise NotFound unless @vote
    if @vote.update_attributes(params[:vote]) || !@vote.dirty?
      redirect url(:vote, @vote)
    else
      raise BadRequest
    end
  end

  def destroy
    @vote = Vote.get(params[:id])
    raise NotFound unless @vote
    if @vote.destroy
      redirect url(:vote)
    else
      raise BadRequest
    end
  end

end
