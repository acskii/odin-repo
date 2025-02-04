class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node= nil)
    @value = value
    @next_node = next_node
  end

  def to_s
    "Node(#{value})"
  end
end

class LinkedList
  attr_reader :size, :head, :tail

  def initialize(node= nil)
    @head = @tail = node
    @size = 0
  end

  def prepend(value)  
    node = Node.new(value)
    node.next_node = @head
    @head = node

    @tail = @head if @tail.nil?
    @size += 1
  end

  def append(value)
    node = Node.new(value)
    
    if @head.nil?
      @head = @tail = node
    else
      @tail.next_node = node
      @tail = node
    end
    @size += 1
  end

  def at(index)
    return nil unless index.between?(0, @size)
    res = @head

    index.times do |_|
      res = res.next_node
    end
    res
  end

  def pop
    new_tail = @head

    (@size - 2).times do |_|
      new_tail = new_tail.next_node
    end

    new_tail.next_node = nil
    old_tail = @tail
    @tail = new_tail

    old_tail
  end

  def contains?(value)
    cur = @head
    @size.times do |_|
      break if cur.nil?
      return true if cur.value == value

      cur = cur.next_node
    end
    false
  end

  def find(value)
    cur = @head

    @size.times do |index|
      break if cur.nil?
      return index if cur.value == value

      cur = cur.next_node
    end
    nil
  end

  def to_s
    cur = @head
    s = ''

    while cur != nil
      s << "( #{cur.value} )"

      s << ' -> ' if !cur.next_node.nil?
      cur = cur.next_node
    end
    s + ' -> nil'
  end
end