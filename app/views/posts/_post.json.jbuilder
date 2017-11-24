json.extract! post, :id, :title, :user_id, :group_id, :created_at, :updated_at
json.comments	post.comments	do	|comment|
		json.id	comment.id
		json.body	comment.body
		json.user_id	comment.user.id
end
