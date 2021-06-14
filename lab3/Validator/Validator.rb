class Validator
  def uncorrect_value?(value)
  end

  def normalize_value(value)
  end

  def check_value(value)
    if uncorrect_value?(value)
      raise "Uncorrect value: #{value}"
    else
      normalize_value(value)
    end
  end

end
