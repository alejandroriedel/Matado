#remember that variables start with lowercase or underscore

Given /^I open the game$/ do
	visit '/'
end


When /^I press "([^"]*)"$/ do |buttonName|
  click_button buttonName
end

Then /^I should see "(.*)"$/ do |text|
	last_response.body.should =~ /#{text}/m
end

Given /^I am in config game mode$/ do
	visit '/'
	click_button "CONFIGURAR"
end

When /^I enter "([^"]*)" into "([^"]*)"$/ do |word, field|
	fill_in(field, :with => word)
end

Given /^I start playing$/ do
	visit '/'
	click_button "CONFIGURAR"
	fill_in("wordToPlay", :with => "TEST")
	click_button "JUGAR"

end

Given /^The secret word is "([^"]*)" & I start playing$/ do |word|
	visit '/'
	click_button "CONFIGURAR"
	fill_in("wordToPlay", :with => word)
	click_button "JUGAR"
end

Then /^I should see an image related$/ do
  	pending # express the regexp above with the code you wish you had
end

Given /^I win the game playing with "([^"]*)"$/ do |word|
	visit '/'
	click_button "CONFIGURAR"
	fill_in("wordToPlay", :with => word)
	click_button "JUGAR"
	fill_in("letterAttempt", :with => "E")
	click_button "INTENTAR"
	fill_in("letterAttempt", :with => "R")
	click_button "INTENTAR"
end

Given /^I lose the game playing with "([^"]*)"$/ do |word|
	visit '/'
	click_button "CONFIGURAR"
	fill_in("wordToPlay", :with => word)
	click_button "JUGAR"
	fill_in("letterAttempt", :with => "F")
	click_button "INTENTAR"
	fill_in("letterAttempt", :with => "G")
	click_button "INTENTAR"
	if(word.length > 4)
		fill_in("letterAttempt", :with => "J")
		click_button "INTENTAR"
		if(word.length > 6)
			fill_in("letterAttempt", :with => "K")
			click_button "INTENTAR"
			if(word.length > 7)
				fill_in("letterAttempt", :with => "L")
				click_button "INTENTAR"
			end
		end
	end
end
