class User < ApplicationRecord
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  before_save :downcase_email

  def favorited?(fixture_id)
    favorites.exists?(fixture_id: fixture_id)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
