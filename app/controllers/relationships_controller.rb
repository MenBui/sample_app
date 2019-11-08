class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :create
  before_action :relationship_load_user, only: :destroy

  def create
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def load_user
    return if @user = User.find_by(id: params[:followed_id])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
  def relationship_load_user
    return if @user = Relationship.find_by(id: params[:id]).followed

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end
