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
    #price = Stripe::Price.retrieve(@article.stripe_price_id)
    #mode = price.recurring ? 'subscription' : 'payment'
  
    session = Stripe::Checkout::Session.create({
      metadata: {
      #  article_id: @article.id, 
      },
      #customer_email: current_user.email,
      line_items: [
        {
         # price: @article.stripe_price_id,
         # quantity: 1,
        }
      ],
      #mode: mode,
      success_url: root_url + "purchase_success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:  payment_url(@payment),
    })
  
    redirect_to session.url, allow_other_host: true, status: 303
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:amount, :stripe_payment_id, :status)
    end
      
end
