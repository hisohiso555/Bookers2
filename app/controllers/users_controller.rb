class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
  	@book_form = Book.new
  	@books = @user.books.page(params[:page]).reverse_order
  end

  def index
  	@user = current_user
  	@users = User.all
  	@book_form = Book.new

  end

  def edit
  	@user = User.find(params[:id])
  	if @user.id != current_user.id
  		redirect_to user_path(current_user.id)
  	end
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
    render action: :edit
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
