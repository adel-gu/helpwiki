class App::CommentsController < App::BaseController
  def new
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new
  end
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to edit_app_article_path(@article), notice: "Comment added." }
      end
    else
      render :new, status: :unprocessable_entity, alert: @comment.errors.full_messages
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :comment_type)
  end
end
