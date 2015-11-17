class User < ActiveRecord::Base
  has_many :votes

  validates :password,  presence: true
end
