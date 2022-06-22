require_relative "controller/MainController"



# Start the whole thing
if __FILE__ == $0
  c = MainController.new("model/data.json")
  c.show_table
end
