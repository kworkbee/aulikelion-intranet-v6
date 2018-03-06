class IntranetController < ApplicationController
  before_action :authenticate_user!
  
  def dashboard
    @dashboard = "active"
    @title = "Dashboard"
  end

  def notice
    @notice = "active"
    @title = "Notice"
  end

  def freeboard
    @freeboard = "active"
    @title = "Freeboard"
  end

  def gallery
    @gallery = "active"
    @title = "Gallery"
  end

  def writer
  end

  def notice_view
  end

  def freeboard_view
  end
  
  def members
    @title = "Members"
    @members = User.all
  end
end
