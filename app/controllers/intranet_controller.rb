class IntranetController < ApplicationController
  before_action :authenticate_user!
  
  def dashboard
    @dashboard = "active"
    @title = "Dashboard"
  end

  def notice
    @notice = "active"
    @title = "Notice"
    @post = Post.where(category: 1)
  end

  def freeboard
    @freeboard = "active"
    @title = "Freeboard"
    @post = Post.where(category: 2)
  end

  def gallery
    @gallery = "active"
    @title = "Gallery"
  end
  
  def events
    @event = "active"
    @title = "EVENT"
  end

  def homework
    @homework = "active"
    @title = "Homework"
  end

  def viewPost
    @post = Post.find(params[:id])
  end
  
  def savePost
    post = Post.new(save_params)
    if post.save then
      flash[:saved] = "게시물을 생성하였습니다."
      redirect_to view_path(post.id)
    end
  end
  
  def editor
    @post = Post.new
  end
  
  def search
  end
  
  def members
    @title = "Members"
    @members = User.all
  end
  
  private
  
  def save_params
    params.require(:post).permit(:category, :title, :content)
  end
end
