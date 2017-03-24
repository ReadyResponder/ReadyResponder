class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all
    @page_title = "All Users"
  end

  def show
    @last_editor = last_editor(@user)
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

end
