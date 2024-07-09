class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[ show edit update destroy create_checkout_session ]

  # GET /payments or /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy!

    respond_to do |format|
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def create_checkout_session

    produit = Produit.find(params[:id])
    price = Stripe::Price.retrieve(produit.stripe_price_id)
    price_value = produit.amount
      
      line_items = [
        {
          price_data: {
            currency: 'eur',
            product_data: {
              name: produit.name,
              #metadata: {
              #  product_id: #@campaign.id # Add product identifier as metadata
              #}
            },
            unit_amount: price_value,
          },
          quantity: 1
        }
      ]
    
  
    session = Stripe::Checkout::Session.create(
      {
        metadata: {
          product_id: produit.id
        },
        customer_email: current_user.email,
        line_items: line_items,
        mode: 'payment',
        success_url: root_url + "purchase_success?session_id={CHECKOUT_SESSION_ID}",
        #cancel_url: #campaign_url(@campaign),
      }
    )
  
    redirect_to session.url, allow_other_host: true, status: 303
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:amount, :stripe_product_id, :status)
    end
      
end
