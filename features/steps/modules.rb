When(/^I create a module for the run$/) do
  valid,response = @stdd_api.create_module(@run.id,@module_name,@module_type,@module_start)
  if(valid)
  	@module = response
  else
  	fail(response)
  end
end

Then(/^I should get the module name, ID, type, start\-time and run\-ID back$/) do
	puts "Got: #{@module.to_s}"
	fail("no module name") unless @module.name
	fail("no module id") unless @module.id
	fail("no module type") unless @module.type
	fail("no module start-time") unless @module.start_time
	fail("no module run-id") unless @module.run_id

	if @run.id != @module.run_id
		fail("Module run-id does not match run-id")
	end
end

When(/^I update the module stop\-time$/) do
  valid,response = @stdd_api.update_module_stopTime(@module.id,Time.now)
  if(valid)
  	@module = response
  else
  	fail(response)
  end
end

Then(/^I should get the module name, ID, type, start\-time, stop\-time and run\-ID back$/) do
	puts "Got: #{@module.to_s}"
	fail("no module name") unless @module.name
	fail("no module id") unless @module.id
	fail("no module type") unless @module.type
	fail("no module start-time") unless @module.start_time
	fail("no module stop-time") unless @module.stop_time
	fail("no module run-id") unless @module.run_id

	if @run.id != @module.run_id
		fail("Module run-id does not match run-id")
	end
end