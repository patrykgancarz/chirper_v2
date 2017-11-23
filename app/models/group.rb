class Group < ApplicationRecord
    has_and_belongs_to_many :users, :join_table => :users_groups
    has_many :posts
end
