class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # validation
  validates :pailog_id,
            presence: true,
            length: { minimum: 3, maimum: 15 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # relation
  has_many :shelves
  has_many :books, through: :shelves
end
