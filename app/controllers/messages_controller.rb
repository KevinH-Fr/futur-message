class MessagesController < ApplicationController

  include MessagesHelper
  
  before_action :authenticate_user!

  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :authorize_sender, only: [:edit, :update, :destroy]


  # GET /messages or /messages.json
  def index
    @messages = Message.where(receiver_id: current_user.id)
    @past_messages = @messages.past
    @upcoming_messages = @messages.upcoming
  end

  # GET /messages/1 or /messages/1.json
  def show
    respond_to do |format|
      format.html
     # format.turbo_stream
    end
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
