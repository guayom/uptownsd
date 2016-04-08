class ChangeDefaultBetStatus < ActiveRecord::Migration
  def change
    change_column_null :bets, :status, false, 1
    change_column_default :bets, :status, 1
  end
end
