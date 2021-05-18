require "require_all"
require_relative "work_with_files"
require_all "txtFiles/*.txt"
#require_relative *Dir['txtFiles']
class LexAnalyz
  attr_accessor :code

  include FileWork

  def initialize(value = "")
    self.code = value
  end

  def tokenize(str)
    hash = FileWork.read_sw
    hash.merge!(FileWork.read_op)
    hash.merge!(FileWork.read_sep)

    hash.each do |key, value|
      str[value] = key
    end
    str
  end

end

obj = LexAnalyz.new()
puts obj.tokenize("var i: integer;
    a: array[1..10] of integer;")
