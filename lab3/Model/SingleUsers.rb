class SingleUsers
  attr_reader :users

  def initialize
    @users = []
  end

  def self.new
    @users ||= super
  end

  def add(user)
    @users << user if !@users.include?(user)
  end

  def update
    @users.each{|u| u.update}
  end
end
