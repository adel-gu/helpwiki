class ArticleVersion < ApplicationRecord
  acts_as_tenant :workspace

  belongs_to :article
  belongs_to :author, class_name: 'User'
end
