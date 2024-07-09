json.extract! produit, :id, :stripe_product_id, :stripe_price_id, :amount, :created_at, :updated_at
json.url produit_url(produit, format: :json)
