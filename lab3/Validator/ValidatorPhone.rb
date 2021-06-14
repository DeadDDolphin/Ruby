require_relative "Validator"

class ValidatorPhone < Validator
  def uncorrect_value?(value)
    if value =~ /^[(\+7)(7)(8)](\d{1}|\W){10,}$/
      return false
    else
      return true
    end
  end

  def normalize_value(value)
    new_val = value.chars.map{|symb| symb if symb =~ /[0-9]/}
    new_val = new_val.join
    return "7-" + new_val[1..3] + "-" + new_val[4..]
  end
end
