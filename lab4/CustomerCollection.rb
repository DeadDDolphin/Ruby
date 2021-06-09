require_relative "./Customer"
class CustomerCollection
  attr_reader :customers

  def initialize
    @customers = []
  end

  def to_s
    @customers.reduce(""){|str, obj| str + obj.to_s + "\n"}
  end

  def customers=(data)
    @customers = data.each_with_index.reduce([]) do |new_arr, el, index|
      new_arr << Customer.new([index..index+11])
      index+=11
    end.compact
  end

  def array_to_hash(data)
    index = 0
    arr = []
    while index < data.length do
      arr << {
        :fio => data[index],
        :old => data[index+1],
        :national => data[index+2],
        :phone_number => data[index+3],
        :mail => data[index+4],
        :pasport_serial => data[index+5],
        :driver_license => data[index+6]
      }
      index+=7
    end
    arr
  end

  def add_customer(hash)
    @customers << Customer.new(hash)
  end

  def read_from_file(path)
    data = open(path).reduce([]){|array, line| array << line.chomp}
    order_data = array_to_hash(data)
    order_data.each{|hash| add_customer(hash)}
  end

  def write_to_file(path, mode = "w")
    f = open(path, mode)
    @customers.each{|el| f.puts el}
    f.close
  end

#Очень интересная штука с этими символами выходит, но непонятная
  def search_by(value, attr)
    ap @customers.select do |obj|
      ap if ap obj.send(:"#{attr}") == value
    end
  end
  # def search_by(value, attr)
  #   @customers.map{|obj| obj if eval("obj."+attr) == value}
  # end

  def sort_by(attr)
    @customers.sort_by{|obj| eval("obj."+attr)}
  end
end
