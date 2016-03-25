class GameLinesController < ApplicationController
  def index
    @game_lines = GameLine.all
  end

  def show
    @game_line = GameLine.find(params[:id])
  end
end
