class MessagesController < ApplicationController

  include MessagesHelper
  
  before_action :authenticate_user!

  before_action :set_message, only: %i[ show edit update destroy ]
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
   # respond_to do |format|
   #   format.html
     # format.turbo_stream

   # end
  end

  # GET /messages/new
  def new
    @message = Message.new
    @users = User.all
  end

  # GET /messages/1/edit
  def edit
    @users = User.all

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
    MessageMailer.welcome_email(@message.receiver_id).deliver_now
    redirect_to message_path(@message.id), notice: 'Email sent successfully!'
  end

  # def update_content
  #   respond_to do |format|
  #     format.turbo_stream do
  #       render turbo_stream: 
  #         turbo_stream.update(
  #           'partial-container', 
  #           partial: 'shared/content_to_load'
  #         )
  #     end
  #     format.html { render partial: 'shared/content_to_load' } # Ensure compatibility with non-Turbo requests
  #   end
  # end

  # def reload_content

  #   @message = Message.find(1)

  #   respond_to do |format|
  #     format.turbo_stream do
  #       render turbo_stream: 
  #         turbo_stream.update(
  #           'partial-container', 
  #           partial: 'messages/message',
  #           locals: { message: @message }
  #         )
  #     end
  #     format.html { render partial: 'messages/message' } # Ensure compatibility with non-Turbo requests
  #   end
  # end


  def display_envoyes

    @send_messages = Message.where(sender_id: current_user.id)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'messages/envoyes'
        )
      end
    end

  end

  def display_passes
    @messages = Message.where(receiver_id: current_user.id)
    @past_messages = @messages.past

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'messages/passes'
        )
      end
    end

  end

  def display_avenir
    @messages = Message.where(receiver_id: current_user.id)
    @upcoming_messages = @messages.upcoming

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'messages/avenir'
        )
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:title, :content, :sender_id, :receiver_id, :sent_at, :document)
    end

    def authorize_sender
      unless user_is_sender?(@message)
        redirect_to messages_path, alert: 'You are not authorized to edit this message.'
      end
    end


end
