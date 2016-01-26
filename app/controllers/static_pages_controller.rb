class StaticPagesController < ApplicationController
  def home
  	@promotions = Promotion.last(3).reverse
  end

  def about
  end

  def help
  end
end
