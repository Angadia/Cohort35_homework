class Post < ApplicationRecord
  has_many :comments, -> { order("created_at DESC") }, dependent: :delete_all
  
  # Title is required.
  validates :title, presence: true

  # Title has to be unique.
  validates :title, uniqueness: true
  
  # Body needs to be 50 or more characters.
  validates :body, length: {minimum: 50}
end
