When(/^I create (\d+) scenarios for the feature$/) do |arg1|
  	@feature_id = @feature_responses[0]
  	@scenario_responses = Array.new

	scenario_count = arg1.to_i
	k =0
	until k >= scenario_count  do
		scenario = get_random_scenario(@feature_id)
		valid,response = @stdd_api.create_scenario(scenario)
		if(valid)
		  @scenario_responses << response
		else
		  fail(response)
		end
		k += 1
	end
end

Then(/^I should get the scenario ids back each creation$/) do
  @scenario_responses.each do |el|
  	if(el.size>0)
  		puts "Got id: #{el}"
  	else
  		fail("Did not get id back")
  	end

  end
end

def get_random_scenario feature_id
	scenario = Scenario.new(feature_id, get_random_scenario_name,'scenario','Scenario')
	scenario.tags=["@hurr","@durr","@scenariotag"]
	return scenario
end

def get_random_scenario_name
	random_string = (0...8).map { (65 + rand(26)).chr }.join
	return "scenario"+"_#{random_string}"
end