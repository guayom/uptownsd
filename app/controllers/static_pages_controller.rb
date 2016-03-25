class StaticPagesController < ApplicationController
  def home
  	@promotions = Promotion.only_active

  	@slides = Slide.last(3).reverse
  	@game_lines = GameLine.last(6).reverse
  end

  def about
  end

  def help
  end
end
