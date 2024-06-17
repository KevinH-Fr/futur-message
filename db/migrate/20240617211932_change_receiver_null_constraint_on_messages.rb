class ChangeReceiverNullConstraintOnMessages < ActiveRecord::Migration[7.1]
  def change
    change_column_null :messages, :receiver_id, true
  end
end
