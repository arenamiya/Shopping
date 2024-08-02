class Customer < ApplicationRecord
    attr_accessor :remember_token
    
    before_save { self.email = email.downcase }
    validates :username, presence: true, length: { maximum: 16 } 
    validates :email, presence: true, length: { maximum: 100 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i},
            uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 8, maximum: 20}, allow_nil: true
    has_secure_password
    
    def Customer.digest(string) 
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    def Customer.new_token 
        SecureRandom.urlsafe_base64 
    end
 
    def remember
        self.remember_token = Customer.new_token
        update_attribute(:remember_digest, Customer.digest(remember_token))
    end
    
    def forget 
        update_attribute(:remember_digest, nil) 
    end
    
    def authenticated?(remember_token) 
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
end
