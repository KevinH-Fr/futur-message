class PagesController < ApplicationController

    def home
        @users = User.all
        @messages = Message.all
    end
    
    def about
    end

    def testscroll
    end

end
