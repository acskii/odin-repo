require_relative 'node'

class Tree
  attr_reader :root

  def initialize(arr=[])
    @root = build_tree(arr)
  end

  def build_tree(arr)
    return nil unless arr.length > 0
    return nil unless arr.all? { |ele| ele.kind_of?(Integer) }

    sorted_arr = arr.uniq.sort  # Remove duplicates and sort

    build_actual_tree(sorted_arr, 0, sorted_arr.length - 1)
  end

  def pretty_print(node= @root, prefix= '', is_left= true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.val}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    inject(Node.new(value))
  end

  def delete(value)
    remove(@root, value)
  end

  def inorder
    ans = []
    _inorder(@root, ans)

    block_given? ? ans.each { |node| yield node } : ans
  end

  def postorder
    ans = []
    _postorder(@root, ans)

    block_given? ? ans.each { |node| yield node } : ans
  end

  def preorder
    ans = []
    _preorder(@root, ans)

    block_given? ? ans.each { |node| yield node } : ans
  end

  def rebalance
    arr = collect_nodes(@root).map { |node| node.val } 
    sorted_arr = arr.uniq.sort

    @root = build_tree(sorted_arr)
  end

  def balanced?
    (height(@root.left) - height(@root.right)).abs <= 1
  end

  def find(val)
    arr = collect_nodes(@root)

    arr.each do |node|
      return node if node.val == val
    end
    nil
  end

  def level_order
    return nil unless block_given?

    q = [@root]
    until q.empty?
      curr = q[0]
      q << curr.left if !curr.left.nil?
      q << curr.right if !curr.right.nil?
      yield q.shift
    end
  end

  def depth(node, curr= @root)
    return -1 if curr.nil?

    dist = -1
    return dist + 1 if node == curr

    dist = depth(node, curr.left)
    return dist + 1 if dist >= 0

    dist = depth(node, curr.right)
    return dist + 1 if dist >= 0

    return dist
  end

  def height(node= @root)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  private
  def build_actual_tree(arr, s, e)
    return nil if s > e

    mid = s + ((e - s) / 2)
    rootNode = Node.new(arr[mid])
    rootNode.left = build_actual_tree(arr, s, mid - 1)
    rootNode.right = build_actual_tree(arr, mid + 1, e)

    rootNode
  end

  def collect_nodes(node, arr=[])
    return if node.nil?
    
    arr << node if !node.nil?
    collect_nodes(node.left, arr)
    collect_nodes(node.right, arr)
    arr
  end

  def remove(node, value)
    return nil if node.nil?

    if value < node.val
      node.left = remove(node.left, value) 
    elsif value > node.val
      node.right = remove(node.right, value)
    else
      # Case 2: One child
      return node.right if node.left.nil? 
      return node.left if node.right.nil? 

      # Case 3: Two children
      min = find_min(node.right).val
      node.val = min
      node.right = remove(node.right, min)
    end
    node
  end

  def find_min(node)
    until node.left.nil?
      node = node.left
    end
    node
  end

  def inject(node, curr= @root)
    return if node == curr

    if node < curr
      curr.left = node if curr.left.nil?
      inject(node, curr.left) unless curr.left.nil?  
    else
      curr.right = node if curr.right.nil?
      inject(node, curr.right) unless curr.right.nil?  
    end
  end

  def _inorder(node, ans)
    return if node.nil?

    _inorder(node.left, ans)
    ans << node
    _inorder(node.right, ans)
  end

  def _postorder(node, ans)
    return if node.nil?

    _postorder(node.left, ans)
    _postorder(node.right, ans)
    ans << node
  end

  def _preorder(node, ans)
    return if node.nil?

    ans << node
    _preorder(node.left, ans)
    _preorder(node.right, ans)
  end
end