class Admin::UsersController < UsersController 

  before_filter :restrict_access
  before_filter :user_is_admin

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_user(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    user = @user
    @user.destroy
    redirect_to admin_users_path, notice: "#{user.full_name} was successfully deleted."
  end 

end