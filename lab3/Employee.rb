class Employee
  attr_accessor :fio, :birth_date, :phone_number, :adress, :mail, :pasport_serial, :speciality, :expirience, :last_place_of_job, :last_job, :last_zarplata
  
  def initialize(data)
    @fio = data[0]
    @birth_date = data[1]
    @phone_number = data[2]
    @adress = data[3]
    @mail = data[4]
    @pasport_serial = data[5]
    @speciality = data[6]
    @expirience = data[7].to_i
    if @expirience > 0  
      @last_place_of_job = data[8]
      @last_job = data[9]
      @last_zarplata = data[10]
    end
  end
  
  def set_all(data)
    @fio = data[0]
    @birth_date = data[1]
    @phone_number = data[2]
    @adress = data[3]
    @mail = data[4]
    @pasport_serial = data[5]
    @speciality = data[6]
    @expirience = data[7].to_i
    if @expirience > 0  
      @last_place_of_job = data[8]
      @last_job = data[9]
      @last_zarplata = data[10]
    end
  end
  
  def get_all()
    return @fio, @birth_date, @phone_number, @adress, @mail, @pasport_serial,
  @speciality, @expirience, @last_place_of_job, @last_job, @last_zarplata
  end
  
  def employee()
    return @fio  
  end
  
  def change_job(place, job, money)
    if @expirience > 0
      @last_place_of_job = place
      @last_job = job
      @last_zarplata = money
    else
      puts "Че-то не то. Работаешь, не получая стажа работы?"
    end
  end
end
def read_from_file(path)
  f = open path
  arr=Array.new()
  f.each do |line|
    arr<<line
  end
  f.close
  return arr
end

def input()
  return STDIN.gets.chomp()
end

choose = ARGV[0]

case choose
when "1"
  path = ARGV[1]
  data = read_from_file(path)
when "2"
  puts "Введите данные работника: "
  data = input
end

emp = Employee.new(data)
puts emp.employee
