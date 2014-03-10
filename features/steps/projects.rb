When(/^I create a project for the customer$/) do
  valid,response = @stdd_api.create_project(@customer.id,@project_name)
  if(valid)
  	@project = response
  else
  	fail(response)
  end
end

Then(/^I should get the project name, ID and customer ID back$/) do
  	puts "Got: #{@project.to_s}"
  	
	fail("no customer id") unless @project.customer_id

	if @customer.id != @project.customer_id
		fail("Project customer-id does not match customer-id")
	end

	fail("no project name") unless @project.name
end

Given(/^the system has an customer$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^the customer has a project$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I request the project$/) do
  pending # express the regexp above with the code you wish you had
end
