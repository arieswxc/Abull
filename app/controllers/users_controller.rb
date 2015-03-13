class UsersController < ApplicationController
  def edit_real_name
    @user = User.find(params[:id])
  end

  def update_real_name
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit_real_name }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user             = User.find(params[:id])
    @funds            = @user.funds
    @invests          = @user.invests
    @leverages        = @user.leverages
    @topics           = Topic.where(user_id: @user.following_users.ids)
    @recommend_funds  = Fund.where(user_id: @user.following_users.ids)
  end

  private
    def user_params
      params.require(:user).permit(:real_name, :id_card_number, :email, :password, :nick_name)
    end
end