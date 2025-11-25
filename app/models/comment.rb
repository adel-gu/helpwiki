class Comment < ApplicationRecord
  acts_as_tenant :workspace
  belongs_to :article
  belongs_to :user

  enum :comment_type, { task: 0, inline: 1 }

  validates :content, presence: true
  validates :comment_type, presence: true

  after_create_commit :broadcast_task_comment, if: :task?

  private

  def broadcast_task_comment
    broadcast_append_to article, target: "task_comments", partial: "app/comments/comment", locals: { comment: self }
  end
end
