class BankCardsController < ApplicationController
  def show
    @bank_card = current_user.bank_card
  end

  def create
    @bank_card = current_user.build_bank_card(bank_card_params)
    if @bank_card.save
      redirect_to user_bank_card_path(@bank_card)
    else
      render user_bank_card_path(@bank_card)
    end
  end

  def edit
    @bank_card = current_user.bank_card
  end

  def update
    @bank_card = current_user.bank_card
    if @bank_card.update(bank_card_params)
      @bank_card.update_card
      redirect_to user_bank_card_path(@bank_card)
    end
  end

  private
    def bank_card_params
      params.require(:bank_card).permit(:number, :bank_name, :bank_branch, :user_id)
    end
end
