class CreateProduits < ActiveRecord::Migration[7.1]
  def change
    create_table :produits do |t|
      t.string :stripe_product_id
      t.string :stripe_price_id
      t.integer :amount

      t.timestamps
    end
  end
end
