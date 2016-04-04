class BetsController < ApplicationController
  load_and_authorize_resource

  def create
    @bet.save
    respond_to do |format|
      format.js
    end
  end

  def update
    if @bet.update!(bet_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @bet.draft?
      @bet.destroy
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
