class Employee < ApplicationRecord
    has_secure_password
    # alias_attribute :password_digest, :password
    validates :name, presence: true, on: :create
    validates :password, presence: true, on: :create
    validates :dob, presence: true, on: :create
    validates :phone, presence: true, on: :create
    validates :email, presence: true, on: :create

    has_many :post
end
