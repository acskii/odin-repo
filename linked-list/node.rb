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
