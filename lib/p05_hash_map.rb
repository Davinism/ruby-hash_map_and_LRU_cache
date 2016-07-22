require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require "byebug"

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self.each do |k, _|
      return true if k == key
    end

    false
  end

  def set(key, val)
    resize! if @count == num_buckets
    found_key = false

    self.each do |k, v|
      if k == key
        bucket(k).remove(k)
        bucket(k).insert(key, val)
        found_key = true
      end
    end

    unless found_key
      @count += 1
      bucket(key).insert(key, val)
    end

  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    else
      nil
    end
  end

  def each(&prc)
    idx = 0
    until idx == num_buckets
      @store[idx].each do |link|
        prc.call(link.key, link.val)
      end
      idx += 1
    end

  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_hash = @store


    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    temp_hash.each do |list|
      list.each do |link|
        self.set(link.key, link.val)
      end
    end

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
