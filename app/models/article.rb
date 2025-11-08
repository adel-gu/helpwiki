class Article < ApplicationRecord
  acts_as_tenant :workspace

  belongs_to :category, optional: true

  belongs_to :creator, class_name: "User", optional: true
  belongs_to :writer, class_name: "User", optional: true
  belongs_to :reviewer, class_name: "User", optional: true

  has_many :article_versions, dependent: :destroy
  has_many :activity_logs, dependent: :destroy

  has_rich_text :content

  enum :status, { todo: 0, draft: 1, in_review: 2, published: 3, archived: 4 }
  enum :priority, { low: 0, medium: 1, high: 2 }
end
