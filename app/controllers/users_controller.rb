class UsersController < ApplicationController
  def investor_apply
    @user = User.find(params[:id])
  end

  def trader_apply
    @user = User.find(params[:id])
  end

  def investor_applied
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        @user.investor_apply
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :investor_apply }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def trader_applied
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        @user.trader_apply
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :trader_apply }
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
      params.require(:user).permit(
        :real_name, :id_card_number, :email, :password, :username, 
        :birthday, :gender, :education, :address, :job, :cell,
        photos_attributes: [:id, :title, :photo, :destroy])
    end
end