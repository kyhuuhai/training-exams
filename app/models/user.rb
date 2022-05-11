class User < ApplicationRecord
  has_many :user_exams, dependent: :destroy
  has_one :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image, reject_if: proc { |attributes| attributes[:image_url].blank? }
  has_many :examcarts
  attr_accessor :remember_token, :reset_token
  has_many :active_examcarts, class_name: "Examcart", foreign_key: "user_id", dependent: :destroy
  has_many :selecting, through: :active_examcarts, source: :exam
  validates :name, presence: true,
                   length: { maximum: Settings.model.user.name_length_max }
  validates :email, format: { with: Settings.email_regex },
                    length: { maximum: Settings.model.user.email_length_max },
                    uniqueness: { case_sensitive: false },
                    presence: true
  has_secure_password
  validates :password, length: { minimum: Settings.model.user.password_length_min },
                       presence: true

  enum role: { user: 0, admin: 1 }

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
      return unless digest
    BCrypt::Password.new(digest).is_password?(token)
  end


  class << self
    def digest(string)
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

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def select other_exam
    active_examcarts.create(exam_id: other_exam.id)
  end

  def unselect other_exam
    active_examcarts.find_by(exam_id: other_exam.id).destroy
  end

  def selecting? other_exam
    selecting.include?(other_exam)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end

