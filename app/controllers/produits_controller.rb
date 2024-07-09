class ProduitsController < ApplicationController
  before_action :set_produit, only: %i[ show edit update destroy ]

  # GET /produits or /produits.json
  def index
    @produits = Produit.all
  end

  # GET /produits/1 or /produits/1.json
  def show
  end

  # GET /produits/new
  def new
    @produit = Produit.new
  end

  # GET /produits/1/edit
  def edit
  end

  # POST /produits or /produits.json
  def create
    @produit = Produit.new(produit_params)

    respond_to do |format|
      if @produit.save

        create_stripe_product_and_price(@produit)

        format.html { redirect_to produit_url(@produit), notice: "Produit was successfully created." }
        format.json { render :show, status: :created, location: @produit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @produit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produits/1 or /produits/1.json
  def update
    respond_to do |format|
      if @produit.update(produit_params)

        create_stripe_product_and_price(@produit)

        format.html { redirect_to produit_url(@produit), notice: "Produit was successfully updated." }
        format.json { render :show, status: :ok, location: @produit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @produit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produits/1 or /produits/1.json
  def destroy
    @produit.destroy!

    respond_to do |format|
      format.html { redirect_to produits_url, notice: "Produit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produit
      @produit = Produit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def produit_params
      params.require(:produit).permit(:name, :stripe_product_id, :stripe_price_id, :amount)
    end

    def create_stripe_product_and_price(produit)
      # Create a product in Stripe
      product = Stripe::Product.create(name: produit.name, description: produit.name)
    
      # One-time payment case
      price = Stripe::Price.create({
        product: product.id,
        currency: 'eur',
        custom_unit_amount: {
          enabled: true
        },
      })
    
      # Save the Stripe product and price IDs in the produit
      produit.update(stripe_product_id: product.id, stripe_price_id: price.id)
      
    end
end
