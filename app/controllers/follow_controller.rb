class FollowController < ApplicationController
  before_action :load_user, only: %i(following followers)

  def following
    @title = t("following")
    @users = @user.following.page(params[:page]).per Settings.size_page

    render "users/show_follow"
  end

  def followers
    @title = t("followers")
    @users = @user.followers.page(params[:page]).per Settings.size_page

    render "users/show_follow"
  end

  private

  def load_user
    return if @user = User.find_by(id: params[:id])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end
