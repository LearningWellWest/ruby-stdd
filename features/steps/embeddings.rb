When(/^I add (\d+) embeddings to each scenario$/) do |arg1|
	@embedding_responses = Array.new
	embedding_count = arg1.to_i

	@scenario_responses.each do |scenario_id|

		k =0
		until k >= embedding_count  do
			embedding = get_random_embedding(scenario_id)
			valid,response = @stdd_api.add_embedding_to_scenario(embedding)
			if(valid)
			  @embedding_responses << response
			else
			  fail(response)
			end
			k += 1
		end
	end
end

Then(/^I should success messages back on the embeddings$/) do
    @embedding_responses.each do |el|
	  	if(el.size>0)
	  		puts "Got: #{el}"
	  	else
	  		fail("Unknown error:#{el}")
	  	end
	end
end

def get_random_embedding scenario_id
	mime_type = "image/png"
	file_path = File.expand_path("../images/cucumber.png", __FILE__)
	puts "FILEPATH #{file_path}"
	buf = Base64.encode64(open(file_path,'rb') { |io| io.read })
    embedding=STDDAPI::Objects::Embedding.new(scenario_id,mime_type,buf)
    return embedding
end