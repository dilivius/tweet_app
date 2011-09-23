class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]	

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
    @title = @user.name
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
  		#It worked
  		redirect_to @user, :flash => { :success => "The profile has been updated!"}
	else
		@title = "Edit User"
		render 'edit'
	 end
  end
  
  private
  def authenticate
  	#flash[:notice] = "Please sign in to access this page"
  	deny_access unless signed_in?
  end
  
  def correct_user
   	@user = User.find(params[:id])
  	redirect_to root_path unless current_user?
  end
  
end
