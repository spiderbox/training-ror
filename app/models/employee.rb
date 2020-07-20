class Employee < ApplicationRecord
    has_secure_password
    # alias_attribute :password_digest, :password
    validates :name, presence: true
    validates :password, presence: true
    validates :dob, presence: true
    validates :phone, presence: true
    validates :email, presence: true
end
