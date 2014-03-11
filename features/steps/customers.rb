When(/^I create an customer$/) do
	valid, response = @stdd_api.create_customer @customer_name
	if valid
		@customer = response
	else
		fail(response)
	end
end

Given(/^the system has an customer$/) do
  create_customer_if_not_exists
end


When(/^I request the customer$/) do
  valid, response = @stdd_api.get_customer @customer_name
  if(valid)
  	@customer = response
  else
  	fail(response)
  end
end

Then(/^I should get the customer name and ID back$/) do
	puts "Got: #{@customer.to_s}"
	fail("no customer id") unless @customer.id
	fail("no customer name") unless @customer.name
end


def create_customer_if_not_exists
	# Kontrollera om kunden finns
	valid, response = @stdd_api.get_customer @customer_name

	# Om kunden finns
	if(valid && response)
		puts "Customer already exists"
		@customer = response
	else
		puts "Customer did not exist, creating new.."
		# Skapa en kund
		valid, response = @stdd_api.create_customer @customer_name
		# Om vi får en giltig respons
		if(valid)
			@customer = response
		else 
			fail(response.err)
		end
	end
end