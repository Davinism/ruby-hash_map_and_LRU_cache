class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash

    hash_sum = 0

    self.each.with_index do |el, idx|
      hash_sum += el.hash * idx.hash
    end

    hash_sum
  end

end

class String
  def hash
    self.chars.map(&:ord).hash

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
