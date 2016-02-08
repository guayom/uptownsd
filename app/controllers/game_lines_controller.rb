class GameLinesController < ApplicationController
  #quité el show de la acción
  before_action :set_game_line, only: [ :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @game_lines = GameLine.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game_line = GameLine.find(params[:id])
  end

  # GET /games/new
  def new
    @game_line = GameLine.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game_line = GameLine.new(game_line_params)

    respond_to do |format|
      if @game_line.save
        format.html { redirect_to @game_line, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game_line }
      else
        format.html { render :new }
        format.json { render json: @game_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game_line.update(game_params)
        format.html { redirect_to @game_line, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_line }
      else
        format.html { render :edit }
        format.json { render json: @game_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game_line.destroy
    respond_to do |format|
      format.html { redirect_to game_lines_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game_line = GameLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:sport_id, :date)
    end
end
