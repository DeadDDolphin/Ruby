require_relative "SingleDB"
require_relative "Salary.rb"

class Post
  attr_reader :post_name, :salary, :emp

  def initialize(post_name, hash, someEmp)
    @post_name = post_name
    @salary = new.Salary(hash)
    @emp = someEmp
  end

  #Много разных методов, по типа имплои. Валидация там, сеттеры можно установить, геттеры и т.д.
end
