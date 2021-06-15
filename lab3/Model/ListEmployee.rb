# frozen_string_literal: true
require_relative "Employee"
require_relative "./Database/ConnectDB.rb"
require "yaml"
require "psych"
require "nokogiri"
require "json"

# @author Dmitry Fedoruk
# model class that is a list of objects of the class Employee
class ListEmployee
  attr_accessor :emps, :connect, :users

  # initialize method set attributes emps, users to []
  # create connect to database by setter
  # fill emps from DB by rewrite_from_DB method
  def initialize
    @emps = []
    @users = []
    @connect = self.connect
    rewrite_from_DB
  end

  # overload to_s
  # @return [String] of concatenated
  # to_s method calls for objects of class employee
  def to_s
    @emps.reduce(""){|str, obj| str + obj.to_s+"\n"}
  end

  # setter to create connect to database
  # create object of ConnectDB class and call connect method
  def connect=
    @connect = ConnectDB.new.connect
  end

  # @!group UsersDB
  #   there are methods those use connect to DB
  # read data from database
  # @return [Array<Array<String>>] it is array of arrays of data by employees
  def read_from_DB
    @connect.convert_values.reduce([]){|new_arr, el| new_arr << el}
  end

  # rewrite model with data from DB
  # use method read_from_DB, for each returned array create and add Employee object
  def rewrite_from_DB
    @emps.clear
    read_from_DB.each{|el| add(el)}
  end

  # call insert method from DB to add new values in table
  # @param value [Array] is array of attributes values from Employee object
  def add_to_DB(value)
    @connect.insert(value)
  end

  #add all objects from emps to DB
  def add_list_to_DB
    @emps.each{|emp| add_to_DB(emp.get_all)}
  end

  #clear table in DB and write the current list of employee objects to it
  def rewrite_DB
    @connect.del_all
    add_list_to_DB
  end

  # del record from table in DB
  # @param attr[String] the name of the field in table
  # @param value[String] the value of the field by which the record will be deleted
  def del_from_DB(attr, value)
    @connect.del_record(attr,value)
  end

  # change record in table
  # @param attr[String] field to search for
  # @param label[String] field to change for
  # @param value[String] the value by which the record will be found
  # @param new_value[String] the new value
  def change_node(attr, label, value, new_value)
    @connect.update_record(attr, label, value, new_value)
  end
  # @!endgroup

  # @!group Serialize
  #   methods for serialize model

  # class method for writing in YAML-file with serial data
  # @param list_emps[Employee] the array of Employee objects
  def self.write_to_yaml(list_emps)
    File.open("data.yaml", "w") do |file|
      file.write(Psych.dump(list_emps))
    end
  end

  # method for writing in YAML-file current list of employees
  def inside_write_yaml
      self.class.write_to_yaml(@emps)
  end

  # class method for read serial data from YAML
  # @return [Array<Employee>]
  def self.read_from_yaml
    Psych.load_file('data.yaml')
  end

  # method rewrite current emps attribute from YAML
  def rewrite_from_yaml
    @emps.clear
    @emps = self.class.read_from_yaml
  end

  # @deprecated because the Nokigiri module has ot connctions
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

  # method for writing current array to JSON-file
  # used Employee object method as_json
  def write_to_json
    File.open("data.json", "w") do |file|
      @emps.each{|obj| file.puts(obj.as_json)}
    end
  end

  # method read and write to current model data from JSON
  def read_from_json
    @emps.clear
    #File.open("data.json").each{|line| add(eval(line.chomp).values)}
    File.open("data.json").each{|el| @emps << Employee.from_json(JSON.dump(eval(el.chomp)))}
    @emps
  end
  # @!endgroup

  # setter for emps. add every 11 elements like a list of strings
  # @param [Array<String>]
  def emps=(list)
    @emps = list.each.with_index.reduce([]) do |new_arr, el, index|
      new_arr << add([index..index+11])
      index+=11
    end.compact
  end

  # method for writing to txt file
  def write_to_file(mode = "w", path = "./employees.txt")
    f = open(path, mode)
    @emps.each{|el| f.puts el}
    f.close
  end

  # create and add new Employee object
  # @param [Array<String>] array of 11 values
  def add(list)
    @emps << Employee.new(list)
  end

  # method read's data from txt file
  # @param path [String] path to txt
  def read_from_file(path = "./employees.txt")
    data = open(path).reduce([]){|array, line| array << line.chomp}
    index = 0
    while index < data.length do
      add(data[index..index+11])
      index+=11
    end
  end

  # method fill emps by some array of arrays
  # @param list[Array<Array<String>>]
  def read_list(list)
    list.each{|el| add(el)}
  end

  # universal method for delete object from model by name and value of attribute
  # @param value[String] value of concrete attribute
  # @param attr[String] name of concrete attribute
  def del_by(value, attr)
    search_by(value, attr).each{|el| @emps.delete(el)}
  end

  # universal method for update object from model by name and value of attribute
  # @param value[String] value of concrete attribute
  # @param attr[String] name of concrete current attribute
  # @param new_value[String] new value of concrete attribute
  # @param label[String] name of concrete attribute which be updated
  def update_record(value,attr,new_value, label)
    cmd = "obj."+label +" = new_value"
    search_by(value, attr).each do |el|
      @emps.each{ |obj| obj <=> el ? eval(cmd): obj}
     end
  end


  # universal method for rewrite object from model by name and value of attribute
  # @param value[String] value of concrete attribute
  # @param attr[String] name of concrete attribute
  # @param new_emp[String] new object that will be written to the model instead of the given one
  def change_by(value,attr, new_emp)
    search_by(value, attr).each do |el|
      @emps.map!{ |obj| obj <=> el ? new_emp : obj}
     end
  end

  # universal method for search object from model by name and value of attribute
  # @param value[String] value of concrete attribute
  # @param attr[String] name of concrete attribute
  def search_by(value, attr)
    command = "el."+attr
    @emps.map{|el| el if eval(command) == value}.compact
  end

  # @!group SearchByAttr methods that look for a stable attribute
  # search by fio
  # @param fio[String] value of fio
  def search_by_fio(fio)
    @emps.map{|el| el if el.fio ==fio}.compact
  end

  # search by mail
  # @param mail[String] value of mail
  def search_by_mail(mail)
    @emps.map{|el| el if el.mail ==mail}.compact
  end

  # search by phone number
  # @param phone number[String] value of phone number
  def search_by_phone_number(phone_number)
    @emps.map{|el| el if el.phone_number ==phone_number}.compact
  end

  # search by passport series
  # @param passport series[String] value of passport series
  def search_by_pasport_serial(pasport_serial)
    @emps.map{|el| el if el.pasport_serial ==pasport_serial}.compact
  end
  # @!endgroup
  
  #universal method to sort by attribute
  # @param attr[String] name of attribute
  def sort_by(attr)
    @emps.sort_by{|obj| eval("obj."+attr)}
  end

  #return array of arrays with employee data
  # @return [Array<Array<String>>]
  def return_data
    @emps.reduce([]){|arr, obj| arr << obj.get_all}
  end

  #method to update the users. Observer pattern implementation
  def update
    @users.each{|u| u.update}
  end

end
