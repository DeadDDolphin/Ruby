require_relative "Validator"

class ValidatorDate < Validator

  def uncorrect_value?(value)
    if value =~ /^[0123]?\.[01]\d\.([012]\d{3})|(\d{2})$/
      return false
    else
      return true
    end
  end

  def normalize_value(value)
    new_val = value.split(".")
    new_val[0] = new_val[0].sub(/^\d$/, "0"+new_val[0])
    new_val[1] = new_val[1].sub(/^\d$/, "0"+new_val[1])

    if new_val[2].to_i < 100 and new_val[2].to_i > 21
      new_val[2] = "00"+new_val[2]
    else if new_val[2].to_i < 22
        new_val[2] = "20" + new_val[2]
    else if new_val[2].to_i < 1000
        new_val[2] = "0" + new_val[2]
        end
      end
    end

    return new_val.join(".")
  end
end
