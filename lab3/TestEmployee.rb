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

  def new_employee
    return Employee.new
  end

  def run(choose)
    return create_employees(get_data(choose))
  end

  def change_data
    puts "Input the name of category what you want to change"
    value = input
    emp = new_employee

    case value
    when "fio"
      fio = input
      emp.fio = fio
    when "phone"
      phone = input
      emp.phone_number  = phone
    when "date"
      date = input
      emp.birth_date = date
    when "mail"
      mail = input
      emp.mail = mail
    end
    puts emp
  end

end
