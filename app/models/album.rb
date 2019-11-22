class Album < ApplicationRecord
  validates :title, :description, :artist, presence: true

  belongs_to :user
  belongs_to :genre

  has_many :reviews

  has_one_attached :image
end
