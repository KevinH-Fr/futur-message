json.extract! payment, :id, :amount, :stripe_payment_id, :status, :created_at, :updated_at
json.url payment_url(payment, format: :json)
