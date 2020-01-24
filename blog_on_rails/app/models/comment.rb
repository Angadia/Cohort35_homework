class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  before_validation :squeeze_strip_whitespaces

  validates :body, presence: true, length: {minimum: 1}

  private

  def squeeze_strip_whitespaces
    self.body.squeeze(" ").strip
  end
end
