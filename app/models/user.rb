class User < ApplicationRecord
  has_and_belongs_to_many :groups, :join_table => :users_groups
  has_many :posts
  has_many :comments
  has_secure_password
  validates :index, presence: true, length: { is: 6 }, uniqueness: true
  validates :name, presence: true, uniqueness: true, length: { in: 5..50 }
  validates :password, presence: true, length: { minimum: 6 }
  def follows?(group)
  self.groups.include?(group)
  end
end
