class Dislike < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
end
