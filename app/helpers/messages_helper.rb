module MessagesHelper

    def user_is_sender?(message)
        current_user == message.sender
    end

end
