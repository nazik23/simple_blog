class Post < ApplicationRecord
	acts_as_taggable_on :tags
	validates :body, presence: true, length:
	       	{ maximum: 1000, too_long: "%{count} characters is maximum allowed."}
	validates :title, length: {in: 5..100 }, allow_blank: true
	belongs_to :user

end
