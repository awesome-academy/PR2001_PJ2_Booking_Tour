class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.from_omniauth(auth)
    result = User.where(email: auth.info.email).first
    result || where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.uid = auth.uid
      user.provider = auth.provider

      #  If you are using confirmable and the provider(s) you use validate emails
      user.skip_confirmation!
    end
  end

  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, uniqueness: { case_sensitive: false }

  has_many :booking_tours, dependent: :destroy
  has_many :rates, dependent: :destroy

  private
  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end
end
