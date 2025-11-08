class ActivityLog < ApplicationRecord
  acts_as_tenant :workspace

  belongs_to :article
  belongs_to :actor, class_name: "User"

  # This list can be expanded as new actions are needed.
  enum :action, {
    # Article Lifecycle
    created_article: 0,
    published_article: 1,
    archived_article: 2,
    restored_article: 3,

    # Status Changes
    changed_status_to_draft: 10,
    changed_status_to_in_review: 11,

    # Metadata Changes
    updated_title: 20,
    updated_assignee: 21,
    updated_reviewer: 22,
    updated_category: 23,
    updated_priority: 24,

    # Collaboration
    added_comment: 30
  }
end
