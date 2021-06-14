require 'test/unit'
require_relative "./Employee"

class EmployeeTests < Test::Unit::TestCase

  def setup
    @emp = Employee.new(list = ['Андреев Владимир Соломонович',
        '01.05.1980',
        '7-918-4925611',
        'г. Москва, Кремль',
        'pudding@mail.ru',
        '14587',
        'политик',
        20,
        'Россия',
        'президент',
        '1000000000'])
  end

  def get_all_test
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
    assert_equal(@emp.get_all, list, "The fields of object aren't equal elements of list")
  end

  def to_s_test
    str ="Андреев Владимир Соломонович; place: Россия; phone: 7-918-4925611; birth_date: 01.05.1980; mail: pudding@mail.ru"
    assert_equal(@emp.to_s, str, "Employee method \"to_s\" is wrong")
  end

  def kosmolet_test
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
    obj = Employee.new(list)
    assert(@emp.<=>obj, "Kosmolet chet ne letaet")
  end
end
