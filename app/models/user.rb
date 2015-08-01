class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_attached_file :avatar, :styles => { :medium => "400x267#", :thumb => "200x134#" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  after_save :generate_qr_code


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name  # assuming the user model has a name
      user.last_name = auth.info.last_name  # assuming the user model has a name
      user.location = auth.info.location
      user.picture_from_url(auth.info.image) # assuming the user model has an image
    end
  end

  def picture_from_url(url)
    url = url.gsub("http","https")
    self.avatar = URI.parse(url)
  end

  def name
    [first_name,last_name].join(" ")
  end

  private

  def generate_qr_code
    QrGenerator.new(self.id).generate
  end
end
