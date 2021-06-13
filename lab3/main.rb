require_relative "controllers/ControllerList"



# Start the whole thing
if __FILE__ == $0
  c = ControllerList.new
  c.show_table
end
