class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email,
            presence: true, on: :create

  validates :first_name,
            :middle_name,
            :last_name,
            presence: true, on: :update

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
