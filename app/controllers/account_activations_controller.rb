class AccountActivationsController < ApplicationController
  before_action :find_user, only: :edit

  def edit
    if !@user.activated? && @user&.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:success] = t "account_activated"
      redirect_to @user
    else
      flash[:danger] = t "invalid_activation_link"
      redirect_to root_url
    end
  end

  private

  def find_user
    return if @user = User.find_by(email: params[:email])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end
