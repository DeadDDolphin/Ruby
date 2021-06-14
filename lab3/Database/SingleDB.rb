require_relative "TestDB.rb"

class SingleDB
  attr_reader :connect
  @my_mutex = Mutex.new

  def initialize()
    @connect = TestDB.new("stuff")
  end

  # private_class_method :new

  def self.connection()
    return @connect if @connect
    @my_mutex.synchronize do
      @connect ||= new
    end
    @connect
  end
  def self.new
    @connect ||= super
  end
end
