class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save :downcase_email
  validates :name,
            presence: true,
            length: {maximum: 50}
  validates :email,
            presence: true,
            length: {maximum: 255},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  private
  def downcase_email
    email.downcase!
  end

  def self.digest string # rubocop:disable Lint/IneffectiveAccessModifier
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine.MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost:
  end
end
