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
	end

  def create_customer customer_name
    customer = Customer.new(customer_name)
    uri = URI.parse(@url)

    begin
      http = Net::HTTP::Proxy(@proxy.host, @proxy.port).new(uri.host, uri.port)
      request = Net::HTTP::Post.new("/api/create_customer",initheader = { 'Content-Type' => 'application/json'})
      request.body = {"name" => customer.name}.to_json
      response = http.request(request)
      case response.code
        when /20\d/
          #success
        else
          @connection_error = response.body
      end

    parsed = JSON.parse(response.body)
    if parsed["error"]
      @connection_error = parsed["error"]
    else
      customer.id = parsed["_id"]
    end

    rescue Exception => ex
      @connection_error = ex
    end

    if(@connection_error)
      return false, @connection_error if @connection_error
    else
      return true, customer
    end

  end

    def get_customer(customer_name)
      customer = Customer.new(customer_name)

      uri = URI.parse(@url)

      path = "/api/get_customer"
      path = add_params_to_path(path,{:name => customer.name})

      req = Net::HTTP::Get.new(path,)
      response = Net::HTTP::Proxy(@proxy.host, @proxy.port).new(uri.host, uri.port).start {|http| 
        http.request(req) 
      }

      parsed = JSON.parse(response.body)
      
      if(parsed["_id"])
        customer.id = parsed["_id"]
      else
        customer = create_customer(customer.name)
      end

      return true, customer

    end

    def add_params_to_path (path, params)
      if(params)
        path = "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))
      end
      return path
    end
end






# class Error
#   def initialize (message)
#     @err = true
#     @message = message
#   end

#   attr_accessor :err,:message
# end

