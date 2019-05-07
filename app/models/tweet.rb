class Tweet < ApplicationRecord
    has_many :likes, :dependent => :destroy
    has_many :dislikes, :dependent => :destroy
    belongs_to :user
    validates :content, presence: true, length: { minimum: 1, maximum: 140 }
end
