class PromotionsController < ApplicationController
  def view
  	@promo = Promotion.find(params[:id])
  end
end
