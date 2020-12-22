class Property < ApplicationRecord
  belongs_to :user
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
end
