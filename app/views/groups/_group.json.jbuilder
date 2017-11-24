json.extract! group, :id, :name, :description, :created_at, :updated_at
json.url group_url(group, format: :json)
json.posts	group.posts	do	|post|
		json.id	post.id
		json.title	post.title
		json.user_id	post.user.id
		json.comments	post.comments	do	|comment|
				json.id	comment.id
				json.body	comment.body
				json.user_id	comment.user.id
		end
end
