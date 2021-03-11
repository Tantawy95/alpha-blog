class PrivateArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  before_action :require_same_user, only: [:show, :edit, :update, :destroy]


  def index
    if logged_in?
    @private_articles = PrivateArticle.all
    else
      flash[:alert] = "You must be logged in to do that action"
      redirect_to root_path
    end
  end

  def new
    @private_article = PrivateArticle.new
  end

  def create
    @private_article = PrivateArticle.new(params_whitelisting)
    @private_article.user = current_user
    if @private_article.save
      flash[:notice] = "Private article was created successfully"
      redirect_to private_articles_path
    else
      render 'new'
    end
  end

  def show 
  
  end

  def edit
   
  end

  def update
    if @private_article.update(params_whitelisting)
      flash[:notice] = "Article is updated successfully"
      redirect_to @private_article
    else
      render 'edit'
    end
  end

  def destroy
    @private_article.destroy
    flash[:notice] = "Article is deleted successfully"
    redirect_to @private_article 
  end

  private
  def set_article
    @private_article = PrivateArticle.find(params[:id])
  end
  
  def params_whitelisting
    params.require(:private_article).permit(:title, :description)
  end
  def require_same_user
    if @private_article.user != current_user
      flash[:alert] = "You can only see, edit or delete your private articles"
      redirect_to private_articles_path
    end
  end
  
 
end