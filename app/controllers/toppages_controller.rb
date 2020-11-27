class ToppagesController < ApplicationController
  def index
    if logged_in?
      
      @messages = Message.all.order(id: :desc).page(params[:page])
      @users = User.all.order(id: :desc).page(params[:page])
    end
  end
end
