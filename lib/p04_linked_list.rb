class Link

  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    self.each do |link|
      return true if link.key == key
    end
    false
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    new_link.prev = @tail.prev
    new_link.next = @tail
    @tail.prev.next = new_link
    @tail.prev = new_link
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.next.prev = link.prev
        link.prev.next = link.next
      end
    end
    nil
  end

  def each(&prc)
    initial_link = @head.next

    until initial_link == @tail
      prc.call(initial_link)
      initial_link = initial_link.next
    end


  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
