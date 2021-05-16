class Employee
  attr_accessor :fio, :birth_date, :phone_number, :adress, :mail, :pasport_serial, :speciality, :expirience, :last_place_of_job, :last_job, :last_zarplata

  def initialize(data)
    set_all(data)
  end

  def last_place_of_job=(place)
    if @expirience > 0
      @last_place_of_job = place
    else
      @last_place_of_job = "No"
    end
  end

  def last_job=(job)
    if @expirience > 0
      @last_job = job
    else
      @last_job = "No"
    end
  end

  def last_zarplata=(zarplata)
    if @expirience > 0
      @last_zarplata = zarplata
    else
      @last_zarplata = "No"
    end
  end

  def set_all(data)
    self.fio = data[0]
    self.birth_date = data[1]
    self.phone_number = data[2]
    self.adress = data[3]
    self.mail = data[4]
    self.pasport_serial = data[5]
    self.speciality = data[6]
    self.expirience = data[7].to_i
    self.last_place_of_job = data[8]
    self.last_job = data[9]
    self.last_zarplata = data[10]
  end

  def get_all
    return @fio, @birth_date, @phone_number, @adress, @mail, @pasport_serial,
      @speciality, @expirience, @last_place_of_job, @last_job, @last_zarplata
  end

  def to_s
    return @fio + "; place: " + @last_place_of_job
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

class TestEmployee
  def read_from_file(path)
    f = open path
    arr = Array.new
    f.each{|line| arr << line.chomp()}
    f.close
    return arr
  end

  def input
    return STDIN.gets.chomp()
  end

  def get_data(choose)
    case choose
    when "1"
      path = "data_list.txt"
      data = read_from_file(path)
    when "2"
      puts "Введите данные работника: "
      data = input
    end
    return data
  end

  def create_employees(data)
    emps = Array.new
    for i in 0..data.length/11 - 1
      emps<< Employee.new(data[i*11..i*11+10])
    end
    return emps
  end

  def new_employee(data)
    return Employee.new(data)
  end

  def run(choose)
    data = get_data(choose)
    emps = create_employees(data)
    emps.each{|el| puts el}
  end
end

obj = TestEmployee.new
obj.run("1")
