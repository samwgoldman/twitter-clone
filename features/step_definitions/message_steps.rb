Given /^I post "([^"]*)"$/ do |message|
  fill_in "What's new?", :with => message
  click_button "Tell it!"
end

Then /^I should see the message "([^"]*)"$/ do |message|
  find("#messages > li").should have_content(message)
end
