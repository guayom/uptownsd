class TransactionsController < ApplicationController
  load_and_authorize_resource

  def create
    @transaction.save
    redirect_to profile_user_path(current_user)
  end

  private

  def transaction_params
    params.require(:transaction).permit(:user_id, :kind, :amount)
  end
end
