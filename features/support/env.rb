require 'stdd-api'

Before do
@stdd_url = "http://localhost:3000"
@stdd_api = STDDAPI.new(@stdd_url,nil)
random_string = (0...8).map { (65 + rand(26)).chr }.join
@customer_name = "Learningwell" + "_#{random_string}"
random_string = (0...8).map { (65 + rand(26)).chr }.join
@project_name = "Project"+"_#{random_string}"

random_string = (0...8).map { (65 + rand(26)).chr }.join
@run_name = "Run"+"_#{random_string}"
@source = "http://www.google.se"
@revision = "1.2"

random_string = (0...8).map { (65 + rand(26)).chr }.join
@module_name = "Project"+"_#{random_string}"
@module_type = ["cucumber","load"].sample
end

After do |scenario|
end


After do

end
