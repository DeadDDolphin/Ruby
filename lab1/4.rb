#!/usr/bin/ruby
#4
puts "Please, input OS command"
command = STDIN.gets
system("#{command}")

puts "Please, input Ruby command"

rubyCommand = STDIN.gets

puts eval(rubyCommand).inspect