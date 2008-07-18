class UserVotes < Application
  # provides :xml, :yaml, :js

  def index
    @user_votes = UserVote.all
    display @user_votes
  end

  def show
    @user_vote = UserVote.get(params[:id])
    raise NotFound unless @user_vote
    display @user_vote
  end

  def new
    only_provides :html
    @user_vote = UserVote.new
    render
  end

  def edit
    only_provides :html
    @user_vote = UserVote.get(params[:id])
    raise NotFound unless @user_vote
    render
  end

  def create
    @user_vote = UserVote.new(params[:user_vote])
    if @user_vote.save
      redirect url(:user_vote, @user_vote)
    else
      render :new
    end
  end

  def update
    @user_vote = UserVote.get(params[:id])
    raise NotFound unless @user_vote
    if @user_vote.update_attributes(params[:user_vote]) || !@user_vote.dirty?
      redirect url(:user_vote, @user_vote)
    else
      raise BadRequest
    end
  end

  def destroy
    @user_vote = UserVote.get(params[:id])
    raise NotFound unless @user_vote
    if @user_vote.destroy
      redirect url(:user_vote)
    else
      raise BadRequest
    end
  end

end
