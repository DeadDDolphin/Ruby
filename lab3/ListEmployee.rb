require "awesome_print"
require_relative "./Employee"
require "/home/dolph/Документы/GitHub/Ruby/lab6/TestDB.rb"
require "yaml"
require "psych"
require "nokogiri"
require "json"
require_relative "SingleDB"

#Атрибут коннект класса листЭмплои возвращает обьект Exception в случае неудавшегося подключения
class ListEmployee
  attr_accessor :emps, :connect, :users

  def initialize
    @emps = []
    @users = []
    @connect = ConnectDB.new.connect
    rewrite_from_DB
  end

  def to_s
    @emps.reduce(""){|str, obj| str + obj.to_s+"\n"}
  end

  def connect=
    @connect = ConnectDB.new.connect
  end

  def read_from_DB
    @connect.convert_values.reduce([]){|new_arr, el| new_arr << el}
  end

  def rewrite_from_DB
    @emps.clear
    read_from_DB.each{|el| add(el)}
  end

  def add_to_DB(value)
    @connect.insert(value)
  end

  def add_list_to_DB
    @emps.each{|emp| add_to_DB(emp.get_all)}
  end

  def rewrite_DB
    @connect.del_all
    add_list_to_DB
  end

  def del_from_DB(attr, value)
    @connect.del_record(attr,value)
  end

  def change_node(attr, label, value, new_value)
    @connect.update_record(attr, label, value, new_value)
  end

  def self.write_to_yaml(list_emps)
    File.open("data.yaml", "w") do |file|
      file.write(Psych.dump(list_emps))
    end
  end

  def inside_write_yaml
      self.class.write_to_yaml(@emps)
  end

  def self.read_from_yaml
    Psych.load_file('data.yaml')
  end

  def rewrite_from_yaml
    @emps.clear
    @emps = self.class.read_from_yaml
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
  end

  def read_list(list)
    list.each{|el| add(el)}
  end

  def del_by(value, attr)
    search_by(value, attr).each{|el| @emps.delete(el)}
  end

  def update_record(value,attr,new_value, label)
    cmd = "obj."+label +" = new_value"
    search_by(value, attr).each do |el|
      @emps.each{ |obj| obj <=> el ? eval(cmd): obj}
     end
  end

  def change_by(value,attr, new_emp)
    search_by(value, attr).each do |el|
      @emps.map!{ |obj| obj <=> el ? new_emp : obj}
     end
  end

  def search_by(value, attr)
    command = "el."+attr
    @emps.map{|el| el if eval(command) == value}.compact
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

  def return_data
    @emps.reduce([]){|arr, obj| arr << obj.get_all}
  end

  def update
    @users.each{|u| u.update}
  end

end
