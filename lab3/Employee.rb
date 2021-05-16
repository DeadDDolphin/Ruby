class Employee
  attr_accessor :fio, :birth_date, :phone_number, :adress, :mail, :pasport_serial, :speciality, :expirience, :last_place_of_job, :last_job, :last_zarplata

  def initialize(data)
    set_all(data)
  end

  def russian_phone(value)
    if value =~ /^[(\+7)(7)(8)](\d{1}|\W){10,}$/
      return true
    else
      return false
    end
  end

  def check_phone(value)
    if !russian_phone(value)
      raise "Uncorrect phone number"
    end
    new_val = value.chars.map{|symb| symb if symb =~ /[0-9]/}
    new_val = new_val.join
    return "7-" + new_val[1..3] + "-" + new_val[4..]
  end

  def phone_number=(value)
    @phone_number = check_phone(value)
  end

  def correct_mail(value)
    if value =~ /^[\w]+@[A-z0-9]+\.[A-z]{2,4}$/
      return true
    else
      return false
    end
  end

  def check_mail(value)
    if !correct_mail(value)
      raise "Uncorrect mail adress"
    else
      return value.downcase
    end
  end

  def mail=(value)
    @mail = check_mail(value)
  end

  def correct_fio(value)
    if value =~ /^((\s)*[А-я]+(\s*-\s*[А-я]*)?){2}(\s)*[А-я]+((\s)*[А-я]*)?$/
      return true
    else
      return false
    end
  end

  def check_fio(value)
    if !correct_fio(value)
      raise "Uncorrect fio"
    else
      new_val = value.split(" ")
      t1 = value[/([А-я]+(\s*-\s*[А-я]*)?)/]
      value = value.sub(/((\s)*[А-я]+(\s*-\s*[А-я]*)?)/,"")
      t2 = value[/([А-я]+(\s*-\s*[А-я]*)?)/]
      value = value.sub(/((\s)*[А-я]+(\s*-\s*[А-я]*)?)/,"")
      t3 = value[/[А-я]+((\s)*[А-я]*)?/]
      return [
        t1.scan(/[[:word:]]+/).map{|el| el.capitalize}.join("-"),
        t2.scan(/[[:word:]]+/).map{|el| el.capitalize}.join("-"),
        t3.scan(/[[:word:]]+/).join(" ").capitalize
     ].join(" ")
    end
  end

  def fio=(value)
    @fio = check_fio(value)
  end

  def correct_date(value)
    if value =~ /^[0123]?\.[01]\d\.([012]\d{3})|(\d{2})$/
      return true
    else
      return false
    end
  end

  def check_date(value)
    if !correct_date(value)
      raise "Uncorrect date"
    else
      new_val = value.split(".")
      new_val[0] = new_val[0].sub(/^\d$/, "0"+new_val[0])

      if new_val[2].to_i < 100 and new_val[2].to_i > 21
        new_val[2] = "00"+new_val[2]
        else if new_val[2].to_i < 1000
          new_val[2] = "0" + new_val[2]
          else if new_val[2].to_i <= 21
            new_val[2] = "20" + new_val[2]
          end
        end
      end

      return new_val.join(".")
    end
  end

  def birth_date=(value)
    @birth_date = check_date(value)
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
    return create_employees(get_data(choose))
  end
end

obj = TestEmployee.new
emps = obj.run("1")
emps.each do |el|
  puts el
  puts el.birth_date
end
