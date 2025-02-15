require 'table_print'

require_relative 'channel'
require_relative 'user'

module SlackBot
  class Workspace
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = nil
    end
    
    def select_channel(criteria)
      @channels.each do |channel|
        if channel.name == criteria.downcase
          @selected = channel
          return puts "Channel #{@selected.name} is selected"
        end
      end
      @channels.each do |channel|
        if channel.slack_id == criteria.upcase
          @selected = channel
          return puts "Channel #{@selected.name} is selected"
        end
      end
      raise ArgumentError, "Invalid Enty: No such channel."
    end
    
    def select_user(criteria)
      @users.each do |user|
        if user.name == criteria.downcase
          @selected = user
          return puts "User #{@selected.name} is selected"
        end
      end
      @users.each do |user|
        if user.slack_id == criteria.upcase
          @selected = user
          return puts "User #{@selected.name} is selected"
        end 
      end
      raise ArgumentError, "Invalid Enty: No such user."
    end
    
    def show_details
      @selected.details
    end
    
    def send_message(message:)
      response = @selected.send_message(message: message, slack_id: @selected.slack_id)
      if response["ok"] == true
        return puts "message sent"
      end
    end
  end
end
