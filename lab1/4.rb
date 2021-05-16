#!/usr/bin/ruby
#4
puts "Please, input OS command"
command = gets
system("#{command}")

puts "Please, input Ruby command"

rubyCommand = gets

puts eval(rubyCommand).inspect