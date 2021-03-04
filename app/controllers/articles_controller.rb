class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
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
    flash[:notice] = "Article is deleted successfully"
    redirect_to @article 
  end

  private 
  
  def set_article
    @article = Article.find(params[:id])
  end
  
  def params_whitelisting
    params.require(:article).permit(:title, :description)
  end
  
  def require_same_user
    if @article.user != current_user && !current_user.admin?
      flash[:notice] = "You can only edit or delete your own articles"
      redirect_to @article
    end
  end
 
end
