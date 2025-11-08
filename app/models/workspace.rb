class Workspace < ApplicationRecord
  has_many :users
  has_many :categories
  has_many :articles
  has_many :activity_logs

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true,
                        format: { with: /\A[a-z0-9\-]+\z/, message: "only allows lowercase letters, numbers, and hyphens" }
end
