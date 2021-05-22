require "awesome_print"
class Customer
  attr_accessor :fio, :old, :national, :phone_number, :mail, :pasport_serial, :driver_license

  def initialize(data_hash)
    set_all(data_hash)
  end

  def set_all(data_hash)
    data_hash.each_key{|key| eval("self.#{key} = data_hash[key]")}
  end

  def to_s
    return @fio + " - " + @old.to_s + " - " + @phone_number
  end

  def self.uncorrect_value?(value, reg)
    if value =~ reg
      return false
    else
      return true
    end
  end

  def self.check_phone(value)
    if uncorrect_value?(value,/^[(\+\d)(\d)](\d{1}|\W){10,}$/)
      raise "Uncorrect phone number"
    end
    new_val = value.chars.map{|symb| symb if symb =~ /[0-9]/}
    new_val = new_val.join
    return "7-" + new_val[1..3] + "-" + new_val[4..]
  end

  def phone_number=(value)
    @phone_number = self.class.check_phone(value)
  end

  def self.check_mail(value)
    if uncorrect_value?(value, /^[\w]+@[A-z0-9]+\.[A-z]{2,4}$/)
      raise "Uncorrect mail adress"
    else
      return value.downcase
    end
  end

  def mail=(value)
    @mail = self.class.check_mail(value)
  end

  def self.to_new_order(str_list)
    str_list.map do |str|
       if !str.include?("-")
         str.capitalize
       else
         str.split("-").map(&:capitalize).join("-")
       end
     end.join(" ")
  end

  def self.del_space(str)
    str.delete(' ')
  end

  def self.check_fio(value)
    if uncorrect_value?(value, /^((\s)*[А-я]+(\s*-\s*[А-я]*)?){2}(\s)*[А-я]+((\s)*[А-я]*)?$/)
      raise "Uncorrect fio"
    end
    new_val = value.split(" ")
    t1 = value[/([А-я]+(\s*-\s*[А-я]*)?)/]
    value = value.sub(/((\s)*[А-я]+(\s*-\s*[А-я]*)?)/,"")
    t2 = value[/([А-я]+(\s*-\s*[А-я]*)?)/]
    value = value.sub(/((\s)*[А-я]+(\s*-\s*[А-я]*)?)/,"")
    t3 = value[/[А-я]+((\s)*[А-я]*)?/]
    #ap  r1 = scans(t1)
    #r2 = t2
    #ap res = scans(t1) +   scans(t2) + scans(t3)
    res = [del_space(t1), del_space(t2), t3]
    to_new_order(res)
  end
  #Хотелось сделать по красоте, но не
  # def self.check_fio(value)
  #   surname_name = /([А-я]+(\s*-\s*[А-я]*)?)/
  #   fathername = /(\s)*[А-я]+((\s)*[А-я]*)?/
  #   if uncorrect_value?(value, /^((\s)*[А-я]+(\s*-\s*[А-я]*)?){2}(\s)*[А-я]+((\s)*[А-я]*)?$/)
  #     raise "Uncorrect fio"
  #   else
  #     value.downcase!
  #     ap words= value.scan(/[А-я]+/)
  #
  #     ap double_names = value.scan(/[А-я]+\s*-\s*[А-я]*/)
  #
  #     ap value
  #     ap double_names.map!{|el| el.include?(' ') ?el.delete!(' '):el}
  #     ap double_names
  #     res =[]
  #     if double_names.length == 1
  #       if double_names[0].include?(words[0])
  #         puts "Двойная фамилия"
  #         res << double_names[0]
  #         res << words[2]
  #       else if double_names[0].include?(words[1])
  #         puts "Двойное имя"
  #         res << words[0]
  #         res << double_names[0]
  #         ap res
  #         end
  #       end
  #     else
  #       res << double_names[0,1]
  #     end
  #     ap "asdsad:"
  #     ap res << words.map{|word| word if !res.reduce([]){|arr, el| arr + el.split("-")}.include?(word)}.compact.join(" ")
  #     to_new_order(res)
  #   end
  # end

  def fio=(value)
    @fio = self.class.check_fio(value)
  end

end
