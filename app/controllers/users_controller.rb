class UsersController < ApplicationController

  before_action :authenticate_user!

    def index
      @users = User.all
    end
  

     # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name)
    end

end
  