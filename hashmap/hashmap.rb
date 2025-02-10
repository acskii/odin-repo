require_relative 'node'

class HashMap
  attr_reader :max_bucket_capacity

  def initialize
    @capacity = 0
    @factor = 0.75
    @buckets = []
    @max_bucket_capacity = 16
  end

  def set(key, value)
    extend_buckets
    hash_index = hash(key)
    bucket_index = index(hash_index)
    insert_pair(bucket_index, key, value)
  end

  def get(key)
    @buckets.each do |node|
      next if node.nil?

      node = key_in_linked(key, node)
      return node if !node.nil?
    end
    nil
  end

  def remove(key)
    @buckets.each_with_index do |node, index|
      next if node.nil?

      if node.key == key
        @buckets[index] = nil
        @capacity -= 1
        return node
      end

      node = remove_key_from_pair(key, node)
      return node if !node.nil?
    end
    nil
  end

  def has?(key)
    !get(key).nil?
  end

  def length
    @capacity
  end

  def clear
    @buckets.clear
  end

  def entries
    ans =[]
    @buckets.each do |node|
      next unless !node.nil?

      to_tail(node) do |pair|
        ans << [pair.key, pair.value]
      end
    end
    ans
  end

  def keys
    entries.map { |key, _| key }
  end

  def values
    entries.map { |_, value| value }
  end

  private
  def insert_pair(index, key, value)
    # Make sure index given is within range
    raise IndexError if index.negative? || index >= @max_bucket_capacity

    if @buckets[index].nil?
      # If no Node exists in current bucket, create one
      @buckets.insert(index, PairNode.new(key, value))
      @capacity += 1
    else
      # If a Node already exists
      if @buckets[index].key == key
        # Replace value if same key (update)
        @buckets[index].value = value
      else
        # Extend LinkedList if it is diff key, same hash
        tail = to_tail(@buckets[index])
        pair = PairNode.new(key, value)
        tail.next_node = pair
        @capacity += 1
      end
    end
  end 

  def remove_key_from_pair(key, pair)
    cur = pair
    next_node = cur.next_node

    while !next_node.nil?
      if next_node.key == key
        cur.next_node = next_node.next_node
        next_node.next_node = nil
        @capacity -= 1
        break
      end
      cur = cur.next_node
      next_node = cur.next_node
    end
    next_node
  end

  def to_tail(pair)
    return unless !pair.nil?

    cur = pair
    while !cur.next_node.nil? 
      yield cur if block_given?
      cur = cur.next_node
    end
    yield cur if block_given?
    cur
  end

  def key_in_linked(key, pair)
    raise TypeError if !pair.kind_of?(PairNode)

    cur = pair
    while !cur.nil? 
      return cur if cur.key == key
      cur = cur.next_node
    end
    nil
  end

  def extend_buckets
    return unless grow_buckets?

    @max_bucket_capacity += 16
  end

  def index(hash)
    hash % @max_bucket_capacity
  end

  def grow_buckets?
    @capacity >= (@max_bucket_capacity * @factor)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end
end
