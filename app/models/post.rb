class Post < ActiveRecord::Base
  belongs_to :user

  scope :of_user, -> (user) { where(user_id: user) }
end