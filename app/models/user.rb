class User < ApplicationRecord
  has_many :flats, foreign_key: 'owner_id', dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
