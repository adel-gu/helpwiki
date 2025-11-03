class Workspace < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true,
                        format: { with: /\A[a-z0-9\-]+\z/, message: "only allows lowercase letters, numbers, and hyphens" }
end
