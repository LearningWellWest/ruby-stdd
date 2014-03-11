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
  fail("no project id") unless @project.id
  fail("no project name") unless @project.name
	fail("no customer id") unless @project.customer_id

	if @customer.id != @project.customer_id
		fail("Project customer-id does not match customer-id")
	end

end

Given(/^the customer has a project$/) do
  create_project_if_not_exists
end

When(/^I request the project$/) do
  @project = nil
  valid, response = @stdd_api.get_project @customer.id, @project_name
  if(valid)
    @project = response
  else
    fail(response)
  end
end


def create_project_if_not_exists
  # Kontrollera om projektet finns
  valid, response = @stdd_api.get_project @customer.id, @project_name

  # Om projektet finns
  if(valid && response)
    puts "Project already exists"
    @project = response
  else
    puts "Project did not exist, creating new.."
    # Skapa ett projekt
    valid, response = @stdd_api.create_project @customer.id, @project_name
    # Om vi får en giltig respons
    if(valid)
      @project = response
    else 
      fail(response)
    end
  end
end