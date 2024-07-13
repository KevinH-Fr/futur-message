class MessagesController < ApplicationController

  include MessagesHelper
  
  before_action :authenticate_user!

  before_action :set_message, only: %i[ show edit update destroy  ]
  before_action :authorize_sender, only: [:edit, :update, :destroy]

  # GET /messages or /messages.json
  def index
    @messages = Message.where(receiver_id: current_user.id)
    @send_messages = Message.where(sender_id: current_user.id)

    @past_messages = @messages.past
    @upcoming_messages = @messages.upcoming
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
    @users = User.all
  end

  # GET /messages/1/edit
  def edit
    @users = User.all
    @message.receiver_phone_number = format_phone_number(@message.receiver_phone_number) if @message.receiver_phone_number.present?
   
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    @users = User.all
  
    respond_to do |format|
      if @message.save
          format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
          format.json { render :show, status: :created, location: @message }
    
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end  

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    @users = User.all

    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def schedule_email

    @message = Message.find(params[:message])
    send_time = @message.sent_at
    
    # Schedule the email using Active Job
    EmailJob.set(wait_until: send_time).perform_later(@message.id)
    
    redirect_to message_path(@message.id), notice: 'Email scheduled successfully!'

  end

  def send_email
    @message = Message.find(params[:message])
    #@user = User.find(params[:receiver_id]) # Or however you get the @user object
    MessageMailer.welcome_email(@message.receiver_id).deliver_later
    redirect_to message_path(@message.id), notice: 'Email sent successfully!'
  end

  def create_checkout_session

    produit = Produit.find(params[:produit_id])
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
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:title, :content, :sender_id, :receiver_id, :sent_at, :document, :mail, :sms, :receiver_mail, :receiver_phone_number, :paid_option)
    end

    def authorize_sender
      unless user_is_sender?(@message)
        redirect_to messages_path, alert: 'You are not authorized to edit this message.'
      end
    end

    def format_phone_number(phone_number)
      # Remove the "+33" prefix and add spaces
      number_without_prefix = phone_number.gsub(/\A\+33/, '')
      formatted_number = number_without_prefix.gsub(/(\d{1})(\d{2})(\d{2})(\d{2})(\d{2})/, '\1 \2 \3 \4 \5')
      formatted_number.strip
    end

end
