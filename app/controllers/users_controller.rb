class UsersController < ApplicationController
  before_action :authenticate_user, except: :new
  def authenticate_user
    unless logged_in?
      flash[:notice] = t('notice.login_needed')
      redirect_to new_session_path
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def destroy
  end
    private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
