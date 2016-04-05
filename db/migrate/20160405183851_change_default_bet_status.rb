class ChangeDefaultBetStatus < ActiveRecord::Migration
  def change
    change_column_null :bets, :status, false, 1
  end
end
