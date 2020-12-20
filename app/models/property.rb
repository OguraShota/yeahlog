class Property < ApplicationRecord
  belongs_to :user

  validates :user_id,     presence: true
  validates :name,        presence: true
  validates :description, presence: true
  validates :recommend,
            :numericality => {
                :only_interger => true,
                :greater_than_or_equal_to => 1,
                :less_than_or_equal_to =>5
            },
            allow_nil: true 
end
