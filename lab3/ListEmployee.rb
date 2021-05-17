require "awesome_print"
require_relative "Employee"
class ListEmployee
  attr_accessor :emps

  def initialize(list = ["dfsdfds", "sdads"])
    self.emps = list
  end

  def emps=(list)
    @emps = list.each.with_index.reduce([]) do |new_arr, el, index|
      new_arr << Employee.new([index..index+11])
      index+=11
    end
  end

  def write_to_file(mode = "w", path = "./employees.txt")
    f = open(path, mode)
    @emps.each{|el| f.puts el}
    f.close
  end

  def self.red_from_file(path = "./employees.txt")
    open(path).reduce([]){|array, line| array << line.chomp}
  end
end

l = ListEmployee.new
l.write_to_file
ap ListEmployee.red_from_file("./data_list.txt")
