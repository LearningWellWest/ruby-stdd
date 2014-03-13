
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

class Module
  def initialize(run_id,name,kind,start_time)
    @run_id = run_id
    @name = name
    @kind = kind
    @start_time = start_time

  end
  attr_accessor :name,:id,:run_id,:kind,:start_time,:stop_time
  def to_s
    "name: #{@name}\n"+
    "id: #{@id}\n"+
    "run-id: #{@run_id}\n"+
    "kind: #{@kind}\n"+
    "start-time: #{@start_time}\n"
  end
  def to_json
    {
      'name' => @name,
      'run_id' => @run_id,
      'kind' => @kind,
      'start_time'=> @start_time,
      'stop_time'=>@stop_time
    }.to_json
  end
end

class Feature
  def initialize(module_id,name,date)
    @module_id = module_id
    @name = name
    @date = date
  end
  attr_accessor :name,:id,:module_id,:date,:description,:tags,:file
  def to_s
    "name: #{@name}\n"+
    "id: #{@id}\n"+
    "module-id: #{@module_id}\n"+
    "date: #{@date}\n"+
    "description: #{@description}\n"+
    "tags: #{@tags}\n"+
    "file: #{@file}\n"
  end
  def to_json
    {
      'name' => @name,
      'module_id' => @module_id,
      'date'=>@date,
      'description'=>@description,
      'tags'=>@tags,
      'file'=>@file
    }.to_json
  end
end

class Feature
  def initialize(module_id,name,date)
    @module_id = module_id
    @name = name
    @date = date
    @tags = []
  end
  attr_accessor :name,:id,:module_id,:date,:description,:tags,:file
  def to_s
    "name: #{@name}\n"+
    "id: #{@id}\n"+
    "module-id: #{@module_id}\n"+
    "date: #{@date}\n"+
    "description: #{@description}\n"+
    "tags: #{@tags}\n"+
    "file: #{@file}\n"
  end
  def to_json
    {
      'name' => @name,
      'module_id' => @module_id,
      'date'=>@date,
      'description'=>@description,
      'tags'=>@tags,
      'file'=>@file
    }.to_json
  end
end
class Scenario
  def initialize(feature_id, name,element_type,keyword)
    @feature_id = feature_id
    @name = name
    @element_type = element_type
    @keyword = keyword
    @tags = []
    @steps = []
  end
  attr_accessor :feature_id,:keyword,:tags,:name,:element_type,:steps,:id
  def to_json
    {'feature_id' => @feature_id,
      'keyword' => @keyword,
      'name' => @name,
      'tags' => @tags,
      'element_type' => @element_type,
      'steps'=>@steps
     }.to_json
  end
end

class Step
  def initialize(scenario_id,keyword, name)
    @keyword=keyword
    @name=name
    @scenario_id = scenario_id
  end
  attr_accessor :keyword,:name,:status,:messages,:error_message,:duration,:scenario_id
  def to_json
    {
    'scenario_id'=>scenario_id,
    'keyword' => @keyword,
    'name' => @name ,
    'result' => {
      'status' =>@status,
      'error_message'=> @error_message,
      'duration'=>@duration
    },
    'messages' => @messages
    }.to_json
  end
end