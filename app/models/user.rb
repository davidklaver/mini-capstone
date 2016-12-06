class User < ApplicationRecord
	has_secure_password
	has_many :carted_products
	has_many :products, through: :carted_products
	has_many :orders

	validates :name, presence: true, uniqueness: true
	validates :email, presence: true, confirmation: true, uniqueness: true
	validates_format_of :email, :with => /@/
	validates :email_confirmation, presence: true
	validates :password, length: { minimum: 6 }
end
