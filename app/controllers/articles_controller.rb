class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 4)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(params_whitelisting)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Your article was saved successfully"
    redirect_to @article
    else
      render 'new'
    end
  end

  def update
    #@article = Article.find(params[:id])
    if @article.update(params_whitelisting)
        flash[:notice] = "Article is updated successfully"
        redirect_to @article
    else
        render 'edit'
    end
  end
  def destroy
   # @article = Article.find(params[:id])
    @article.destroy
    redirect_to @article 
  end

  private 
  def set_article
    @article = Article.find(params[:id])
  end
  def params_whitelisting
    params.require(:article).permit(:title, :description)
  end
 
end
