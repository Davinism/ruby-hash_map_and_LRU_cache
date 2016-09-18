require 'byebug'

class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= capacity
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
  end

  def push(val)

    resize! if @count == capacity

    @store[@count] = val
    @count += 1

  end

  def unshift(val)

    # byebug

    resize! if @count == capacity

    temp = StaticArray.new(capacity)
    idx = 0
    temp[0] = val

    while idx < @count
      temp[idx + 1] = @store[idx]
      idx += 1
    end

    @store = temp


  end

  def pop
    temp_arr = StaticArray.new(capacity - 1)
    (0...temp_arr.length).each do |idx|
      temp_arr[idx] = @store[idx]
    end
    last_el = @store[@store.length - 1]
    @store = temp_arr
    last_el
  end

  def shift
  end

  def first
  end

  def last
  end

  def each
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_array = StaticArray.new(capacity * 2)

    (0...@store.length).each do |idx|
      new_array[idx] = @store[idx]
    end

    @store = new_array

  end
end
