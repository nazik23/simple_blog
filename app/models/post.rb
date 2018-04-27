class Post < ApplicationRecord
	acts_as_taggable_on :tags
	validates :body, presence: true, length:
	       	{ maximum: 1000, too_long: "%{count} characters is maximum allowed."}
	validates :title, length: {in: 5..100 }, allow_blank: true
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_attached_file :picture, styles: { medium: "600x600>", thumb: "100x100>"}
	validates_attachment :picture, content_type: { content_type: ["image/jpg", "image/png", "image/gif"]}, size: { in: 0..3.megabytes }, allow_blank: true

end
