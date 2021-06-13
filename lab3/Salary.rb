class FixedSalary
  attr_reader :salary

  def initialize(value)
    @salary = value
  end
end

class Decorator
  attr_reader :type_of_salary

  def initialize(type)
    @type_of_salary = type
  end

  def get_salary
    raise "Не выбран тип зарплаты"
  end
end


class SalaryIncrease < Decorator
  def get_salary(premium)
    @type_of_salary.salary + premium
  end
end

class PercentageOfSalary < Decorator
  def get_salary(quart_percent)
    @type_of_salary.salary * (1 + quart_percent / 100)
  end
end

class Salary
  attr_accesor :salary_data, :salary_value

  # hash ={
  #   :fixed => 1000,
  #   :premium => "1",#""
  #   :premium_size => 200,
  #   :quart => "2", #""
  #   :quart_size => 5,
  #   :bonus => "3", #""
  #   :bonus_percent => 10
  # }
  def initialize(hash)
    @salary_data = hash
  end

  def salary_value=
    choose = @salary_data[:premium, :quart, :bonus].join("")

    case choose
    when ""
      @salary_value = @salary_data[:fixed]
    when "1"
      @salary_value = SalaryIncrease.new(FixedSalary(@salary_data[:fixed])).get_salary(@salary_data[:premium_size])
    when "2"
      #Тут должен был бы быть метод,
      # считающий для квартильной премии точное значение, но времени в обрез, итак уже много его потратил
      @salary_value = @salary_data[:quart_size]
    when "3"
      @salary_value = PercentageOfSalary.new(FixedSalary(@salary_data:fixed)).get_salary(@salary_data[:bonus_percent])
    when "12"
    #  @salary_value =
    when "13"
      @salary_value = SalaryIncrease.new(
        PercentageOfSalary.new(FixedSalary(@salary_data:fixed)).get_salary(
          @salary_data[:bonus_percent])
        ).get_salary(@salary_data[:premium_size])
    when "23"
    when "123"
    end
  end
end
