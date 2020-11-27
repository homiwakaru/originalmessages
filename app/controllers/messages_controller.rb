class MessagesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy]
  
  def index
    @messages = Message.all
  end  
  
  def new 
    @message = Message.new
  end  
  
  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @messages = current_user.messages.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'toppages/index'
    end  
  end

  def edit
    @message = Message.find(params[:id])
  end
  
  def update
     @message = Message.find(params[:id])

    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to mypage_users_path
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end  

  def destroy
    @message.destroy
    flash[:success] = '削除しました。'
    redirect_back(fallback_location: root_path)
  end
end

  private

  def message_params
    params.require(:message).permit(:title, :content)
  end
  
  def correct_user
    @message = current_user.messages.find_by(id: params[:id])
    unless @message
      redirect_to root_url
    end
  end