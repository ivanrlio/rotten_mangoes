class Admin::UsersController < UsersController 

  def index
    if user_is_admin
     @users = User.all
    end
  end

  def edit
    if user_is_admin
     @user = User.find(params[:id])
   end
  end

  def show
    if user_is_admin
      @user = User.find(params[:id])
    end
  end

  def update
    if user_is_admin

      @user = User.find(params[:id])

      if @user.update_attributes(user_params)
        redirect_to admin_user(@user)
      else
        render :edit
      end
    end
  end

  def destroy
    if user_is_admin
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path
    end
  end 

end