require 'bigdecimal'

puts <<STRING
Numeric is the class from which all numbers in Ruby are derived.
Based on the value assigned to a variable that one of Numeric's subclasses are auto selected:
  num = 3 => #{3.class}
  num = 3.0 => #{3.0.class}
  num = 3.0r => #{3.0r.class}
  num = 3.0i => #{3.0i.class}
  num = BigDecimal("3000000000.000000001") => #{BigDecimal("3000000000.000000001").class}
  #{BigDecimal("3000000000.000000001").to_s("F")}

STRING

puts <<STRING
Basic arithmetic operators are defined in Numeric:
  Common: + - * / % == != > < ...
  Exponent: 5 ** 3 => #{5 ** 3}  
  Convert: to_i to_f to_r to_c to_s
  Func: abs round floor ceil sqrt even? odd? ...
  <=> (spaceship operator):
    1 <=> 2 => #{1 <=> 2}
    1 <=> 1 => #{1 <=> 1}
    2 <=> 1 => #{2 <=> 1}

STRING

puts <<STRING
Assign operators:
  += -= *= /= %= **=
  Or equal ( ||= ): x = x || 5
    x = nil, x ||= 5 => #{x = nil; x ||= 5; x } 
    x = 3, x ||= 5 => #{x = 3; x ||= 5; x }
  And equal ( &&= ): x = x && 5
    x = nil, x &&= 5 => #{x = nil; x &&= 5; x } ( nil )
    x = 3, x &&= 5 => #{x = 3; x &&= 5; x }
  
STRING

puts <<STRING
Boolean operators:
  && || ! ^ (and or not xor)
  !! operator:
    !true => #{!true}
    !!true => #{!!true}
    !!0 => #{!!0}
    !!1 => #{!!1}
    !!nil => #{!!nil}
    !!"" => #{!!""}
    !!"str" => #{!!"str"}
  Ternary: bool ? "yes" : "no" => #{true ? "yes" : "no"}

STRING
