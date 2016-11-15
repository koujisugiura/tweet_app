class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:info] = 'ログインしました'
      redirect_to user
    else
      flash[:danger] = 'メールアドレスもしくはパスワードが間違っています'
      render 'new'
    end
  end
  
  def destroy
    log_out
    flash[:danger] = "また今度ログインしてください"
    redirect_to root_url
  end
end
