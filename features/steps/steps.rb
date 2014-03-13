When(/^I add (\d+) steps to each scenario$/) do |arg1|

	@step_responses = Array.new
	@scenario_count = arg1.to_i
   	@scenario_responses.each do |scenario_id|

		k =0
		until k >= @scenario_count  do
			scenario = get_random_step(scenario_id)
			valid,response = @stdd_api.add_step_to_scenario(scenario)
			if(valid)
			  @step_responses << response
			else
			  fail(response)
			end
			k += 1
		end
	end
end

Then(/^I should get a success message back$/) do
    @step_responses.each do |el|
  	if(el.size>0)
  		puts "Got: #{el}"
  	else
  		fail("Unknown error:#{el}")
  	end

  end
end

def get_random_step scenario_id
	keyword = ["Givet","När","Och","Så"].sample
	step = Step.new(scenario_id,keyword, get_random_step_name)
	step.status=['passed','failed','skipped','pending'].sample
	if(step.status == 'failed')
		step.error_message = "HURR DURR EXCEPTION:StandardError hurr:3:4 durr"
	end
	step.messages =["step message","another step message"]
	step.duration = (Time.now+rand(10))-Time.now# +0-10 sec
	return step
end

def get_random_step_name
	random_string = (0...8).map { (65 + rand(26)).chr }.join
	return "step"+"_#{random_string}"
end