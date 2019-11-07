module UsersHelper
  def gravatar_for user, option = {size: Settings.size}
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    size = option[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def find_active_relationships
    current_user.active_relationships.find_by(followed_id: @user.id)
  end

  def active_relationships_build
    current_user.active_relationships.build
  end
end
