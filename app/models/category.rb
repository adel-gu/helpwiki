class Category < ApplicationRecord
  acts_as_tenant :workspace

  belongs_to :creator, class_name: "User"
  belongs_to :parent_category, class_name: "Category", optional: true

  has_many :sub_categories, class_name: "Category", foreign_key: "parent_category_id", dependent: :destroy
  has_many :articles, dependent: :nullify

  validates :name, presence: true
end
