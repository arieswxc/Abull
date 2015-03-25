class BillingsController < ApplicationController
  def index
    @billings = current_user.account.billings
  end
end