class SessionsController < ApplicationController
  before_action :check_user_present, only: :create
  def new; end

  def create
    if @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = t "welcome"
      params[:session][:remember_me] == Settings.remember_me ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash[:danger] = t "email_password"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def check_user_present
    @user = User.find_by email: params[:session][:email].downcase

    return if @user
    flash[:danger] = t "email_password"
    render :new
  end
end
