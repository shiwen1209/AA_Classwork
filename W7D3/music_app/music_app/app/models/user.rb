# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence:true
    after_initialize :ensure_session_token!

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        if user && user.check_password(password)
            return user
        end
        nil 
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def check_password(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end 

    def ensure_session_token!
        self.session_token ||= SecureRandom::urlsafe_base64
    end


    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end



    

    private
    attr_reader :password
end
