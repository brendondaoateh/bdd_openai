print "'print' prints content to console,"
print ' but with no newline'
print "\n"
puts "'puts' prints content to console like 'print'. But with newline."
puts

sam_var = 'abc'
puts 'Single quote ( \'\' ) strings are treated literally. Basically, as it is, no interpolation.
  They can be multiline also. No need for escape character: ", \n, \t, #{sam_var}, ...
  But exception are: ( \' ) and ( \\ ).'
puts %q{  %q{...} is another way to write single quote strings.}
puts

puts "Double quote ( \"\" ) strings are treated with interpolation. Ex: #{sam_var}.
  They can be multiline also."
puts %Q{  %Q{...} is another way to write double quote strings.}
puts

sam_var = `pwd`
puts "Backtick ( `` ) strings are treated as shell commands.
  Ex: sam_var = `pwd` will not print out 'pwd',
  But the current directory: #{sam_var}
"

sam_heredoc = <<HEREDOC
  Heredoc ( <<HEREDOC ) strings are treated as multiline strings.
    They can be single quote or double quote strings.
  And whitespace pre-pended each line is preserved.
HEREDOC
puts sam_heredoc
sam_heredoc = <<~ANYTHING
    But Heredoc ( <<~HEREDOC ) with ( ~ ) will remove all common pre-pended whitespace.
      So this line still have one leading whitespace.
    Also the can be anything. Just for readability.
ANYTHING
puts sam_heredoc
puts

str = 'abcdefghijklmnOPQRSTUVWXYZ'
puts <<STRING
String extraction method:
  str => #{str}
  str.length => #{str.length}
  str.size => #{str.size}
  Get by index:
    str[0] => #{str[0]}
    str[str.length-1] => #{str[str.length-1]}
    str[-1] => #{str[-1]}  
    str[-str.length] => #{str[-str.length]}  
    str[str.length] => #{str[str.length]} # nil, out of bound
    str[-str.length-1] => #{str[-str.length-1]} # nil, out of bound
  Get substring:
    str[0, 5] => #{str[0, 5]} # 5 characters from index 0
    str[0, 0] => #{str[0, 0]} # empty string
    str[0, -1] => #{str[0, -1]} # empty string
    str[5, str.length] => #{str[5, str.length]} # skip first 5 characters
    str[5, str.length+1] => #{str[5, str.length+1]} # same output if out of bound
    str[-5, str.length] => #{str[-5, str.length]} # last five characters
    str[0..5] => #{str[0..5]} # index 0 to index 5
    str[0...5] => #{str[0...5]} # index 0 to index 4
    str[9..0] => #{str[9..0]} # nil, doesn't work backward
    str[0..-9] => #{str[0..-9]} # -9 is the same as str.length-9
    str[0..str.length-1] => #{str[0..str.length-1]}

Get modification method:
  str.upcase => #{str.upcase}
  str.downcase => #{str.downcase}
  str.reverse => #{str.reverse}
  str + '123' => #{str + '123'}
  str.split('O') => #{str.split('O')}
  str.include?('OPQ') => #{str.include?('OPQ')}
  ...

STRING

puts <<STRING
Function that modified original string:
  str => #{'abc'}
  str.replace('def'); str => #{'abc'.replace('def')}
  str << '123'; str => #{('abc' << '123')}
  str.concat('123') => #{'abc'.concat('123')}
  str.prepend('123') => #{'abc'.prepend('123')}
  str.insert(1, '123') => #{'abc'.insert(1, '123')} 
  ...
To avoid modifying original string:
  Use 'str.dup' or 'str.clone' to create a copy.
  Or str.freeze to make it immutable, raised error on trying to modification.

STRING
