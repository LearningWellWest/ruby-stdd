When(/^I create a run for the project$/) do
  valid,response = @stdd_api.create_run(@project.id,@run_name,@source,@revision)
  if(valid)
  	@run = response
  else
  	fail(response)
  end
end

Then(/^I should get the run name, ID, source and project ID back$/) do
	puts "Got: #{@run.to_s}"
	fail("no run id") unless @run.id
	fail("no run name") unless @run.name
	fail("no run source") unless @run.source
	fail("no project id") unless @run.project_id

	if @project.id != @run.project_id
		fail("Run project-id does not match project-id")
	end
end


Given(/^the project has a run with a specific name$/) do
  create_run_if_not_exists
end

When(/^I request the run by name$/) do
  @run = nil
  valid, response = @stdd_api.get_run @project.id, @run_name
  if(valid)
    @run = response
  else
    fail(response)
  end
end

def create_run_if_not_exists
  # Check if run exists
  valid, response = @stdd_api.get_run @project.id, @run_name

  # Om projektet finns
  if(valid && response)
    puts "Run already exists"
    @run = response
  else
    puts "Run did not exist, creating new.."
    # Create run
    valid, response = @stdd_api.create_run(@project.id,@run_name,@source,@revision)
    # If valid response
    if(valid)
      @run = response
    else 
      fail(response)
    end
  end
end