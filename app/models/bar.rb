class Bar < ApplicationRecord
  belongs_to :foo

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
end
