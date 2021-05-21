require "require_all"
require_relative "FileWork"
require_all "LexAnalyz/txtFiles"
require "awesome_print"
class LexAnalyz
  attr_accessor :code, :serv_words, :operators, :separators,
    :num_consts, :sym_consts, :identifycators

  include FileWork

  def initialize(value = "")
    self.code = value
    self.serv_words = FileWork.read_sw
    self.operators = FileWork.read_op
    self.separators = FileWork.read_sep
    self.num_consts = get_num_consts
    self.sym_consts = get_sym_consts
    self.identifycators = {}
  end

  def code=(value)
    @code = value.downcase
  end

  def to_s
    return @serv_words, @operators, @separators,
      @num_consts, @sym_constss, @identifycators
  end
  #
  # def serv_words=(value)
  #   @serv_words = value
  # end
  #
  # def operators=(value)
  #   @operators = value
  # end
  #
  # def separators=(value)
  #   @separators = value
  # end

  def get_num_consts()
    consts = {}
    i=1
    @code.gsub(/\d+/) do |el|
      consts[:"N#{i}"] = el
      i+=1
    end
    consts
  end

  # def num_consts=(value)
  #   @num_consts = value
  # end

  def get_sym_consts()
    consts = {}
    i=0
    @code.gsub(/(\'.*\')|(\".*\")/) do |el|
      consts[:"C#{i}"] = el
      i+=i
    end
    consts
  end

  def get_identifycators()
    idents = {}
    i=0
    ap @code
    @code.gsub(/[a-я]{1,}|[a-я\d]{1,}/) do |el|
      idents[:"I#{i}"] = el
      i+=i
    end
    ap idents
  end
  # def sym_consts=(value)
  #   @sym_consts = value
  # end

  def tokenize(str = @code)
    tokens = str.scan(/\w+|./).select {|x| x.match(/\S/)}
    ap tokens
    tokens.map!{|x| @num_consts.has_value?(x) ? x = @num_consts.key(x).to_s : x=x }
    ap tokens
    ap @sym_consts
    tokens = tokens.each_index do |i|
      if @sym_consts.has_value?(tokens[i-1..i+1].join(""))
        tokens[i-1..i+1] = @sym_consts.key(tokens[i-1..i+1].join("")).to_s
      end
    end
    ap tokens
    tokens.map!{|x| @serv_words.has_value?(x) ? x = @serv_words.key(x).to_s : x=x }
    ap tokens
    tokens.map!{|x| @operators.has_value?(x) ? x = @operators.key(x).to_s : x=x  }
    ap tokens
    tokens.map!{|x| @separators.has_value?(x) ? x = @separators.key(x).to_s : x=x }
    ap tokens
    i=0
    tokens = tokens.each do |x|
      if x =~ /\w+/
        self.identifycators[:"I#{i}"] = x
        i+=1
        x = @identifycators.key(x).to_s
      end
    end

    # @num_consts.each{|key, value| tokens.include?(value) ?  tokens[value]= key.to_s : 1+2}
    # @sym_consts.each{|key, value| tokens.include?(value) ? tokens[tokens.index(value)] = key.to_s : 1+2}
    # @serv_words.each{|key, value| tokens.include?(value) ? tokens[tokens.index(value)] = key.to_s : 1+2}
    # @operators.each{|key, value| tokens.include?(value) ? tokens[tokens.index(value)] = key.to_s : 1+2}
    # @separators.each{|key, value| tokens.include?(value) ? tokens[tokens.index(value)] = key.to_s : 1+2}
    tokens
  end

end

obj = LexAnalyz.new("var i: integer;
    a: array[1..10] of 'integer' ;")
ap obj
ap obj.tokenize
