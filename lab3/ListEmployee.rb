require "awesome_print"
require_relative "./Employee"
class ListEmployee
  attr_reader :emps

  def initialize
    @emps = []
  end

  def to_s
    @emps.reduce(""){|str, obj| str + obj.to_s+"\n"}
  end

  # def is_unique?(emp)
  #   if @emps.each{|el| el.unique?(emp)}
  #     true
  #   end
  #   false
  # end

  def emps=(list)
    @emps = list.each.with_index.reduce([]) do |new_arr, el, index|
      new_arr << Employee.new([index..index+11])
      index+=11
    end.compact
  end

  def write_to_file(mode = "w", path = "./employees.txt")
    f = open(path, mode)
    @emps.each{|el| f.puts el}
    f.close
  end

  def add(emp)
    @emps << emp
  end

  def read_from_file(path = "./employees.txt")
    data = open(path).reduce([]){|array, line| array << line.chomp}
    index = 0
    while index < data.length do
      obj = Employee.new(data[index..index+11])
      add(obj)
      index+=11
    end
    #ap @emps
  end

  def to_proc
    proc{|obj, value| obj if obj.send(self) == value}
  end

  def search_by(value, attr)
    command = "el."+attr
    @emps.map{|el| el if eval(command) == value}
  end

  def search_by_fio(fio)
    @emps.map{|el| el if el.fio ==fio}.compact
  end

  def search_by_mail(mail)
    @emps.map{|el| el if el.mail ==mail}.compact
  end

  def search_by_phone_number(phone_number)
    @emps.map{|el| el if el.phone_number ==phone_number}.compact
  end

  def search_by_pasport_serial(pasport_serial)
    @emps.map{|el| el if el.pasport_serial ==pasport_serial}.compact
  end

end

l = ListEmployee.new
l.write_to_file
l.read_from_file("./data_list.txt")
#puts l
puts "Fio"
puts l.search_by_fio("Федорук Дмитрий Владимирович")
puts "mail"
puts l.search_by_mail("pudding@mail.ru")
puts "phone"
puts l.search_by_phone_number("7-918-4958482")
puts "serial"
puts l.search_by("14587", "pasport_serial")
