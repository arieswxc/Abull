class UsersController < ApplicationController
  def investor_apply
    @user = User.find(params[:id])
  end

  def trader_apply
    @user = User.find(params[:id])
  end

  def applied
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        @user.investor_apply if @user.level == "unverified" || @user.level == "investor_applied"
        @user.trader_apply if @user.level == "investor" || @user.level == "trader_applied"
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
      params.require(:user).permit(
        :real_name, :id_card_number, :email, :password, :nick_name, 
        :birthday, :gender, :education, :address, :job,
        photos_attributes: [:id, :title, :photo, :destroy])
    end
end