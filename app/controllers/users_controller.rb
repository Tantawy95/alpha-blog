class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def show 
    @articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile information was updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy 
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles are successfully deleted"
    redirect_to root_path
  end

  private
  
  def user_params
    params.require(:user).permit(:username,:email,:password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  
  def require_same_user
    if @user != current_user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your profile"
      redirect_to user_path(@user)
    end
  end

  def require_new_user
    if logged_in?
      flash[:alert] = "You're already signed up"
      redirect_to user_path(current_user)
    end
  end
end