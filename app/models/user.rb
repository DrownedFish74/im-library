class User < ApplicationRecord
  authenticates_with_sorcery!
  has_secure_password

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:password_digest] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:password_digest] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password_digest] }

  validates :name, presence: true
  validates :name,uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :books
  has_many :wishes
  has_many :users, through: :friend
  has_many :impressions
end
