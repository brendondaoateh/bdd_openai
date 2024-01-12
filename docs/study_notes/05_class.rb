class SamObj
  attr_reader :instance_readable_var
  attr_writer :instance_writable_var
  attr_accessor :instance_readwrite_var

  # constructor
  def initialize
    # Instance variables
    @instance_private_var = "sam_instant_private_var"
    @instance_readable_var = "sam_instant_readable_var"
    @instance_writable_var = "sam_instant_writable_var"
    @instance_readwrite_var = "sam_instant_readwrite_var"
  end

  # Instance method
  def get_inst_vars
    [@instance_private_var, @instance_readable_var, @instance_writable_var, @instance_readwrite_var]
  end

  @@class_var = "sam_class_var"

  # Class method, getter for @@class_var
  def self.class_var
    @@class_var
  end

  # Class method, setter for @@class_var
  def self.class_var=(new_value)
    @@class_var = new_value
  end

  # Class method also
  class << self
    attr_accessor :class_var_2
    def class_med_2
      "this is class_med_2"
    end
  end
end

obj1 = SamObj.new
puts <<STRING
Instance method:
  obj1.get_inst_vars => #{obj1.get_inst_vars}

Instance variables are private by default:
  obj1.instance_variables_defined?("@instance_private_var") => #{obj1.instance_variable_defined?("@instance_private_var")}
  obj1.respond_to?("instance_private_var") => #{obj1.respond_to?("instance_private_var")}
  obj1.instance_private_var => NoMethodError
Read only:
  obj1.instance_readable_var => #{obj1.instance_readable_var}
  obj1.instance_readable_var = "new value" => NoMethodError
Write only:
  obj1.instance_writable_var => NoMethodError
  obj1.instance_writable_var = "new value" => #{obj1.instance_writable_var = "new value"}
Read and write:
  obj1.instance_readwrite_var = "new value" => #{obj1.instance_readwrite_var = "new value"}
  obj1.instance_readwrite_var => #{obj1.instance_readwrite_var}

STRING

puts <<STRING
Class variables:
  SamObj.class_var => #{SamObj.class_var}
  SamObj.class_var = "new value" => #{SamObj.class_var = "new value"}
  SamObj.class_var => #{SamObj.class_var}
  SamObj.class_var_2 = "new value" => #{SamObj.class_var_2 = "new value"}
  SamObj.class_var_2 => #{SamObj.class_var_2}
  SamObj.class_med_2 => #{SamObj.class_med_2}

STRING



class InitOrderObj
  attr_reader :var1, :var2, :var3
  def initialize(var1, var2, var3 = "def_val")
    @var1 = var1
    @var2 = var2
    @var3 = var3
  end
end
init_order_obj = InitOrderObj.new("val1", "val2")
puts <<STRING
Init param by order:
  obj = InitOrderObj.new("var1", "var2")
  obj.var1 => #{init_order_obj.var1}
  obj.var2 => #{init_order_obj.var2}
  obj.var3 => #{init_order_obj.var3}

STRING

class InitKeyObj
  attr_reader :var1, :var2
  def initialize(key1: , key2: 'def')
    @var1 = key1
    @var2 = key2
  end
end
init_key_obj = InitKeyObj.new(key1: "val1")
puts <<STRING
Init param by key:
  obj = InitKeyObj.new(key1: "val1")
  obj.var1 => #{init_key_obj.var1}
  obj.var2 => #{init_key_obj.var2}
  InitKeyObj.new => error: missing argument "key1"
  InitKeyObj.new(key1: "val1", key0: "val0") => error: unknown keyword "key0"

STRING

class InitFreeObj
  attr_reader :var1, :var2
  def initialize(**args)
    @var1 = args[:key1]
    @var2 = args.fetch(:key2, 'def_val')
  end
end
init_free_obj = InitFreeObj.new(key1: "val1", key0: "val0")
puts <<STRING
Init param by unrestricted key:
  obj = InitFreeObj.new(key1: "val1", key0: "val0") => no error on "key0"
  obj.var1 => #{init_free_obj.var1}
  obj.var2 => #{init_free_obj.var2}

STRING
