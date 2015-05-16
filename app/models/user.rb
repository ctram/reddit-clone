# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
 validates :username, :password_digest, presence: true
 validates :password, length: {minimum: 1, allow_nil: true}
 attr_reader :password
 after_initialize :ensure_session_token

 has_many :posts

 has_many :subs

 has_many :comments, dependent: :destroy

 def self.generate_session_token
    SecureRandom.urlsafe_base64
 end

 def self.find_by_credentials(username, password)
   user = User.find_by(username: username)
   return nil if user.nil?
   user.is_password?(password) ? user : nil
 end

 def password=(password)
   @password = password
   self.password_digest = BCrypt::Password.create(password)
 end

 def is_password?(password)
   BCrypt::Password.new(self.password_digest) == password
 end

 def ensure_session_token
   self.session_token ||= User.generate_session_token
 end




 def reset_session_token
   self.session_token = User.generate_session_token
   self.save!
   self.session_token
 end


end
