require_relative "CustomerCollection"

obj = CustomerCollection.new

obj.read_from_file("/home/dolph/Документы/GitHub/Ruby/lab4/data.txt")
puts obj

obj.write_to_file("/home/dolph/Документы/GitHub/Ruby/lab4/ouput_data.txt")

puts obj.search_by("20", "old")
