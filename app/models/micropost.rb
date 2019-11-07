class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, length: {maximum: Settings.content_length}
  validates :image,
            content_type: {in: Settings.rails_size,
                           message: I18n.t("must_be_a")},
            size: {less_than: Settings.image_size.megabytes,
                   message: I18n.t("should_be_less_than")}

  scope :order_by_created_at, ->{order created_at: :desc}
  scope :feed, (lambda do |id|
    where(user_id: Relationship.following_ids(id))
    .or(Micropost.where(user_id: id))
  end)

  def display_image
    image.variant resize_to_limit: [Settings.limit_image, Settings.limit_image]
  end
end
