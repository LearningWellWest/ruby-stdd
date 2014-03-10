require 'stdd-api'

Before do
@stdd_url = "http://localhost:3000"
@stdd_api = STDDAPI.new(@stdd_url,nil)
random_string = (0...8).map { (65 + rand(26)).chr }.join
@customer_name = "Learningwell" + "_#{random_string}"
random_string = (0...8).map { (65 + rand(26)).chr }.join
@project_name = "Project_+ "+"_#{random_string}"
end

After do |scenario|
end


After do

end
