class App::ArticlesController < App::BaseController
  before_action :set_app_article, only: %i[ edit ]

  # POST /app/articles
  def create
    @article = current_user.created_articles.build(status: :draft)

    if @article.save
      redirect_to edit_app_article_path(@article), notice: "Article was successfully created."
    else
      redirect_to app_root_path, alert: "Could not create article."
    end
  end

  # GET /app/articles/1/edit
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_article
      @article = Article.find(params.expect(:id))
    end
end
