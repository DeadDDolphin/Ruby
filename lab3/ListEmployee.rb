require "awesome_print"
require_relative "./Employee"
require "/home/dolph/Документы/GitHub/Ruby/lab6/TestDB.rb"
require "yaml"
require "psych"
require "nokogiri"
require "json"

class ListEmployee
  #include ActiveModel::Serializers::JSON
  attr_reader :emps

  def initialize
    @emps = []
    begin
      read_from_DB
    rescue => exception
      if exception == Mysql2::Error::ConnectionError
        puts "Не удалось подключиться к базе данных:"
        puts exception.message
      else
        puts "Возникла ошибка:"
        puts exception.message
      end

      puts "Желаете продолжить работу с данными из сериализованного файла?"
      puts "\t1 - продолжить работу;\n\tЛюбой другой символ - завершить."
      choose = gets.chomp
      case choose
      when '1'
        puts read_from_yaml
      else
        abort "Всего хорошего!"
      end
    end
  end

  def to_s
    @emps.reduce(""){|str, obj| str + obj.to_s+"\n"}
  end

  def connect_to_DB
    connect = TestDB.new("stuff")
  end

  def read_from_DB
    @emps.clear
    connect_to_DB.convert_values.each{|el| add(el)}
  end

  def add_to_DB(value)
    connect_to_DB.insert(value)
  end

  def add_list_to_DB(list_employee)
    list_employee.each{|emp| add_to_DB(emp.get_all)}
  end

  def del_from_DB(attr, value)
    connect_to_DB.del_record(attr,value)
  end

  def change_node(attr, label, value, new_value)
    connect_to_DB.update_record(attr, label, value, new_value)
  end

  def write_to_yaml
    File.open("data.yaml", "w") do |file|
      file.write(Psych.dump(@emps))
    end
  end

  def read_from_yaml
    @emps.clear
    Psych.load_file('data.yaml')
  end

  def write_to_xml
    doc = Nokogiri::Builder::XmlMarkup.new do |xml|
      xml.root do
        @emps.each do |obj|
          xml.employee "index"=>"#{@emps.index(obj)}" do
            xml.fio obj.fio
            xml.birth_date obj.birth_date
            xml.phone_number obj.phone_number
            xml.adress obj.adress
            xml.mail obj.mail
            xml.pasport_serial obj.pasport_serial
            xml.speciality obj.speciality
            xml.expirience obj.expirience
            xml.last_place_of_job obj.last_place_of_job
            xml.last_job obj.last_job
            xml.last_zarplata obj.last_zarplata
          end
        end
      end
    end
    puts doc.to_xml
  end


  def write_to_json
    File.open("data.json", "w") do |file|
      @emps.each{|obj| file.puts(obj.as_json)}
    end
  end

  def read_from_json
    @emps.clear
    #File.open("data.json").each{|line| add(eval(line.chomp).values)}
    File.open("data.json").each{|el| @emps << Employee.from_json(JSON.dump(eval(el.chomp)))}
    @emps
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

  def add(list)
    @emps << Employee.new(list)
  end

  def read_from_file(path = "./employees.txt")
    data = open(path).reduce([]){|array, line| array << line.chomp}
    index = 0
    while index < data.length do
      add(data[index..index+11])
      index+=11
    end
    #ap @emps
  end

  def read_list(list)
    list.each{|el| add(el)}
  end
  # def to_proc
  #   proc{|obj, value| obj if obj.send(self) == value}
  # end

  def del_by(value, attr)
    search_by(value, attr).each{|el| @emps.delete(el)}
  end


  def change_by(value,attr, new_emp)
    search_by(value, attr).each do |el|
      @emps.map!{ |obj| obj <=> el ? new_emp : obj}
     end
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

  def sort_by(attr)
    @emps.sort_by{|obj| eval("obj."+attr)}
  end
end
#
l = ListEmployee.new
#l.read_from_file("lab3/data_list.txt")
#puts l
#l.add_list_to_DB(l.emps)
#l.del_from_DB("fio","Федорук Дмитрий Владимирович")
g = ListEmployee.new
#g.change_node("phone_number","fio", "Федорук Дмитрий Владимирович", "+79264967541")
#g.add_list_to_DB(l.emps)
#g.read_from_DB
#g.write_to_yaml
#puts g.read_from_json
#puts g
# l.write_to_file
# #puts l
# # puts "Fio"
# # puts l.search_by_fio("Федорук Дмитрий Владимирович")
# # puts "mail"
# # puts l.search_by_mail("pudding@mail.ru")
# # puts "phone"
# # puts l.search_by_phone_number("7-918-4958482")
# # puts "serial"
# # puts l.search_by("14587", "pasport_serial")
#
# ap l.sort_by("expirience")
