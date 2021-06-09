require "mysql2"
require "awesome_print"
#require "./lab3/ListEmployee"
class TestDB

  attr_reader :client

  def initialize()
    @client = Mysql2::Client.new(
      :host => "localhost",
      :username => "dolph",
      :password => "password"
    )
  end

  def initialize(name_of_DB)
      @client = Mysql2::Client.new(
        :host => "localhost",
        :username => "olph",
        :password => "password"
      )
      @client.query("USE #{name_of_DB}")
  end

  def createDB(name)
    @client.query("create database #{name}")
  end

  def create_employee()
    @client.query <<-SQL
    create table if not exists employees(
      id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
      fio varchar(1024),
      birth_date varchar(1024),
      phone_number varchar(1024),
      adress varchar(1024),
      mail varchar(1024),
      pasport_serial varchar(1024),
      speciality varchar(1024),
      expirience varchar(1024),
      last_place_of_job varchar(1024),
      last_job varchar(1024),
      last_zarplata varchar(1024))
      SQL
  end

  def del_emps()
    @client.query("drop table employees")
  end

  def show_db()
    @client.query("show databases").to_a(:as => :array).flatten
  end

  def show_tables()
    @client.query("show tables").to_a(:as => :array).flatten
  end

  def insert(values)
    @client.query("insert into employees values (NULL,\'#{values.join("','")}'\)")
  end

  def get_records()
    @client.query("select * from employees")
  end

  def del_record(attr, value)
    # q = "delete from employees where " + label.to_s + " = '" + value.to_s + "';"
    # puts q
    @client.query("delete from employees where #{attr.to_s} = '#{value.to_s}'")
    #@client.query(q.to_s)
  end

  def update_record(attr, label, value, new_value)
      @client.query("update employees set #{attr.to_s} = '#{new_value.to_s}' where #{label.to_s} = '#{value.to_s}'")
  end

  def convert_values()
    get_records.reduce([]) do |arr, el|
      arr << el.collect{|key, value| value.to_s if key != "id"}.compact
     end
  end
end


#obj = TestDB.new("stuff")

=begin
ap obj.show_db
values = [
  'Федорук Дмитрий Владимирович',
  '11.11.2000',
  '+79184958482',
  'г. Краснодар',
  'dimonych19@gmail.com',
  '148952',
  'Программист',
  '0',
  '-',
  '-',
  '-'
]
obj.del_emps
ap obj.show_tables
ap values.join(",")
obj.create_employee
obj.insert(values)
ap obj.get_records.each{|el| ap el}
=end

# puts obj.test_select
