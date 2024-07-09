class RenameStripePaymentIdToStripeProductIdInPayments < ActiveRecord::Migration[7.1]
  def change
    rename_column :payments, :stripe_payment_id, :stripe_product_id
  end
end
