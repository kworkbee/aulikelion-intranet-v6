class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :checkAuth
  
  def dashboard
    @homeworks = Homework.all.order(created_at: :desc)
  end
  
  def homework_status
    @users = User.all
  end

  def removeUser
    if User.find(params[:id]).destroy then
      flash[:removed] = "사용자가 탈퇴되었습니다."
      redirect_to admin_dashboard_path
    end
  end
  
  def acceptUser
    if User.find(params[:id]).update(accepted: true) then
      flash[:accepted] = "사용자의 인트라넷 사용을 승인하였습니다."
      redirect_to admin_dashboard_path
    end
  end
  
  def resetUserPW
    if User.find(params[:id]).update(password: "aulikelion") then
      flash[:modified] = "패스워드를 초기화하였습니다."
      redirect_to admin_dashboard_path
    end
  end
  
  private
  
  def checkAuth
    @admin = "active"
    @title = "Supervisor"
    unless current_user.level == 2 then
      redirectBack
    end
  end
  
  def redirectBack
    flash[:error] = "잘못된 접근입니다."
    redirect_to :back
  end
  
end
