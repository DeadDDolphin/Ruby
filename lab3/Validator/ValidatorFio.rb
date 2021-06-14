require_relative "Validator"

class ValidatorFio < Validator

  def uncorrect_value?(value)
    if value =~ /^((\s)*[А-я]+(\s*-\s*[А-я]*)?){2}(\s)*[А-я]+((\s)*[А-я]*)?$/
      return false
    else
      return true
    end
  end

  def normalize_value(value)
    new_val = value.split(" ")
    t1 = value[/([А-я]+(\s*-\s*[А-я]*)?)/]
    value = value.sub(/((\s)*[А-я]+(\s*-\s*[А-я]*)?)/,"")
    t2 = value[/([А-я]+(\s*-\s*[А-я]*)?)/]
    value = value.sub(/((\s)*[А-я]+(\s*-\s*[А-я]*)?)/,"")
    t3 = value[/[А-я]+((\s)*[А-я]*)?/]
    return [
      t1.scan(/[[:word:]]+/).map{|el| el.capitalize}.join("-"),
      t2.scan(/[[:word:]]+/).map{|el| el.capitalize}.join("-"),
      t3.scan(/[[:word:]]+/).join(" ").capitalize
   ].join(" ")
  end
end
