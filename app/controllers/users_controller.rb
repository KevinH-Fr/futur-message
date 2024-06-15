class UsersController < ApplicationController

  before_action :authenticate_user!

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])

      @received_messages = Message.where(receiver_id: @user.id)
      @send_messages = Message.where(sender_id: @user.id)
  
    end
  

     # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name)
    end

end
  