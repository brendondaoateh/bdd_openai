class ClassBase
  def who
    "class_base"
  end
end

module ModuleA
  def who
    "module_a"
  end
end

class ClassA < ClassBase
  include ModuleA
  def who
    "class_a"
  end
end
puts <<STRING
ClassA.ancestors => #{ClassA.ancestors}
ClassA.new.who => #{ClassA.new.who}

STRING

module ModuleB
  def who
    "module_b"
  end
end

class ClassB < ClassBase
  prepend ModuleB
  def who
    "class_b"
  end
end
puts <<STRING
ClassB.ancestors => #{ClassB.ancestors}
ClassB.new.who => #{ClassB.new.who}

STRING

module ModuleC
  def who
    "module_c"
  end
end

class ClassC < ClassBase
  extend ModuleC
  def who
    "class_c"
  end
end
puts <<STRING
ClassC.ancestors => #{ClassC.ancestors}
ClassC.new.who => #{ClassC.new.who}
ClassC.who => #{ClassC.who}

STRING

module ModuleD
  def self.included(base)
    puts "This trigger when ModuleD is included in #{base}"
    base.extend(ClassMethods)
  end

  def instance_method
    "Hello, World!"
  end

  module ClassMethods
    def class_method
      "Hello, Class!"
    end
  end
end

class ClassD
  include ModuleD
end
puts <<STRING
  ClassD.class_method => #{ClassD.class_method}
  ClassD.new.instance_method => #{ClassD.new.instance_method}
STRING
