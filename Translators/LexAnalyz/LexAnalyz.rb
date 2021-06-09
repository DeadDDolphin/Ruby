require "require_all"
require_relative "FileWork"
require_all "Translators/LexAnalyz/txtFiles"
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
    ap @serv_words
    @code.gsub(/[a-я]{1}[a-я\d]{1,}/) do |el|
      if !@serv_words.values.include?(el) #and !.values.include?(el)
        idents[:"I#{i}"] = el
        i+=1
      end
    end
    puts "IDENTS"
    ap idents
  end
  # def sym_consts=(value)
  #   @sym_consts = value
  # end

  # def tokenize()
  #   strings = @code.split("\n")
  #   strings.reduce([]){|arr, str| arr << scaner(str)}
  # end

  def scaner(str = @code)
    tokens = str.scan(/\w+|./).select {|x| x.match(/\S/)}
    tmp = tokens.clone
    tokens.map! do |x|
      if @num_consts.has_value?(x)
        tmp[tokens.index(x)] = nil
        x = @num_consts.key(x).to_s
      else x=x
      end
    end
    tokens = tokens.each_index do |i|
      if @sym_consts.has_value?(tokens[i-1..i+1].join(""))
        tmp[i-1..i+1] = nil
        tokens[i-1..i+1] = @sym_consts.key(tokens[i-1..i+1].join("")).to_s
      end
      if @sym_consts.has_value?(tokens[i-1..i+1].join(" "))
        tmp[i-1..i+1] = nil
        tokens[i-1..i+1] = @sym_consts.key(tokens[i-1..i+1].join(" ")).to_s
      end
    end
    tokens.map! do |x|
      if @serv_words.has_value?(x)
        tmp[tokens.index(x)] = nil
        x = @serv_words.key(x).to_s
       else x=x
       end
     end
    tokens.map! do |x|
      if @operators.has_value?(x)
        tmp[tokens.index(x)] = nil
        x = @operators.key(x).to_s
       else x=x
       end
     end
     tokens.map! do |x|
       if @separators.has_value?(x)
         tmp[tokens.index(x)] = nil
         x = @separators.key(x).to_s
       else x=x
       end
     end
    i=0
    tmp.each do |x|
      if x != nil
        if @identifycators.has_value?(x)
          x = @identifycators.key(x).to_s
        else
          self.identifycators[:"I#{i}"] = x
          i+=1
          x = @identifycators.key(x).to_s
        end
      end
    end
    tokens.map! do |x|
      if @identifycators.has_value?(x)
        x = @identifycators.key(x).to_s
      else x=x
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

obj = LexAnalyz.new("program  n_4;
  var i, imax: integer;
      a: array[1..10] of integer;
begin
  randomize;
  for i:=1 to 10 do a[i]:=random(100);
  imax:=1;
  for i:=2 to 10 do
    if a[i]>a[imax] then
       imax:=i;
  write('max',a[imax])
end.")
ap obj
ap obj.scaner
