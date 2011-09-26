class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]	
  before_filter :admin_user,   :only => [:destroy]

  def index
  	@users = User.paginate(:page => params[:page])
  	@title = "All users"
  end
  
  def new
    @user = User.new
	@title = "Sign Up"
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end
  
  def destroy
  	User.find(params[:id]).destroy
  	redirect_to users_path, :flash => { :success => "User destroyed."}
  end
  
  def create
	@user = User.new(params[:user])
	if @user.save
		#Handle a successful save action
		#/*flash[:success] = "Welcome to my Tweet App"*/
		sign_in @user
		redirect_to @user, :flash => { :success => "Welcome to my Tweet App!"}
	else
		@title = "Sign Up"
		render 'new'
	end
  end
  
  def edit
  	@user = User.find(params[:id])
  	@title = "Edit User"
  end
  
  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
  		redirect_to @user, :flash => { :success => "The profile has been updated!"}
	else
		@title = "Edit User"
		render 'edit'
	 end
  end
  
  private
    
  def correct_user
   	@user = User.find(params[:id])
  	redirect_to root_path unless current_user?(@user)
  end
  
  def admin_user
  	user = User.find(params[:id])
  	redirect_to(root_path) if !current_user.admin? || current_user?(user) 
  end
  
end
