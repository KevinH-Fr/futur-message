class StripeController < ApplicationController
  def purchase_success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])

    if session.payment_status == 'paid'

      Payment.new(
        stripe_payment_id: session,
        amount: session.amount_total,
        status: = 'paid'
      )

    end

  end
end
