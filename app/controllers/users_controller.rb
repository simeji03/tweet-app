class UsersController < ApplicationController
  before_action :logout_user, {only: [:index, :show, :edit, :update, :logout]}
  before_action :login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:users][:name],
      email: params[:users][:email],
      image_name: "default_user.jpg",
      password: params[:users][:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to "/posts"
    else
      render("users/new")
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:users][:name]
    @user.email = params[:users][:email]
    if params[:users][:password]
      @user.password = params[:users][:password]
    end
    if params[:users][:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:users][:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to "/users/#{@user.id}"
    else
      render("users/edit")
    end
  end
  
  def login_form
    @user = User.new
  end
  
  def login
    @user = User.find_by(email: params[:users][:email])
    if @user && @user.authenticate(params[:users][:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to "/posts"
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:users][:email]
      @password = params[:users][:password]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/login"
  end
  
  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to "/posts"
    end
  end
end
