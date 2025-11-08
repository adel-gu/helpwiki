require 'rails_helper'

RSpec.describe ActivityLog, type: :model do
  it { should belong_to(:workspace) }
  it { should belong_to(:article) }
  it { should belong_to(:actor) }
  it { should define_enum_for(:action).with_values(created_article: 0,
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
    added_comment: 30) }
end
