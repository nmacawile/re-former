class User < ApplicationRecord
	before_save { email.downcase! }
	has_secure_password
	validates :username, presence: true,
	                     length: { minimum: 3, maximum: 20 },
	                     format: { with: /\A[\w\-]*\z/ },
                         uniqueness: { case_sensitive: false }
	validates :email, presence: true,
	                  length: { maximum: 100 },
	                  format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
	                  uniqueness: { case_sensitive: false }
	validates :password, presence: true,
	                     length: { minimum: 6 }
end
