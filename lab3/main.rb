require_relative "TestEmployee"
require_relative "Employee"
obj = TestEmployee.new
emps = obj.run("1")
emps.each do |el|
  puts el
  puts el.birth_date
end
#obj.change_data
