class AddTypesenvoiToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :mail, :boolean
    add_column :messages, :sms, :boolean
  end
end
