module FileWork

  def self.read_hash_from_file(path, id = "")
    f = open(path)
    h = {}
    f.read.split("\n") do |line|
       l = line.split
       #puts l
       h[:"#{id + l[0]}"] = l[1]
     end
    #puts h
    h
  end

  def FileWork.read_sw
    read_hash_from_file("Translators/LexAnalyz/txtFiles/serviceWords.txt", "W")
  end

  def FileWork.read_op
    read_hash_from_file("Translators/LexAnalyz/txtFiles/operations.txt", "O")
  end

  def FileWork.read_sep
    read_hash_from_file("Translators/LexAnalyz/txtFiles/separators.txt", "S")
  end

end
