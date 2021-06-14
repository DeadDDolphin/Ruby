require_relative "./ListEmployee"
require "test/unit"

#Атрибут коннект класса листЭмплои возвращает обьект Exception в случае неудавшегося подключения
class ListEmployeeTests < Test::Unit::TestCase

  def setup
    @obj = ListEmployee.new
  end

  def init_test
    assert_not_nil(@obj.emps, "List of employees is nil")
    assert_not_nil(@obj.users, "List of users is nil")
  end

  def connect_test
    assert_kind_of(TestDB,@obj.connect)
  end

  def is_employee_test(obj)
    assert_instance_of(Employee,obj, "Object is not Employee, it is #{obj.class} class")
  end

  def is_list_of_employee_test
    @obj.emps.each{|el| is_employee_test(el)}
  end

  def add_employee_test
    list = ['Андреев Владимир Соломонович',
        '01.05.1980',
        '7-918-4925611',
        'г. Москва, Кремль',
        'pudding@mail.ru',
        '14587',
        'политик',
        20,
        'Россия',
        'президент',
        '1000000000']
    @obj.add(list)
    assert_equal(@obj.emps[-1], Employee.new(list), "Added object is not employee with data from list")
  end

  def search_by_test
    hash = {fio: 'Андреев Владимир Соломонович',
        birth_date: '01.05.1980',
        phone_number: '7-918-4925611',
        address: 'г. Москва, Кремль',
        mail: 'pudding@mail.ru',
        pasport_serial: '14587',
        speciality: 'политик',
        expirience: 20,
        last_place: 'Россия',
        last_job: 'президент',
        zarplata: '1000000000'}
    @obj.add(hash.values)
    hash.each do |k,v|
      res = @obj.search_by(v,k)
      assert_equal(@obj.emps[-1], Employee.new(hash.values),
        "It is doesn't find Employe ewhere #{k} is #{v}")
    end
  end

  def return_data_test
    list = ['Андреев Владимир Соломонович',
        '01.05.1980',
        '7-918-4925611',
        'г. Москва, Кремль',
        'pudding@mail.ru',
        '14587',
        'политик',
        20,
        'Россия',
        'президент',
        '1000000000']
    @obj.add(list)
    assert_equal(list, @obj.return_data, "Return data is not working")
  end
end
