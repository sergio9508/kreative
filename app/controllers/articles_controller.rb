class ArticlesController < ApplicationController
  def index
    @articles = Article.enabled.order(published_at: :desc)
    @articles = @articles.paginate({page: params[:page], per_page:6})
  end

  def show
    @article = Article.find params[:id]
    @articles = Article.enabled.order(published_at: :desc).where.not(id: @article.id).limit(3)
    set_meta_tags @article.metatags
  end
end
