class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_find_user"
    redirect_to root_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome"
      redirect_to @user
    else
      flash[:danger] = t "create_fail"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end
end
