When(/^I create (\d+) features for the module$/) do |arg1|
	@feature_responses = Array.new

	feature_count = arg1.to_i
	k =0
	until k >= feature_count  do
		feature = get_random_feature(@module.id)
		valid,response = @stdd_api.create_feature(feature)
		if(valid)
		  @feature_responses << response
		else
		  fail(response)
		end
		k += 1
	end

end

Then(/^I should get the feature ids back each creation$/) do
  @feature_responses.each do |el|
  	if(el.size>0)
  		puts "Got id: #{el}"
  	else
  		fail("Did not get id back")
  	end

  end
end


def get_random_feature module_id
	feature = Feature.new(module_id,get_random_feature_name,Time.now)
	feature.description = "This is the feature description"
	feature.tags = ["@hurr","@durr","@thisIsATag"]
	feature.file = "files/file.feature"
	return feature
end

def get_random_feature_name
	random_string = (0...8).map { (65 + rand(26)).chr }.join
	return "Feature"+"_#{random_string}"
end