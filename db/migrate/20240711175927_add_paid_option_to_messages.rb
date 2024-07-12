class AddPaidOptionToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :paid_option, :boolean
  end
end
