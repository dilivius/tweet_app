class UsersController < ApplicationController
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
end
