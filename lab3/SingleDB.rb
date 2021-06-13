require "awesome_print"
require_relative "/home/dolph/Документы/GitHub/Ruby/lab6/TestDB.rb"

class SingleDB
  attr_reader :connect
  #@connect = TestDB.new("stuff")
  @my_mutex = Mutex.new

  def initialize()
    @connect = TestDB.new("stuff")
  end

  # private_class_method :new
  #
  # def self.connection()
  #   return @connect if @connect
  #   @my_mutex.synchronize do
  #     @connect ||= new
  #   end
  #   @connect
  # end
  def self.new
    @connect ||= super
  end
end

class ConnectDB < SingleDB
  def initialize
    begin
      super
    rescue => exception
      exception
    end
  end
end
