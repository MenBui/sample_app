class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost = current_user.microposts.build
    @feed_items = Micropost.feed(current_user.id).order_by_created_at
                           .page(params[:page]).per Settings.size_page
  end

  def help; end

  def about; end

  def contact; end
end
