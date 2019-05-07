class User < ApplicationRecord
    has_many :tweets, :dependent => :destroy
    has_many :likes, :dependent => :destroy
    has_many :dislikes, :dependent => :destroy
    validates :username, presence: true, length: { minimum: 4, maximum: 20 }
end
