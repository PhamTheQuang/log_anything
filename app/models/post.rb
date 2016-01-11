class Post < ActiveRecord::Base
  belongs_to :user

  scope :of_user, -> (user) { where(user_id: user) }

  validates_uniqueness_of :unique_id, scope: :user_id, allow_nil: true, allow_blank: true
end
