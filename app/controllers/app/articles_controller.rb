class App::ArticlesController < App::BaseController
  before_action :set_article, only: %i[ edit update ]

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

  def update
    if @article.update(article_params)
      respond_to do |format|
        format.html { redirect_to edit_app_article_path(@article) }
        format.json { render json: @article, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @article.errors, status: :unprocessable_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.expect(article: [ :title, :content, :category_id ])
    end
end
