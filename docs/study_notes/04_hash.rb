require 'json'

puts <<STRING
Create new hash syntax:
  #{{ "key1" => "value1", "key2" => "value2" }} # use String as key
  #{{ :key1 => "value1", :key2 => "value2" }} # use Symbol as key
  #{{ "key1": "value1", "key2": "value2" }} # use Symbol as key
  #{{ key1: "value1", key2: "value2" }} # use Symbol as key
  empty => #{Hash.new}
Default value:
  Hash.new("default value") => hash["key1"] => #{hash = Hash.new("default value"); hash["key1"]}
  Hash.new { |hash, key| hash[key] = "val of \#{key}" } => #{hash = Hash.new { |hash, key| hash[key] = "val of #{key}" }; nil}
    #{hash["key1"]}
    #{hash["key2"]}

STRING

hash = { :key => "val1", "key" => "val2" }
puts <<STRING
String and Symbol as key:
  hash => #{hash}
  hash[:key] => #{hash[:key]}  
  hash["key"] => #{hash["key"]}
  hash[:key.to_s] => #{hash[:key.to_s]}
  hash["key".to_sym] => #{hash["key".to_sym]}

JSON:
  hash.to_json => #{hash.to_json}
  JSON.parse(json_str) => #{JSON.parse(hash.to_json)}

STRING
