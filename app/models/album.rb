class Album < ApplicationRecord
  belongs_to :user
  belongs_to :genre

  has_many :reviews

  has_one_attached :image
end
