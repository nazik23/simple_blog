class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
	validates :body, presence: true, length: { maximum: 1000, too_long: "%{count} characters is maximum allowed." }
end
