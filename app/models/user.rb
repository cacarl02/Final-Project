class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :bookings
  has_many :trips

  def add_balance(amount)
    amount = amount.to_f
    if amount > 0
      self.balance += amount
    end
  end
end
