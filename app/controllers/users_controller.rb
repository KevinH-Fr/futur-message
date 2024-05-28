class UsersController < ApplicationController

    def index
      @users = User.all
    end
  

     # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name)
    end

end
  