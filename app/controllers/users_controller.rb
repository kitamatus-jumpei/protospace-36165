class UsersController < ApplicationController

  def show
    # binding.pry
    @user = User.find(params[:id])
    @prototypes = @user.prototypes.includes(:user)
  end
end
