json.groups current_user.groups do |group|
  json.id group.id
  json.name group.name
  json.description group.description
  json.posts group.posts do |post|
    json.id post.id
    json.title post.title
    json.user_id post.user.id
    json.comments post.comments do |comment|
      json.id comment.id
      json.body comment.body
      json.user_id comment.user.id
    end
  end
end
