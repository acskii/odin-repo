class PairNode
  attr_accessor :key, :value, :next_node
  
  def initialize(key, value, next_node= nil)
    @value = value
    @key = key
    @next_node = next_node
  end
  
  def to_s
    "Pair(#{key}=>#{value})"
  end
end