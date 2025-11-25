class Comment < ApplicationRecord
  acts_as_tenant :workspace
  belongs_to :article
  belongs_to :user

  enum :comment_type, { task: 0, inline: 1 }

  validates :content, presence: true
  validates :comment_type, presence: true
end
