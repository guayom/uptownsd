class PromotionsController < ApplicationController
  def show
  	@promotion = Promotion.find(params[:id])
  end
end
