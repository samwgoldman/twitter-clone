Given /^I am signed in$/ do
  User.new("test", "password").save
  visit "/"
  fill_in "Username", :with => "test"
  fill_in "Password", :with => "password"
  click_button "Sign in"
end
