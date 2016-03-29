class BetsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @bet = Bet.new(bet_params)
    @bet.user = current_user
    @bet.risk = Bet::DEFAULT_RISK

    if @bet.save!
      respond_to do |format|
        format.js
      end
    end
  end

  def update
    bet = Bet.find(params[:id])
    if bet.update!(bet_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    bet = Bet.find(params[:id])
    if current_user == bet.user && bet.draft?
      bet.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def bet_params
    params.require(:bet).permit(:game_line_id, :team_id, :risk)
  end
end
