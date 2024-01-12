# Class inheritance:
class Fish
  @@scientific_name = 'Vertebrata'
  def self.scientific_name
    @@scientific_name
  end

  def self.eat
    "eat algae"
  end

  attr_reader :weight

  def initialize
    @weight = 'light'
  end

  def can_swim?
    true
  end

  def swim
    "swim"
  end
end

class Shark < Fish
  @@scientific_name = 'Selachimorpha'

  def initialize
    super
    @weight = 'heavy'
  end

  def self.eat
    "eat fish"
  end

  # override and super
  def swim
    super + " faster!"
  end
end

a_fish = Fish.new
a_shark = Shark.new
puts <<STRING
Class variables is shared:
  Fish.scientific_name => #{Fish.scientific_name}  
  Shark.scientific_name => #{Shark.scientific_name}
Class methods:
  Fish.eat => #{Fish.eat}
  Shark.eat => #{Shark.eat}

Instance variables:
  a_fish.weight => #{a_fish.weight}
  a_shark.weight => #{a_shark.weight}
Instance methods:
  a_fish.swim => #{a_fish.swim}
  a_shark.swim => #{a_shark.swim}
  a_shark.can_swim? => #{a_shark.can_swim?}

STRING
