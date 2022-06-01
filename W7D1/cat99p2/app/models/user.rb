# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :user_name, presence: true, uniqueness: true 
    validates :password_digest, presence: { message: "Password can't be blank"}
    validates :session_token, presence: true, uniqueness: true 
    validates :password, length: { minimum: 6, allow_nil: true }

    attr_reader :password 
    after_initialize :ensure_session_token

    has_many :cats,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Cat

    has_many :cat_rental_requests,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :CatRentalRequest
     

    def self.find_by_cendentials(user_name, password)
        user = User.find_by(user_name: user_name)
        if user 
            if user.is_password?(password)
                return user
            end
        end
        nil 
    end

    def reset_session_token!
        self.session_token ||= SecureRandom::urlsafe_base64
        self.save!
        self.session_token 
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password 
    end

    def ensure_session_token 
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password )
    end
end
