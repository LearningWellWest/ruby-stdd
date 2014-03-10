
class Customer
  def initialize(name)
    @name = name
  end
  attr_accessor :name,:id
  def to_s
    "name: #{@name}, id: #{@id}"
  end
  def to_json
    {'name' => @name}.to_json
  end
end

class Project
  def initialize(customer_id,name)
    @name = name
    @customer_id = customer_id
  end
  attr_accessor :name,:id,:customer_id
  def to_json
    {'name' => @name,'customer_id:' => customer_id}.to_json
  end
end

class Run
  def initialize(name)
    @name = name
    @start_time = Time.now
  end
  attr_accessor :name,:ID
  def to_json
    {'name' => @name,'start_time' => @start_time}.to_json
  end
end