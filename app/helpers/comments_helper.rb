module CommentsHelper
	def owner_of(comment)
		user = User.find(comment.user_id)
		return "#{user.last_name} #{user.first_name}"
	end
end
