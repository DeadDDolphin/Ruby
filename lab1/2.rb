#!/usr/bin/ruby
#2
puts "Hello, #{ARGV[0]}. What your favorite programming language?"
#3
name = STDIN.gets
#case
#  when name =~ /["ruby"]/
#    puts "Oh, I see that you know how to work with the tongue..."
#  else
#    puts "It's Okay. But soon you'll love Ruby"
#end
#    if name == "ruby" then
#       Вот эта запись не работает,
#       когда вводишь руби в любом виде.
#       Но запись с одним равно не работает для других языков..
if name =~ /["ruby"]/ #Я сделаль) Регулярки клёвая вещь, круче этих вот даункейсов
  puts "Oh, I see that you know how to work with the tongue..."
else 
  puts "It's Okay. But soon you'll love Ruby"
end