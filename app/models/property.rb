class Property < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  validates :user_id,     presence: true
  validates :name,        presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 140 }
  validates :recommend,
            :numericality => {
                :only_interger => true,
                :greater_than_or_equal_to => 1,
                :less_than_or_equal_to =>5
            },
            allow_nil: true 
  validate :picture_size

  def feed_comment(property_id)
    Comment.where("property_id = ?", property_id)
  end

  private
  
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, ":5MBより大きい画像はアップロードできません。")
    end
  end
end
