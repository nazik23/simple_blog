class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

	def comment_owner
		user = User.find(self.user_id)
		return "#{user.last_name} #{user.first_name}"
	end

end
