class Setting < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
end
