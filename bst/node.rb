class Node
  include Comparable
  attr_accessor :val
  attr_reader :left, :right

  def initialize(val= 0, left= nil, right= nil)
    @val = val.to_s.to_i
    @left = left.kind_of?(Node) ? left : nil
    @right = right.kind_of?(Node) ? right : nil
  end

  def left=(node)
    @left = node.kind_of?(Node) ? node : nil
  end

  def right=(node)
    @right = node.kind_of?(Node) ? node : nil
  end

  def <=>(other)
    val <=> other.val
  end

  def to_s
    "Node(#{@val})"
  end
end
