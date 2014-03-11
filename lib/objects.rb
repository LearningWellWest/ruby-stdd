
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
  def to_s
    "name: #{@name}, customer_id: #{@customer_id}, id: #{@id}"
  end
  def to_json
    {'name' => @name,'customer_id' => customer_id}.to_json
  end
end

class Run
  def initialize(project_id,name,source="",revision="")
    @project_id = project_id
    @name = name
    @source = source
    @revision = revision

  end
  attr_accessor :name,:id,:project_id,:source,:revision
  def to_s
    "name: #{@name}\n"+
    "id: #{@id}\n"+
    "project-id: #{@project_id}\n"+
    "source: #{@source}\n"+
    "revision: #{@revision}\n"
  end
  def to_json
    {
      'name' => @name,
      'project_id' => @project_id,
      'source'=> @source,
      'revision'=>@revision
    }.to_json
  end
end