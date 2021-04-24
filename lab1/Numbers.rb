#!/usr/bin/ruby
#11 variant
def summ(number)
  return number.digits.sum
end

def max_digit(number)
  return number.digits.max
end

def min_digit(number)
  return number.digits.min
end

def multiplication(number)
  s = 1
  for x in number.digits do
    s*=x
  end
  return s
end

#11 variant
def count_of_not_div_three(number)
  k=0
  for x in number.digits do
    if x%3 == 0
      k+=1
    end
  end
  return k
end

def min_nechet(number)
  t=number.digits
  t.each{|el| t.delete(el) if el%2 == 0}
  return t.min
end

#Сумма делителей числа, 
#взаимно простых с суммой цийр числа и
#не взаимно простых с произведением цифр числа
def nod_evklid(x,y)
  while(x != y)
    if x==0 or y==0
      return 1
    end
    if x > y
      x = x - y
    else
      y = y - x
    end
  end
  return x
end

def nazvanie(number)
  s=0
  sum = summ(number)
  mult = multiplication(number)
  for x in 1..number
    if number%x == 0
      if nod_evklid(x,sum) == 1 and nod_evklid(x,mult) != 1
        s += x
      end
    end
  end
  return s
end

x=ARGV[0].to_i

#puts summ(x)
#puts max_digit(x)
#puts min_digit(x)
#puts multiplication(x)
#puts count_of_not_div_three(x)
#puts min_nechet(x)
puts nazvanie(x)