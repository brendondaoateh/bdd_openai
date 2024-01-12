puts <<STRING
Create new array syntax:
  [1, 2, 3] => #{[1, 2, 3]}
  Array.new => #{Array.new}
  Array.new(3) => #{Array.new(3)}
  Array.new(3, 0) => #{Array.new(3, 0)}
  Array.new(3) { |i| i + 1 } => #{Array.new(3) { |i| i + 1 }}

STRING

arr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
puts <<STRING
Access array element:
  arr => #{arr}
  arr.length => #{arr.length}
  arr.size => #{arr.size}
  Get by index:
    arr[0] => #{arr[0]}
    arr[arr.length-1] => #{arr[arr.length-1]}
    arr[-1] => #{arr[-1]}  
    arr[-arr.length] => #{arr[-arr.length]}  
    arr[arr.length] => #{arr[arr.length]} # nil, out of bound
    arr[-arr.length-1] => #{arr[-arr.length-1]} # nil, out of bound
  Get subarring:
    arr[0, 5] => #{arr[0, 5]} # 5 characters from index 0
    arr[0, 0] => #{arr[0, 0]} # empty array
    arr[0, -1] => #{arr[0, -1]} # empty array
    arr[5, arr.length] => #{arr[5, arr.length]} # skip first 5 characters
    arr[5, arr.length+1] => #{arr[5, arr.length+1]} # same output if out of bound
    arr[-5, arr.length] => #{arr[-5, arr.length]} # last five characters
    arr[0..5] => #{arr[0..5]} # index 0 to index 5
    arr[0...5] => #{arr[0...5]} # index 0 to index 4
    arr[4..0] => #{arr[4..0]} # nil, doesn't work backward
    arr[0..-4] => #{arr[0..-4]} # -9 is the same as arr.length-9
    arr[0..arr.length-1] => #{arr[0..arr.length-1]}

STRING

puts <<STRING
Add:
  arr => #{arr = [1, 2, 3, 4, 5]; arr}
  arr << 6 => #{arr << 6; arr}
  arr.push(7) => #{arr.push(7); arr}
Delete:
  arr => #{arr = [1, 2, 3, 4, 5]; arr}
  arr.pop => #{arr.pop; arr}
  arr.delete_at => #{arr.delete_at(0); arr}
Other methods: empty? include? reverse reverse! sort sort! uniq uniq! ...
  arr.reverse => return new copy
  arr.reverse! => reverse in place

STRING

puts "Loop syntax:"
names = %w[Alice Bob Charlie]
print "Each loop: "
names.each do |name|
  print name + ", "
end
puts
print "For loop: "
for name in names
  print name + ", "
end
puts
