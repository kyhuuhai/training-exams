class User < ApplicationRecord
  has_many :user_exams, dependent: :destroy
  attr_accessor :remember_token
  validates :name, presence: true,
                   length: { maximum: Settings.model.user.name_length_max }
  validates :email, format: { with: Settings.email_regex },
                    length: { maximum: Settings.model.user.email_length_max },
                    uniqueness: { case_sensitive: false },
                    presence: true
  has_secure_password
  validates :password, length: { minimum: Settings.model.user.password_length_min },
                        presence: true

  enum role: {user: 0, admin: 1}

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return unless digest

    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
