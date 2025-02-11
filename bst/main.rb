require_relative 'bst'

tree = Tree.new(Array.new(5) { rand(1..100) })
tree.pretty_print
puts tree.balanced?
puts 'Level Order'
tree.level_order { |node| print "#{node}, " }
puts ''
puts 'In Order'
tree.inorder { |node| print "#{node}, " }
puts ''
puts 'Pre Order'
tree.preorder { |node| print "#{node}, " }
puts ''
puts 'Post Order'
tree.postorder { |node| print "#{node}, " }
puts ''
tree.insert(100)
tree.insert(203)
tree.insert(111)
tree.insert(120)
puts tree.balanced?
tree.rebalance
puts tree.balanced?
tree.pretty_print
puts 'Level Order'
tree.level_order { |node| print "#{node}, " }
puts ''
puts 'In Order'
tree.inorder { |node| print "#{node}, " }
puts ''
puts 'Pre Order'
tree.preorder { |node| print "#{node}, " }
puts ''
puts 'Post Order'
tree.postorder { |node| print "#{node}, " }
puts ''