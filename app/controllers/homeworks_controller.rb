class HomeworksController < ApplicationController
  before_action :authenticate_user!
  before_action :checkAuth
  
    def new
        @homework = Homework.new
    end
    
    def create
        @homework = Homework.new(save_params)
        if @homework.save then
            flash[:created] = "과제를 생성하였습니다."
            redirect_to admin_dashboard_path
        end
    end
    
    def destroy
    end
    
    def update
        @homework = Homework.find(params[:id])
        if @homework.update(save_params) then
            flash[:updated] = "과제를 변경하였습니다."
            redirect_to admin_dashboard_path
        end
    end
    
    def show
        @homework = Homework.find(params[:id])
    end
    
    def edit
        @homework = Homework.find(params[:id])
    end
    
    private
    
    def save_params
        params.require(:homework).permit(:title, :content, :closing)
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