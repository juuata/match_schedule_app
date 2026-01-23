class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @users = User.all.order(:name)
  end

  def create
    user = User.find_by(id: params[:user_id])
    if user
      session[:user_id] = user.id
      flash[:notice] = "ログインしました"
      redirect_to root_path
    else
      flash.now[:alert] = "ユーザーを選択してください"
      @users = User.all.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
end
