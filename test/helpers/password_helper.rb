require 'bcrypt'

module TestPasswordHelper
    def default_password_digest
        BCrypt::Password.create(default_password)
    end

    def default_password
        '123'
    end
end