class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :registerable,
  # :recoverable, :rememberable, :trackable, :validatable,
  # :token_authenticatable
  devise :database_authenticatable

  def admin?
    persisted?
  end

  def guest?
    !persisted?
  end
end
