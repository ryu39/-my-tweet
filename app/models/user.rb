class User < ApplicationRecord
  has_secure_password

  has_many :tweets, ->() { order(id: :desc) }
end
