class Announcement < ApplicationRecord
  belongs_to :profile

  validates :description, presence: true
  validates :profile_id, presence: true
  validates :title, presence: true

  scope :active, -> {
    where("(start_at IS NULL OR start_at <= '#{Time.now}') AND (end_at IS NULL OR end_at >= '#{Time.now}')")
  }
end
