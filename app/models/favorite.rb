class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :property
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :property_id, presence: true
end
