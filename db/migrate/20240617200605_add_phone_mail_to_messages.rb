class AddPhoneMailToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :receiver_phone_number, :string
    add_column :messages, :receiver_mail, :string
  end
end
