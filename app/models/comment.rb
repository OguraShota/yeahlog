class Comment < ApplicationRecord
  belongs_to :property
  validates :user_id,     presence: true
  validates :property_id, presence: true
  validates :content,     presence: true, length: { maximum: 50 }
end
