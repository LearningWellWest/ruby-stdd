require 'rubygems'
require 'cgi'
require 'uri'
require 'net/http'
require 'objects'


class STDDAPI

	def initialize(stdd_url,http_proxy=nil)
		@url = stdd_url ? stdd_url : 'http://www.stddtool.se'
    @proxy = http_proxy ? URI.parse('http://'+http_proxy) : OpenStruct.new
    @connection_error = nil
    @uri = URI.parse(@url)
	end

  def create_customer customer_name
    customer = Customer.new(customer_name)
    path = "/api/create_customer"
    valid, response = http_post path, customer.to_json
    
    if(valid)
      customer.id = response["_id"]
    else
      return false, response
    end

    return true, customer

  end

  def get_customer(customer_name)
    customer = Customer.new(customer_name)

    path = "/api/get_customer"
    path = add_params_to_path(path,{:name => customer.name})

    valid, response = http_get path
    
    if(valid)
      customer.id = response["_id"]
    else
      return false, response
    end

    return true, customer

  end

  def create_project customer_id, project_name
    project = Project.new(customer_id,project_name)
    path = "/api/create_project"
    valid, response = http_post path, project.to_json
    
    if(valid)
      project.id = response["_id"]
    else
      return false, response
    end

    return true, project
  end

  def get_project(customer_id, project_name)
    project = Project.new(customer_id,project_name)

    path = "/api/get_project"
    path = add_params_to_path(path,{:customer_id => project.customer_id, :name => project.name})

    valid, response = http_get path
    
    if(valid)
      project.id = response["_id"]
    else
      return false, response
    end

    return true, project

  end

  def create_run project_id,run_name,source,revision
    run = Run.new(project_id,run_name,source,revision)
    path = "/api/create_run"
    valid, response = http_post path, run.to_json
    
    if(valid)
      run.id = response["_id"]
    else
      return false, response
    end

    return true, run
  end
  
  def get_run(project_id, name)
    run = Run.new(project_id,name)

    path = "/api/get_run"
    path = add_params_to_path(path,{:project_id => run.project_id, :name => run.name})

    valid, response = http_get path
    
    if(valid)
      run.id = response["_id"]
      run.source = response["source"]
      if(response["revision"])
        run.revision = response["revision"]
      end
    else
      return false, response
    end

    return true, run

  end


  def http_post path,body
    begin
      http = Net::HTTP::Proxy(@proxy.host, @proxy.port).new(@uri.host, @uri.port)
      request = Net::HTTP::Post.new(path,initheader = { 'Content-Type' => 'application/json'})
      request.body = body
      response = http.request(request)
      case response.code
        when /20\d/
          #success
        else
          return false,response.body
      end
    rescue Exception => ex
      return false, ex
    end

    return true, JSON.parse(response.body)

  end

  def http_get path
    req = Net::HTTP::Get.new(path,)
    response = Net::HTTP::Proxy(@proxy.host, @proxy.port).new(@uri.host, @uri.port).start {|http| 
      http.request(req) 
    }
    case response.code
    when /20\d/
      #success
    else
      return false, response.body
    end

    parsed_response = JSON.parse(response.body)
    return true,parsed_response
  end






    def add_params_to_path (path, params)
      if(params)
        path = "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))
      end
      return path
    end
end

