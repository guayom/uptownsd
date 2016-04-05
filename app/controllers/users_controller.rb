class UsersController < ApplicationController
  load_and_authorize_resource

  def profile
  end

  def bets
    params[:type] ||= 'active'

    @bets = @user.bets

    @bets = @bets.active if 'active' == params[:type]
    @bets = @bets.archived if 'archived' == params[:type]
  end
end
