class Favorite < ApplicationRecord
  belongs_to :user

  validates :fixture_id, presence: true, uniqueness: { scope: :user_id }
end
