require_relative "ValidatorDate"
require_relative "ValidatorMail"
require_relative "ValidatorFio"
require_relative "ValidatorPhone"
require_relative "StrategyValidator"

class FacadeValidator
  def self.check_phone(value)
    StrategyValidator.set_strategy(ValidatorPhone.new)
    StrategyValidator.check_value(value)
  end

  def self.check_mail(value)
    StrategyValidator.set_strategy(ValidatorMail.new)
    StrategyValidator.check_value(value)
  end

  def self.check_fio(value)
    StrategyValidator.set_strategy(ValidatorFio.new)
    StrategyValidator.check_value(value)
  end

  def self.check_date(value)
    StrategyValidator.set_strategy(ValidatorDate.new)
    StrategyValidator.check_value(value)
  end
end
