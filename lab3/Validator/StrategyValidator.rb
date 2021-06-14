require_relative "Validator"

class StrategyValidator
  def self.set_strategy(strategy)
    @@strategy = strategy || Validator.new
  end

  def self.check_value(value)
    @@strategy.check_value(value)
  end
end
