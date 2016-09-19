class TransactionsController < ApplicationController
  load_and_authorize_resource

  def create
    if @transaction.get_the_win?
      @transaction.amount = - @transaction.amount.abs
    else
      if params[:transaction][:neteller].present?
        current_user.update_attributes!(neteller: params[:transaction][:neteller])
      end
    end

    @transaction.save
    redirect_to profile_user_path(current_user)
  end

  private

  def transaction_params
    params.require(:transaction).permit(:user_id, :kind, :amount)
  end
end
