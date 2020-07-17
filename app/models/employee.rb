class Employee < ApplicationRecord
    has_secure_password
    # alias_attribute :password_digest, :password
    
end
