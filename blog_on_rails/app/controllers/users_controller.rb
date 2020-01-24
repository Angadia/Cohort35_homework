class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :password, :update_password]
  before_action :find_user, only: [:edit, :update, :password, :update_password]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "User Created Successfully"
      redirect_to root_path
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit

  end

  def update
    if @user&.update user_params.except(:password, :password_confirmation)
      flash[:notice] = "User Updated Successfully"
      redirect_to root_path
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render :edit
    end
  end

  def password

  end

  def update_password
    if @user&.authenticate(params[:current_password])
      if params[:new_password] != params[:current_password]
        if params[:new_password] == params[:new_password_confirmation]
          if @user.update password: params[:new_password], password_confirmation: params[:new_password_confirmation]
            flash[:notice] = "User Password Updated Successfully"
            redirect_to root_path
          else
            flash.now[:alert] = @user.errors.full_messages.join(', ')
            render :password
          end
        else
          flash.now[:alert] = "New Password Confirmation Failed"
          render :password
        end
      else
        flash.now[:alert] = "New Password Cannot Be Same As Current Password"
        render :password
      end
    else
      flash.now[:alert] = "Current Password Incorrect"
      render :password
    end
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
