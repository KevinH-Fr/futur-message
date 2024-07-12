class StripeController < ApplicationController
  def purchase_success

    session = Stripe::Checkout::Session.retrieve(params[:session_id])

    if session.payment_status == 'paid'
      product_id = session.metadata.product_id
      @produit = Produit.find(product_id)

      Payment.create(
        stripe_product_id: @produit.stripe_product_id,
        amount: session.amount_total,
        status: 'paid'
      )


    end

  end
end
