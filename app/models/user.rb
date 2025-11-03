class User < ApplicationRecord
  acts_as_tenant :workspace, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { reader: 1, collaborator: 2, editor: 3, admin: 4 }

  validates :full_name, presence: true, length: { maximum: 100 }
end
