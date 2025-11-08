class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # -- Associations --
  acts_as_tenant :workspace, optional: true

  # Articles this user created, is writing, or is reviewing
  has_many :created_articles, class_name: "Article", foreing_key: :creator_id, dependent: :nullify
  has_many :written_articles, class_name: "Article", foreing_key: :writer_id, dependent: :nullify
  has_many :reviewed_articles, class_name: "Article", foreing_key: :reviewer_id, dependent: :nullify

  # Category
  has_many :created_categories, class_name: "Category", foreign_key: :creator_id ,dependent: :nullify

  # Article version
  has_many :article_versions, class_name: "Article_versions", foreign_key: :author_id, dependent: :nullify

  # Activity log
  has_many :activity_logs, class_name: "ActivityLogs", foreign_key: :actor_id, dependent: :nullify

  # -- Validation --
  enum :role, { reader: 1, collaborator: 2, editor: 3, admin: 4 }

  validates :full_name, presence: true, length: { maximum: 100 }, unless: :invitation_created?

  private

  def invitation_created?
    invitation_token.present?
  end
end
