class UserTags < Application
  # provides :xml, :yaml, :js

  def index
    @user_tags = UserTag.all
    display @user_tags
  end

  def show
    @user_tag = UserTag.get(params[:id])
    raise NotFound unless @user_tag
    display @user_tag
  end

  def new
    only_provides :html
    @user_tag = UserTag.new
    render
  end

  def edit
    only_provides :html
    @user_tag = UserTag.get(params[:id])
    raise NotFound unless @user_tag
    render
  end

  def create
    @user_tag = UserTag.new(params[:user_tag])
    if @user_tag.save
      redirect url(:user_tag, @user_tag)
    else
      render :new
    end
  end

  def update
    @user_tag = UserTag.get(params[:id])
    raise NotFound unless @user_tag
    if @user_tag.update_attributes(params[:user_tag]) || !@user_tag.dirty?
      redirect url(:user_tag, @user_tag)
    else
      raise BadRequest
    end
  end

  def destroy
    @user_tag = UserTag.get(params[:id])
    raise NotFound unless @user_tag
    if @user_tag.destroy
      redirect url(:user_tag)
    else
      raise BadRequest
    end
  end

end
