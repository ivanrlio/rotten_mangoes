class Admin::UsersController < UsersController 

  before_filter :restrict_access
  before_filter :user_is_admin

  def index
    @users = User.all.page(params[:page]).per(5)  
  end

  def create
    binding.pry
    @user = User.new(user_params)
  
    if @user.save
      UserMailer.welcome_email(@user).deliver
      redirect_to(admin_users_path, notice: "User was successfully created")
    else
      render :new
    end
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
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    user = @user
  
    if @user.destroy
      UserMailer.delete_email(user).deliver
       redirect_to(admin_users_path, notice: "#{user.full_name} was successfully deleted.")
    else
      redirect admin_users_path, alert: "User was NOT deleted or could not be found!"
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end