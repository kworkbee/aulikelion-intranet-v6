class ChatroomsController < ApplicationController
  def index
    @chat_rooms = Chatroom.all
  end

  def new
    @chat_room = Chatroom.new
  end
  
  def show
    @chat_room = Chatroom.includes(:messages).find_by(id: params[:id])
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end