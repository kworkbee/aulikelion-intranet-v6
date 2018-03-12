class IntranetController < ApplicationController
  before_action :authenticate_user!
  before_action :checkAuth, only: [:newEvent]
  
  include ActionView::Helpers::UrlHelper
  
  ## Dashboard
  def dashboard
    @dashboard = "active"
    @title = "Dashboard"
    @recentPost = Post.where(created_at: 1.week.ago..Time.now).order(created_at: :desc)
    @nonCompletedHomeworks = Homework.all.count - current_user.submissions.count
  end

  # 게시판
  def notice
    @notice = "active"
    @title = "Notice"
    @post = Post.where(category: 1).order(created_at: :desc)
  end

  def freeboard
    @freeboard = "active"
    @title = "Freeboard"
    @post = Post.where(category: 2).order(created_at: :desc)
  end
  
  def viewPost
    @post = Post.find(params[:id])
    @reply = Reply.new
    @replies = @post.replies.order(created_at: :desc)
    if !@post.views.exists?(user_id: current_user.id) then
      @post.views.new(user_id: current_user.id).save
    end
  end
  
  def removePost
    @post = Post.find(params[:id])
    if @post.destroy then
      flash[:removed] = "게시물을 삭제하였습니다."
      case @post.category
      when 1
        redirect_to intranet_notice_path
      when 2
        redirect_to intranet_freeboard_path
      end
    end
  end
  
  def editPost
    @post = Post.find(params[:id])
    if current_user.id != @post.user.id then
      redirectBack
    end
    if request.patch? then
      if @post.update(save_params) then
        flash[:updated] = "게시물을 수정하였습니다."
        redirect_to view_path(@post.id)
      end
    end
  end
  
  def savePost
    post = Post.new(save_params)
    if post.save then
      flash[:saved] = "게시물을 생성하였습니다."
      redirect_to view_path(post.id)
    end
  end
  
  def editor
    if current_page?(nedit_path) then
      checkAuth
    end
    @post = Post.new
  end
  
  # 댓글
  def saveReply
    reply = Reply.new(save_replies)
    if reply.save then
      flash[:saved] = "댓글을 저장하였습니다."
      redirect_to :back
    end
  end
  
  def removeReply
    reply = Reply.find(params[:id])
    if reply.destroy then
      flash[:removed] = "댓글을 삭제하였습니다."
      redirect_to :back
    end
  end

  # 갤러리
  def gallery
    @gallery = "active"
    @title = "Gallery"
    @image = Image.all.order(created_at: :desc)
  end
  
  def imgUpload
    if request.get? then
      @image = Image.new
    elsif request.post? then
      @image = Image.new(save_image)
      if @image.save then
        flash[:saved] = "이미지를 업로드하였습니다."
        redirect_to intranet_gallery_path
      end
    end
  end
  
  # 이벤트
  def events
    @event = "active"
    @title = "EVENT"
  end
  
  def newEvent
    @event = Event.new
  end
  
  def createEvent
    @event = Event.new(save_events)
    @event.end += 1.day
    if @event.save then
      @event.update(url: view_event_path(@event.id))
      flash[:created] = "생성되었습니다."
      redirect_to event_path
    end
  end
  
  def viewEvent
    @event = Event.find(params[:id])
  end
  
  def removeEvent
    @event = Event.find(params[:id])
    if @event.destroy then
      flash[:removed] = "삭제되었습니다."
      redirect_to event_path
    end
  end
  
  def editEvent
    @event = Event.find(params[:id])
    if request.patch? then
      if @event.update(start: params[:event][:start].to_datetime, end: params[:event][:end].to_datetime + 1.day, title: params[:event][:title], content: params[:event][:content]) then
        flash[:updated] = "이벤트를 수정하였습니다."
        redirect_to event_path
      end
    end
  end
  
  def getEventJSON
    if params.has_key?(:search) then
      @query = Event.where("title LIKE ?", "%#{params[:search]}%").or(Event.where("content LIKE ?", "%#{params[:search]}%"))
    elsif params.has_key?(:recent) then
      @query = Event.where(start: Time.now..1.month.from_now)
    else
      @query = Event.all
    end
    respond_to do |format|
      format.json do
        render json: @query.to_json
      end
    end
  end
  
  # 과제
  def homework
    @homework = "active"
    @title = "Homework"
    @homeworks = Homework.all.order(created_at: :desc)
  end
  
  def submitHomework
    @submitted_before = current_user.submissions.exists?(homework_id: params[:id])
    if @submitted_before then
      @submission = current_user.submissions.where(homework_id: params[:id]).first
      @url = edit_submission_path(@submission.id)
    else
      @submission = Submission.new
      @url = submit_homework_path(params[:id])
    end
  end
  
  def createSubmission
    @submission = Submission.new(save_submission)
    if @submission.save then
      flash[:submitted] = "과제를 제출하였습니다."
      redirect_to homework_status_path
    end
  end
  
  def editSubmission
    @submission = Submission.find(params[:submission][:id])
    if @submission.update(save_submission) then
      flash[:submitted] = "과제를 제출하였습니다."
      redirect_to homework_status_path
    end
  end

  # 검색
  def search
    @fromPost = Post.where("title LIKE ?", "%#{params[:keyword]}%").or(Post.where("content LIKE ?", "%#{params[:keyword]}%")) + Post.includes(:user).where("users.name LIKE ?", "%#{params[:keyword]}%").references(:users)
    @fromMembers = User.where("name LIKE ?", "%#{params[:keyword]}%")
    @fromEvents = Event.where("title LIKE ?", "%#{params[:keyword]}%").or(Event.where("content LIKE ?", "%#{params[:keyword]}%"))
    @pictures = Image.where("title LIKE ?", "%#{params[:keyword]}%")
    @fromHomeworks = Homework.where("title LIKE ?", "%#{params[:keyword]}%").or(Homework.where("content LIKE ?", "%#{params[:keyword]}%"))
  end
  
  # 멤버
  def members
    @title = "Members"
    @members = User.all
  end
  
  def personal
    @title = "Member Info"
    @user = User.find(params[:id])
  end
  
  private
  
  def save_params
    params.require(:post).permit(:category, :title, :content, :user_id)
  end
  
  def save_replies
    params.require(:reply).permit(:post_id, :user_id, :content)
  end
  
  def save_events
    params.require(:event).permit(:start, :end, :title, :content)
  end
  
  def save_submission
    params.require(:submission).permit(:homework_id, :user_id, :file)
  end
  
  def save_image
    params.require(:image).permit(:file, :title, :user_id)
  end
  
  def checkAuth
    unless current_user.level == 2 then
      redirectBack
    end
  end
  
  def redirectBack
    flash[:error] = "잘못된 접근입니다."
    redirect_to :back
  end
end
