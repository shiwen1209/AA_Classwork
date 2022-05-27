class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    total_hash = 0
    self.each_with_index do |el, ind|
      total_hash += (el * ind) * 10
    end

    total_hash

  end
end

class String
  def hash
    total_hash = 0
    self.each_char.with_index do |c, ind|
      total_hash += (c.ord * ind) * 9
    end

    total_hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    total_hash = 0

    self.each do |k, v|
      total_hash += k.to_s.ord + v.to_s.ord * 10
    end
    total_hash
  end
end
