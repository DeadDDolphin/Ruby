require_relative "SingleDB.rb"

class ConnectDB < SingleDB
  def initialize
    begin
      super
    rescue => exception
      exception
    end
  end
end
