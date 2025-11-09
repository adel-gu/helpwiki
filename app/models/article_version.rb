class ArticleVersion < ApplicationRecord
  belongs_to :article
  belongs_to :author, class_name: "User"
end
