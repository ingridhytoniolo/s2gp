class Resource < ApplicationRecord
  enum kind: { financial: 'financial', material: 'material' }

  has_and_belongs_to_many :projects

  validates :kind, presence: true
  validates :name, presence: true
end
