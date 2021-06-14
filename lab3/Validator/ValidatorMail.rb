require_relative "Validator"

class ValidatorMail < Validator
  def uncorrect_value?(value)
    if value =~ /^[\w]+@[A-z0-9]+\.[A-z]{2,4}$/
      return false
    else
      return true
    end
  end

  def normalize_value(value)
    value.downcase
  end
end
