class User < ActiveRecord::Base

  has_many :orders, inverse_of: :user

  validates :name, presence: true

end