class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @users = User.all

    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
