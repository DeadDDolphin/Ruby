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

  def self.check_fio(value)
    surname_name = /([А-я]+(\s*-\s*[А-я]*)?)/
    fathername = /(\s)*[А-я]+((\s)*[А-я]*)?/
    if uncorrect_value?(value, /^((\s)*#{surname_name}){2}#{fathername}$/)
      raise "Uncorrect fio"
    else
      #new_val = value.split(" ")
      t1 = /^#{surname_name}/.match(value)
      ap t1
      #value = value.sub(/((\s)*[А-я]+(\s*-\s*[А-я]*)?)/,"")
      t2 = surname_name.match(value).to_a[1]
      ap t2
      #value = value.sub(/((\s)*[А-я]+(\s*-\s*[А-я]*)?)/,"")
      t3 = fathername.match(value).to_s
      ap t3
      return [
        t1.scan(/[[:word:]]+/).map{|el| el.capitalize}.join("-"),
        t2.scan(/[[:word:]]+/).map{|el| el.capitalize}.join("-"),
        t3.scan(/[[:word:]]+/).join(" ").capitalize
     ].join(" ")
    end
  end

  def fio=(value)
    @fio = self.class.check_fio(value)
  end

end

data = {
  fio: "Федорук Дмитрий Владимирович",
  old: 20,
  national: "Русский",
  phone_number: "+7918958482",
  mail: "dimonych19@gmail.com",
  pasport_serial: "213242",
  driver_license: "213123"
}
obj = Customer.new(data)
puts obj
