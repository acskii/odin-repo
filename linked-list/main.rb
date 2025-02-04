require_relative 'linked_list'

list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

puts list
list.prepend('owl')
puts list
puts list.size
puts list.head
puts list.tail
puts list.at(9)
puts list.at(0)
puts list.at(list.size-1)
puts list.at(3)
puts list.pop
puts list
puts list.contains?('snake')
puts list.contains?('snAke')
puts list.find('cat')
puts list.at(2)
puts list.find('tiger')

