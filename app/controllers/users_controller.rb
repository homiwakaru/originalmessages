class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :mypage]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  def show
    @user = User.find(params[:id])
    @messages = @user.messages.order(id: :desc).page(params[:page])
  end
  
  def mypage
    @messages = current_user.messages
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
