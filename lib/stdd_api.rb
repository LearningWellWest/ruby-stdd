require 'rubygems'
require 'cgi'
require 'uri'
require 'net/http'
require_relative 'objects'

module STDDAPI

  class Client
    include STDDAPI::Objects

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
        customer = Customer.new(response["name"])
        customer.id = response["_id"]
        return true, customer
      else
        return false, response
      end

    end

    def get_customer(customer_name)
      path = "/api/get_customer"
      path = add_params_to_path(path,{:name => customer_name})

      valid, response = http_get path

      
      if(valid)
        customer = Customer.new(response["name"]) if response["name"]
        customer.id = response["_id"] if response["_id"]
        return true, customer
      else
        return false, response
      end

    end

    def create_project customer_id, project_name
      project = Project.new(customer_id,project_name)
      path = "/api/create_project"
      valid, response = http_post path, project.to_json
      
      if(valid)
        project = Project.new(response["customerID"],response["name"])
        project.id = response["_id"]
        return true, project
      else
        return false, response
      end
    end

    def get_project(customer_id, project_name)

      path = "/api/get_project"
      path = add_params_to_path(path,{:customer_id => customer_id, :name => project_name})

      valid, response = http_get path
      
      if(valid)
        project = Project.new(response["customerID"],response["name"])
        project.id = response["_id"]
        return true, project
      else
        return false, response
      end

    end

    def create_run project_id,run_name,source,revision
      run = Run.new(project_id,run_name,source,revision)
      path = "/api/create_run"
      valid, response = http_post path, run.to_json
      
      if(valid)
        run = Run.new(response["projectID"],response["name"],response["source"],response["revision"])
        run.id = response["_id"]
        return true, run
      else
        return false, response
      end

      
    end
    
    def get_run(project_id, name)
      path = "/api/get_run"
      path = add_params_to_path(path,{:project_id => project_id, :name => name})

      valid, response = http_get path
      
      if(valid)
        run = Run.new(project_id,name)
        run.id = response["_id"]
        run.source = response["source"]
        if(response["revision"])
          run.revision = response["revision"]
        end
        return true, run
      else
        return false, response
      end

    end

    def create_module run_id, name, kind, start
      modl = Module.new(run_id,name,kind,start)
      path = "/api/create_module"
      valid, response = http_post path, modl.to_json
      
      if(valid)
        modl = Module.new(response["runID"],response["name"],response["kind"],response["startTime"])
        modl.id = response["_id"]
        stop_time = response["stopTime"]
        if(stop_time)
          modl.stop_time = stop_time
        end
        return true, modl
      else
        return false, response
      end
    end

    def update_module_stopTime(module_id,stop_time)
      path = "/api/update_module_stoptime"
      valid, response = http_post path, {"module_id" => module_id, "stop_time" => stop_time}.to_json
      
      if(valid)
        modl = Module.new(response["runID"],response["name"],response["kind"],response["startTime"])
        modl.id = response["_id"]
        stop_time = response["stopTime"]
        if(stop_time)
          modl.stop_time = stop_time
        end
        return true, modl
      else
        return false, response
      end
    end

    def create_feature feature
      path = "/api/create_feature"
      valid, response = http_post path, feature.to_json
      
      if(valid)
        id = response["_id"]
        if(id)
          return true, id
        end
      else
        return false, response
      end
    end 

    def create_scenario scenario
      path = "/api/create_scenario"
      valid, response = http_post path, scenario.to_json
      
      if(valid)
        id = response["_id"]
        if(id)
          return true, id
        end
      else
        return false, response
      end
    end 

    def add_step_to_scenario step
      path = "/api/add_step_to_scenario"
      valid, response = http_post path, step.to_json
      
      if(valid)
        success = response["success"]
        if(success)
          return true, success
        end
      else
        return false, response
      end
    end

    def add_embedding_to_scenario embedding
      path = "/api/add_embedding_to_scenario"
      valid, response = http_post path, embedding.to_json
      
      if(valid)
        success = response["success"]
        if(success)
          return true, success
        end
      else
        return false, response
      end
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
end

