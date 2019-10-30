class SessionsController < ApplicationController
  before_action :check_user_present, only: :create
  def new; end

  def create
    if @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = t "welcome"
      user_activated
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

  def user_activated
    if @user.activated?
      log_in @user
      if params[:session][:remember_me] == Settings.remember_me
        remember @user
      else
        forget @user
      end
      redirect_back_or @user
    else
      flash[:warning] = t "account_not_activated_check_mail"
      redirect_to root_url
    end
  end
end
