class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { order("created_at DESC") }, dependent: :destroy
  
  # Title is required, and has to be unique.
  validates :title, presence: true, uniqueness: true
  
  # Body needs to be 50 or more characters.
  validates :body, length: {minimum: 50}
end
