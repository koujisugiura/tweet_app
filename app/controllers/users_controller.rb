class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome 登録完了しました"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "編集しました"
      redirect_to @user
    else
      render 'edit'
    end    
  end
  
  def index
    @users = User.all
    @users = User.paginate(page: params[:page],:per_page => 10)
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "削除しました"
    redirect_to signup_url
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
