module FileWork

  def self.read_hash_from_file(path, id = "")
    f = open(path)
    h = {}
    f.each do |line|
       l = line.split
       h[:l[id+1.to_s]] = l[2]
     end
    h
  end

  def FileWork.read_sw
    read_hash_from_file("./textFiles.serviceWords.txt", "W")
  end

  def FileWork.read_op
    read_hash_from_file("./textFiles.operations.txt", "O")
  end

  def FileWork.read_sep
    read_hash_from_file("./textFiles.separators.txt", "S")
  end

end
