require_relative "/Model/ListEmployee"
class ViewContr
  def self.exception_process(exception)
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
      ListEmployee.read_from_yaml
    else
      abort "Всего хорошего!"
    end
  end

  def self.else_process
    data1 = ListEmployee.read_from_DB
    data2 = ListEmployee.read_from_yaml
    if not data1 == data2
      puts "\tДанные с БД:"
      puts data1
      puts "\tДаннные с ямл-файла"
      puts data2
      puts "\tВыберите данные, с которыми желаете продолжить работу:"
      puts "\t1 - Данные с БД;\n\t2 - Данные с файла."
      choose = gets.chomp
      case choose
      when '1'
        ListEmployee.write_to_yaml(data1)
        data = data1
      when '2'
        ListEmployee.rewrite_DB(data2)
        data = data2
      else
        puts "Неверный ввод. Всего хорошего."
      end
      data
    end
  end
end
