class AddNameToProduits < ActiveRecord::Migration[7.1]
  def change
    add_column :produits, :name, :string
  end
end
