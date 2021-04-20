class Token < ApplicationRecord
  belongs_to :user
  validates :token, :expires_at, :user_id, presence: true
end
