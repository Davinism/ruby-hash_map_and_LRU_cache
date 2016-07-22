require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # my_link_pointer = returns_link_with_key(key)
    if @map.include?(key)
      link = @map[key]
      @store.remove(key)
      @store.insert(link.key, link.val)
      link.val
    else #adding new val
      val = @prc.call(key)
      new_link = Link.new(key, val)
      @store.insert(key, val)
      @map[key] = new_link

      if count > @max #removing oldest element from linked list cache
        removed_link_key = @store.first.key
        @store.remove(removed_link_key)
        @map.delete(removed_link_key)
      end
      val
    end

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
  end
end
