class Tags < Application
  # provides :xml, :yaml, :js

  def index
    @tags = Tag.all
    display @tags
  end

  def show
    @tag = Tag.get(params[:id])
    raise NotFound unless @tag
    display @tag
  end

  def new
    only_provides :html
    @tag = Tag.new
    render
  end

  def edit
    only_provides :html
    @tag = Tag.get(params[:id])
    raise NotFound unless @tag
    render
  end

  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      redirect url(:tag, @tag)
    else
      render :new
    end
  end

  def update
    @tag = Tag.get(params[:id])
    raise NotFound unless @tag
    if @tag.update_attributes(params[:tag]) || !@tag.dirty?
      redirect url(:tag, @tag)
    else
      raise BadRequest
    end
  end

  def destroy
    @tag = Tag.get(params[:id])
    raise NotFound unless @tag
    if @tag.destroy
      redirect url(:tag)
    else
      raise BadRequest
    end
  end

end
